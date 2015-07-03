#import "NSDate+XMLRepr.h"

@implementation NSDate(XMLRepr)
- (NSString *)xmlRepresentation {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeStyle:NSDateFormatterFullStyle];

    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];

    return [[formatter stringFromDate:self] stringByAppendingString:@"Z"];
}
@end
