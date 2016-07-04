//
//  NSString+Extended.h
//  GPSESCORT
//
//  Created by Rahul Soni on 28/10/15.
//  Copyright (c) 2015 Rahul Soni. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extended)
- (NSString *)urlencode;
- (NSString *)URLDecode;
-(NSString*)stringByTrimmingLeadingWhitespace;
-(NSString *)stringFilterAlphaNumericCharacters;
@end
