//
//  AutoloadImageView.h
//  TopBlip
//
//  Created by Avantar Developer on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "URLImageCache.h"

/**
 When the url on a URLImageView it uses the URLImageCache to load and display
 the image at the given url.
 */
@interface URLImageView : UIImageView <URLImageCacheListener>
{
    NSURL *_url;
    UIImage *_errorImage;
}

@property (nonatomic, readwrite, retain) NSURL *url;
@property (nonatomic, readwrite, retain) UIImage *errorImage;

@end
