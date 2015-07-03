#import "NSDate+XMLRepr.h"
#import "NSData+Base64.h"
#define SSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

void usage(void);
void printFile(char *file, BOOL shouldPrintFilename);
void printIndent(int indentLevel);
void printValue(id object, int indentLevel);
void printNumber(NSNumber *num);

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
    SSLog(@"plcat usage: plcat file");
}

void printFile(char *file, BOOL shouldPrintFilename) {
    NSString *pathToPlist = [NSString stringWithUTF8String:file];
    NSDictionary *plistContents;

    if (![[NSFileManager defaultManager] fileExistsAtPath:pathToPlist]) {
        SSLog(@"plcat: %@: No such file", pathToPlist);
        usage();
        exit(-1);
    }

    plistContents = [NSDictionary dictionaryWithContentsOfFile:pathToPlist];

    if (!plistContents) {
        SSLog(@"plcat %@: Could not read property list file", pathToPlist);
        exit(-1);
    }

    if (shouldPrintFilename) {
        SSLog(@"%@", [pathToPlist lastPathComponent]);
    }

    SSLog(@"<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
    SSLog(@"<plist version=\"1.0\">");
    printValue(plistContents, 0);
    SSLog(@"</plist>");
    if (shouldPrintFilename) SSLog(@"");
}

void printValue(id object, int indentLevel) {

    //indent
    for (int i=0; i < indentLevel; i++) printf("    ");
    if ([object isKindOfClass:[NSString class]]) {
        SSLog(@"<string>%@</string>", object);
    } else if ([object isKindOfClass:[NSNumber class]]) {
        printNumber(object);
    }
    else if ([object isKindOfClass:[NSArray class]]) {
        SSLog(@"<array>");
        for (id element in (NSArray *)object) {
            printValue(element, indentLevel+1);
        }
        printIndent(indentLevel);
        SSLog(@"</array>");
    } else if ([object isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dictionary = (NSDictionary *)object;
        SSLog(@"<dict>");
        for (id key in dictionary) {
            printIndent(indentLevel+1);
            SSLog(@"<key>%@</key>", key);
            printValue(dictionary[key], indentLevel+1);
        }
        printIndent(indentLevel);
        SSLog(@"</dict>");
    } else if ([object isKindOfClass:[NSDate class]]) {
        SSLog(@"<date>%@</date>", [((NSDate *)object) xmlRepresentation]);
    } else if ([object isKindOfClass:[NSData class]]) {
        SSLog(@"<data>%@</data>", [((NSData *)object) base64EncodedString]);
    }
}

void printIndent(int indentLevel) {
    for (int i=0; i < indentLevel; i++) printf("    ");
}

void printNumber(NSNumber *num) {
    if (strcmp([num objCType], @encode(BOOL)) == 0) {
        SSLog(num.boolValue ? @"<true/>" : @"<false/>");
    } else if (strcmp([num objCType], @encode(int)) == 0 
            || strcmp([num objCType], @encode(NSInteger)) == 0) {
        SSLog(@"<integer>%@</integer>", num);
    } else {
        SSLog(@"<real>%@</real>", num);
    }
}

// vim:ft=objc
