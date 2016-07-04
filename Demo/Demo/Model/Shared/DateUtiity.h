//
//  DateUtiity.h
//  JiuApp
//
//  Created by Rahul Soni on 28/04/15.
//  Copyright (c) 2015 Rahul Soni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DateUtiity : NSObject


+(NSString *)getCurrentDate;
+ (int)dateCompareValue:(NSDate *)date;
+ (int)dateCompareValueStringFormat:(NSString  *)date;
+ (NSString *)dateFormatter:(NSString *)dateString;
+ (NSString *)dateFormatterMYTrip:(NSString *)dateString;
+ (NSString *)getDateWithAppendingDay:(int)day DateStringFormat:(NSString *)date;
+ (NSString *)getDateWithAppendingDay:(int)day Date:(NSDate *)date;
+ (NSString *)dateformaterDateFormatEEE_MMM_dd_yyyy:(NSString *)dateString;
+ (NSString *)getTimeDurationFromDate:(NSString *) from;
+(NSString *)getFaceBookFormattedDate:(NSString *)date;
@end
