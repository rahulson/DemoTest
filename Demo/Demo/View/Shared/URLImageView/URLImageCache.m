//
//  URLImageCache.m
//  TopBlip
//
//  Created by Avantar Developer on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "URLImageCache.h"

@implementation URLImageCache

+(URLImageCache*)singleton
{
    static URLImageCache *singleton = nil;
    
    if (singleton == nil)
    {
        singleton = [[URLImageCache alloc] init];
    }
    
    return singleton;
}

-(id)init
{
    self = [super init];
    
    if (self)
    {
        _savedImages = [[NSMutableDictionary alloc] init];
        _waitingListeners = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(void)dealloc
{
    _imageRequest.delegate = nil;
    [_imageRequest release];
    
    [_savedImages release];
    [_waitingListeners release];
    
    [super dealloc];
}

-(NSMutableArray*)waitingListenersForURL:(NSURL*)url
{
    NSMutableArray *result = [_waitingListeners objectForKey:url];
    
    if (result == nil)
    {
        result = [NSMutableArray array];
        [_waitingListeners setObject:result forKey:url];
    }
    
    return result;
}

- (void)requestImage:(NSURL *)url {
    _imageRequest = [[URLImageReqeust alloc] initWithURL:url delegate:self];
    [_imageRequest startRequest];
}

-(void)requestImage:(NSURL*)url withListener:(id<URLImageCacheListener>)listener
{
    id result = [_savedImages objectForKey:url.absoluteString];
    
    if (result)
    {
        if ([result isKindOfClass:[UIImage class]])
            [listener urlImageCacheLoadedImage:result forURL:url];
        else if ([result isKindOfClass:[NSError class]])
            [listener urlImageCacheLoadFailed:result forURL:url];
    }
    else
    {
        NSMutableArray *listeners = [self waitingListenersForURL:url];
        [listeners addObject:listener];
        
        if (listeners.count == 1)
        {
            // for the first we need to request the image
            _imageRequest = [[URLImageReqeust alloc] initWithURL:url delegate:self];
            [_imageRequest startRequest];
        }
    }
}

-(void)cancelReqeust:(NSURL*)url withListener:(id<URLImageCacheListener>)listener
{
    [[self waitingListenersForURL:url] removeObject:listener];
}

-(void)setImage:(UIImage*) image forURL:(NSURL*) url
{
    [_savedImages setObject:image forKey:url.absoluteString];
}

-(void)clearImage:(NSURL*) url
{
    [_savedImages removeObjectForKey:url.absoluteString];
}

-(void)imageRecieved:(NSDictionary*)values
{
    UIImage *image = [values objectForKey:@"image"];
    NSURL *url = [values objectForKey:@"url"];
    
    NSMutableArray *listeners = [self waitingListenersForURL:url];
    
    [_savedImages setObject:image forKey:url.absoluteString];
    
    for (id<URLImageCacheListener> listener in listeners)
    {
        [listener urlImageCacheLoadedImage:image forURL:url];
    }
    
    [listeners removeAllObjects];
}

-(void)imageDownloadFailed:(NSDictionary*)values
{
    NSError *error = [values objectForKey:@"error"];
    NSURL *url = [values objectForKey:@"url"];
    
    NSMutableArray *listeners = [self waitingListenersForURL:url];
    
    [_savedImages setObject:error forKey:url.absoluteString];
    
    for (id<URLImageCacheListener> listener in listeners)
    {
        [listener urlImageCacheLoadFailed:error forURL:url];
    }
    
    [listeners removeAllObjects];
}

#pragma mark - Delegates
#pragma mark URLImageRequestDelegate

-(void)urlImageRequestDidLoad:(URLImageReqeust*) request image:(UIImage*) image
{
    NSDictionary *values = [NSDictionary dictionaryWithObjectsAndKeys:request.imageURL, @"url", image, @"image", nil];
    [self performSelectorOnMainThread:@selector(imageRecieved:) withObject:values waitUntilDone:FALSE];
    
    [_imageRequest autorelease];
    _imageRequest = nil;
}

-(void)urlImageReqeuestDidFail:(URLImageReqeust*) request withError:(NSError*) error
{
    NSDictionary *values = [NSDictionary dictionaryWithObjectsAndKeys:request.imageURL, @"url", error, @"error", nil];
    [self performSelectorOnMainThread:@selector(imageDownloadFailed:) withObject:values waitUntilDone:FALSE];
    
    [_imageRequest autorelease];
    _imageRequest = nil;
}

@end
