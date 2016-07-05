//
//  AutoloadImageView.m
//  TopBlip
//
//  Created by Avantar Developer on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "URLImageView.h"

@implementation URLImageView

//-(void)dealloc
//{
//    self.url = nil;
//    self.errorImage = nil;
//    
//    [super dealloc];
//}

@synthesize url = _url;
@synthesize errorImage = _errorImage;

-(void)awakeFromNib
{
    if (self.errorImage == nil)
        self.errorImage = self.image;
}

-(void)setImage:(UIImage *)image
{
    [super setImage:image];
    
    if (_errorImage == nil)
    {
        self.errorImage = image;
    }
}

-(void)setUrl:(NSURL *)url
{
    
    if (_url)
    {
        [[URLImageCache singleton] cancelReqeust:_url withListener:self];
    }
    
    [url retain];
[_url release];
    
    _url = url;
    
    if (_url)
    {
        [[URLImageCache singleton] requestImage:_url withListener:self];
    }
    else
    {
        self.image = _errorImage;
    }
}

#pragma mark - Delegates
#pragma mark URLImageCacheListener


-(void)urlImageCacheLoadedImage:(UIImage*)image forURL:(NSURL*) url
{
    self.image = image;
}

-(void)urlImageCacheLoadFailed:(NSError*) error forURL:(NSURL*) url
{
    if (_errorImage)
        self.image = _errorImage;
}

@end
