//
//  URLImageReqeust.m
//  TopBlip
//
//  Created by Avantar Developer on 5/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "URLImageReqeust.h"

@implementation URLImageReqeust

-(id)initWithURL:(NSURL*)url delegate:(id<URLImageRequestDelegate>) delegate
{
    self = [super init];
    
    if (self)
    {
        _imageURL = [url retain];
        _delegate = delegate;
    }
    
    return self;
}

-(void)dealloc
{
    [_connection cancel];
    [_connection release];
    [_data release];
    [_imageURL release];
    
    [super dealloc];
}

-(void)startRequest
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:_imageURL];
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [request release];
}

#pragma mark - Properties

@synthesize delegate = _delegate;
@synthesize imageURL = _imageURL;

#pragma mark - Delegates
#pragma mark NSURLConnectionDelegate

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    NSArray *trustedHosts = [NSArray arrayWithObjects:@"ec2-54-251-248-15.ap-southeast-1.compute.amazonaws.com",nil];
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        if ([trustedHosts containsObject:challenge.protectionSpace.host])
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response 
{
    _data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data 
{
    [_data appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error 
{
    [_delegate urlImageReqeuestDidFail:self withError:error];
    
    [_data release];
    _data = nil;
    
    [_connection release];
    _connection = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    UIImage *result = [UIImage imageWithData:_data];
    
    if (result)
    {
        [_delegate urlImageRequestDidLoad:self image:result];
    }
    else
    {
        [_delegate urlImageReqeuestDidFail:self withError:[NSError errorWithDomain:@"ImageDecode" code:0 userInfo:[NSDictionary dictionaryWithObject:_imageURL forKey:@"url"]]];
    }
    
    [_data release];
    _data = nil;
    
    [_connection release];
    _connection = nil;
}

@end
