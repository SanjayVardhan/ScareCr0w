#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_FILES 16
#define MAX_NAME 32
#define MAX_DATA 64

struct file {
    int refcount;
    int data_len;
    char *data;
    char name[MAX_NAME];
    void (*close_func)(struct file *);
    void (*read_func)(struct file *, int);
    void (*write_func)(struct file *, int, char *);
    void (*dup_func)(struct file *);
};

struct file *files[MAX_FILES];

void ctf_file_close(struct file *f) {
    if (f->refcount > 0) {
        f->refcount--;
    }
    if (f->refcount == 0) {
        free(f->data);
        free(f);
    }
}

void ctf_file_read(struct file *f, int n) {
    if (n > f->data_len) {
        n = f->data_len;
    }
    printf("Reading %d bytes from %s:\n", n, f->name);
    fwrite(f->data, 1, n, stdout);
    printf("\n");
}

void ctf_file_write(struct file *f, int n, char *s) {
    if (n > MAX_DATA) {
        n = MAX_DATA;
    }
    if (n > f->data_len) {
        f->data = realloc(f->data, n);
        f->data_len = n;
    }
    memcpy(f->data, s, n);
    printf("Writing %d bytes to %s\n", n, f->name);
}

void ctf_file_dup(struct file *f) {
    f->refcount++;
    printf("Duplicating %s\n", f->name);
}

struct file *create_file(char *name) {
    struct file *f = calloc(1, sizeof(struct file));
    f->refcount = 1;
    f->data_len = 0;
    f->data = NULL;
    strncpy(f->name, name, MAX_NAME - 1);
    f->close_func = ctf_file_close;
    f->read_func = ctf_file_read;
    f->write_func = ctf_file_write;
    f->dup_func = ctf_file_dup;
    return f;
}

int find_empty_slot() {
    for (int i = 0; i < MAX_FILES; i++) {
        if (files[i] == NULL) {
            return i;
        }
    }
    return -1;
}

int find_file_by_name(char *name) {
    for (int i = 0; i < MAX_FILES; i++) {
        if (files[i] != NULL && strcmp(files[i]->name, name) == 0) {
            return i;
        }
    }
    return -1;
}

void create(char *name) {
    int slot = find_empty_slot();
    if (slot == -1) {
        printf("No more slots available\n");
        return;
    }
    struct file *f = create_file(name);
    files[slot] = f;
    printf("Created file %s at slot %d\n", name, slot);
}

void close(char *name) {
    int slot = find_file_by_name(name);
    if (slot == -1) {
        printf("No such file %s\n", name);
        return;
    }
    struct file *f = files[slot];
    f->close_func(f);
    printf("Closed file %s at slot %d\n", name, slot);
}

void dup(char *name) {
    int slot = find_file_by_name(name);
    if (slot == -1) {
        printf("No such file %s\n", name);
        return;
    }
    struct file *f = files[slot];
    f->dup_func(f);
}

void read(char *name, int n) {
    int slot = find_file_by_name(name);
    if (slot == -1) {
        printf("No such file %s\n", name);
        return;
    }
    struct file *f = files[slot];
    f->read_func(f, n);
}

void write(char *name, int n, char *s) {
    int slot = find_file_by_name(name);
    if (slot == -1) {
        printf("No such file %s\n", name);
        return;
    }
    struct file *f = files[slot];
    f->write_func(f, n, s);
}

void menu() {
    printf("Welcome to the CTF file manager\n");
    printf("Commands:\n");
    printf("create <name>\n");
    printf("close <name>\n");
    printf("dup <name>\n");
    printf("read <name> <n>\n");
    printf("write <name> <n> <data>\n");
    printf("quit\n");
}

void handle_command(char *cmd) {
    char *name, *data;
    int n;
    if (sscanf(cmd, "create %ms", &name) == 1) {
        create(name);
        free(name);
    } else if (sscanf(cmd, "close %ms", &name) == 1) {
        close(name);
        free(name);
    } else if (sscanf(cmd, "dup %ms", &name) == 1) {
        dup(name);
        free(name);
    } else if (sscanf(cmd, "read %ms %d", &name, &n) == 2) {
        read(name, n);
        free(name);
    } else if (sscanf(cmd, "write %ms %d %ms", &name, &n, &data) == 3) {
        write(name, n, data);
        free(name);
        free(data);
    } else if (strcmp(cmd, "quit") == 0) {
        exit(0);
    } else {
        printf("Invalid command\n");
    }
}

int main() {
    setvbuf(stdout, NULL, _IONBF, 0);
    char cmd[256];
    menu();
    while (1) {
        printf("> ");
        fgets(cmd, sizeof(cmd), stdin);
        cmd[strcspn(cmd, "\n")] = 0;
        handle_command(cmd);
    }
    return 0;
}
    