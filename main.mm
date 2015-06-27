#define SSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

void usage(void);
void printFile(char *file, BOOL shouldPrintFilename);

int main(int argc, char **argv, char **envp) {
    if (argc < 2) {
        usage();
        exit(-1);
    }

    for (int i = 1; i < argc; i++) {
        printFile(argv[i], argc > 2);
    }

	return 0;
}

void usage(void) {
    SSLog(@"PLister usage: plister file");
}

void printFile(char *file, BOOL shouldPrintFilename) {
    NSString *pathToPlist = [NSString stringWithUTF8String:file];
    NSDictionary *plistContents;

    if (![[NSFileManager defaultManager] fileExistsAtPath:pathToPlist]) {
        SSLog(@"PLister: %@: No such file", pathToPlist);
        exit(-1);
    }

    plistContents = [NSDictionary dictionaryWithContentsOfFile:pathToPlist];

    if (!plistContents) {
        SSLog(@"PLister %@: Could not read property list file", pathToPlist);
        exit(-1);
    }

    if (shouldPrintFilename) {
        SSLog(@"%@", [pathToPlist lastPathComponent]);
    }

    SSLog(@"%@", plistContents);
}

// vim:ft=objc
