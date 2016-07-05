//
//  URLImageReqeust.h
//  TopBlip
//
//  Created by Avantar Developer on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "URLImageRequestDelegate.h"

/**
 requests an image at the given url and alerts the
 delegate when the download is complete
 */
@interface URLImageReqeust : NSObject
{
    id <URLImageRequestDelegate> _delegate;
    NSURL *_imageURL;
    
    NSURLConnection *_connection;
    NSMutableData *_data;
}

@property (nonatomic, readwrite, assign) id <URLImageRequestDelegate> delegate;
@property (nonatomic, readonly) NSURL *imageURL;

/// this initializer doesn't start the request. Call startRequest after initializing the
/// URLImageRequest object to download the image
-(id)initWithURL:(NSURL*)url delegate:(id<URLImageRequestDelegate>) delegate;

-(void)startRequest;

@end
