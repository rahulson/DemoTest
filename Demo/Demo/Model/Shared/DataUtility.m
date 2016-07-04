//
//  DataUtility.m
//  JiuJitsu
//
//  Created by Rahul Soni on 06/07/15.
//  Copyright (c) 2015 Rahul Soni. All rights reserved.
//

#import "DataUtility.h"

@implementation DataUtility


+ (NSString *)getIMEI
{
    NSString *UDID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];//
    return UDID;
}

+ (UIColor *) colorFromHexString:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+(BOOL)isEmailValid:(NSString *)emailAddress{
    
    BOOL isValid = NO;
    NSString *emailString = emailAddress;
    NSString *emailReg = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailReg];
    if (([emailTest evaluateWithObject:emailString] != YES) || [emailString isEqualToString:@""]){
        isValid = YES;
    }
    return  isValid;
}

+ (UIImage*)resizedImage:(UIImage*)image size:(CGSize)size
{
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(frame.size);
    [image drawInRect:frame];
    UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImage;
}
@end
