//
//  URLImageCacheListener.h
//  TopBlip
//
//  Created by Avantar Developer on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol URLImageCacheListener <NSObject>

/// the requested image has been loaded in the cache
-(void)urlImageCacheLoadedImage:(UIImage*)image forURL:(NSURL*) url;
/// the requested image failed to load
-(void)urlImageCacheLoadFailed:(NSError*) error forURL:(NSURL*) url;

@end
