//
//  DateUtiity.m
//  JiuApp
//
//  Created by Rahul Soni on 28/04/15.
//  Copyright (c) 2015 Rahul Soni. All rights reserved.
//

#import "DateUtiity.h"

@implementation DateUtiity



+(NSString *)getCurrentDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"dd MMM"];
    NSDate *currentdate = [NSDate date];
    NSString *str = [dateFormatter stringFromDate:currentdate];
    return str;
}

+ (int)dateCompareValue:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return [dateStr intValue];
}

+ (int)dateCompareValueStringFormat:(NSString  *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate * dateF =[dateFormatter dateFromString:date];
    int dateINT = [DateUtiity dateCompareValue:dateF];
    return dateINT;
}

+(NSString *)dateFormatter:(NSString *)dateString{
    
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    //2014-05-05 20:53:00
    [dateFormat1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormat2 setDateFormat:@"yyyy-MM-dd"];
    
    return [dateFormat2 stringFromDate:[dateFormat1 dateFromString:dateString]];
}//2014-08-01 15:28:20

+(NSString *)dateFormatterMYTrip:(NSString *)dateString{
    
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    //2014-05-05 20:53:00
    [dateFormat1 setDateFormat:@"dd-MMM-yyyy"];
    [dateFormat2 setDateFormat:@"dd-MMM-yyyy"];
    
    return [dateFormat2 stringFromDate:[dateFormat1 dateFromString:dateString]];
}

+ (NSString *)getDateWithAppendingDay:(int)day DateStringFormat:(NSString *)date{
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"dd-MMM-yyyy"];
    NSDate * nsdate =[dateFormat2 dateFromString:date];
    NSString * dateString =[DateUtiity getDateWithAppendingDay:day Date:nsdate];
    return dateString;
    
}

+(NSString *)getDateWithAppendingDay:(int)day Date:(NSDate *)date{
    
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"dd-MMM-yyyy"];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponent = [NSDateComponents new];
    dayComponent.day = day;
    date = [calendar dateByAddingComponents:dayComponent toDate:date options:0];
    NSString * dateStr = [dateFormat2 stringFromDate:date];
    return dateStr;
}

+(NSString *)dateformaterDateFormatEEE_MMM_dd_yyyy:(NSString *)dateString{
    //2014-09-18 17:16:37
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    NSDateFormatter *dateFormat2 = [[NSDateFormatter alloc] init];
    [dateFormat2 setDateFormat:@"yyyy-MM-dd"];
    [dateFormat1 setDateFormat:@"EEE,MMM dd,yyyy"];  // Output: Sun, 001 May 2011
    
    return [dateFormat1 stringFromDate:[dateFormat2 dateFromString:dateString]];
}

+(NSString *)getFaceBookFormattedDate:(NSString *)date{
     NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"MM/dd/yyyy"];
    NSDate *birthdate = [dateFormatter1 dateFromString:date];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"dd-MM-yyyy"];
    NSString *formattedDate = [dateFormatter2 stringFromDate:birthdate];
    return formattedDate;
    
}



+ (NSString *)dateFormatByFirstDateFormat:(NSString *)fDateF SecondDateFormat:(NSString *)sDateF{
    return @"";
}



+ (NSString *)getTimeDurationFromDate:(NSString *) from{
    NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
    [dateFormat1 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * fromDate = [dateFormat1 dateFromString:from];
    NSString *duration = @"";
    
    NSDate *currentTime = [NSDate date];
    
    if ([[NSNumber numberWithInt:[DateUtiity  dateCompareValue:currentTime]] compare:[NSNumber numberWithInt:[DateUtiity dateCompareValue:fromDate]]] == NSOrderedSame) {
        
        NSTimeInterval distanceBetweenDates = [[NSDate date] timeIntervalSinceDate:fromDate];
        
        int secondsInMinute = 1 * 60;
        int secondsInHour = 1 * 60 * 60;
        int secondsInDay = secondsInHour * 24;
        
        if (distanceBetweenDates / secondsInDay > 1) {
            duration = [NSString stringWithFormat:@"%d days ago", (int)(distanceBetweenDates/secondsInDay)];
        }else if((distanceBetweenDates/secondsInHour) > 1){
            duration = [NSString stringWithFormat:@"%d hours ago", (int)(distanceBetweenDates/secondsInHour)];
        }else if((distanceBetweenDates/secondsInMinute) > 1){
            duration = [NSString stringWithFormat:@"%d minutes ago", (int)(distanceBetweenDates/secondsInMinute)];
        }else{
            duration = @"few seconds ago";
        }
        
    }else{
        NSDateFormatter *dateFormat1 = [[NSDateFormatter alloc] init];
        [dateFormat1 setDateFormat:@"MMM dd,yyyy"];
        duration = [dateFormat1 stringFromDate:fromDate];
        
    }
    
    return duration;
}

@end
