//
//  URLImageRequestDelegate.h
//  TopBlip
//
//  Created by Avantar Developer on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class URLImageReqeust;

@protocol URLImageRequestDelegate <NSObject>

-(void)urlImageRequestDidLoad:(URLImageReqeust*) request image:(UIImage*) image;
-(void)urlImageReqeuestDidFail:(URLImageReqeust*) request withError:(NSError*) error;

@end
