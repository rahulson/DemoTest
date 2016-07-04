//
//  DataUtility.h
//  JiuJitsu
//
//  Created by Rahul Soni on 06/07/15.
//  Copyright (c) 2015 Rahul Soni. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UIDevice+IdentifierAddition.h"
@interface DataUtility : NSObject
+ (NSString *)getIMEI;
+ (UIColor *)colorFromHexString:(NSString *)hexString;
+ (BOOL)isEmailValid:(NSString *)emailAddress;
+ (UIImage*)resizedImage:(UIImage*)image size:(CGSize)size;
@end
