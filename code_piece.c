char* read_file(char* file_name, int* binary_size) {
    FILE* file = fopen(file_name, "rb");
    fseek(file, 0, SEEK_END);
    *binary_size = ftell(file);
    fseek(file, 0, SEEK_SET);
    char* content = (char*)malloc((*binary_size) * sizeof(char));
    if (content == NULL) {
        fprintf(stderr, "malloc memory fail\n");
        *binary_size = 0;
        return content;
    }
    int read_size = fread(content, 1, *binary_size, file);
    return content;
}
