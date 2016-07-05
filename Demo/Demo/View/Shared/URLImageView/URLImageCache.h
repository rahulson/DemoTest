//
//  URLImageCache.h
//  TopBlip
//
//  Created by Avantar Developer on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "URLImageCacheListener.h"
#import "URLImageReqeust.h"

/**
 Caches images downloaded from a given url.
 
 To use an image cache a class must impliment the URLImageRequestDelegate protocol
 and call requestImage:withListener to request an image. The class must also
 call cancelReqeust:withListener when it is decallocated or when no longer needs the image. 
 */
@interface URLImageCache : NSObject <URLImageRequestDelegate>
{
    NSMutableDictionary *_savedImages;
    NSMutableDictionary *_waitingListeners;
    
    URLImageReqeust *_imageRequest;
}

+(URLImageCache*)singleton;

/// alerts the listener when the image at the given url is availible
/// this may be immediately if the image is already loaded
-(void)requestImage:(NSURL*)url withListener:(id<URLImageCacheListener>)listener;
-(void)requestImage:(NSURL*)url;
/// tells the cache to not alert the given listener when the image at the given url
/// has been loaded
-(void)cancelReqeust:(NSURL*)url withListener:(id<URLImageCacheListener>)listener;

-(void)setImage:(UIImage*) image forURL:(NSURL*) url;
-(void)clearImage:(NSURL*) url;

@end
