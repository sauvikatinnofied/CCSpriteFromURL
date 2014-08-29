//
//  NetworkResourceDownLoader.m
//  DownLoadProgress
//
//  Created by Sandip Saha on 13/02/14.
//  Copyright (c) 2014 Sandip Saha. All rights reserved.
//

#import "NetworkResourceDownLoader.h"


//Declaring the private variables
@interface NetworkResourceDownLoader() <NSURLConnectionDataDelegate>
{
    NSURL *url;
    NSURLConnection *urlConnection;
    NSString *responseString;
    int long long totalBytesToBeDownloaded;
}

@end

@implementation NetworkResourceDownLoader

-(id)initWithBaseURL:(NSString*)baseURL obejectPath:(NSString*)objectPath
{
    if(self = [super init]){
        
        if (!baseURL && !objectPath)//If both parameters are missing
        {
            return nil;
        }
        else{
            if (objectPath) {
                url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",baseURL,objectPath]];
            }
            else
            {
                url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",baseURL]];
            }
        }
    }
    
    return  self;
}

-(void)startDownload
{
    if (url) {
        NSMutableURLRequest *getRequest=[[NSMutableURLRequest alloc]initWithURL:url];
        //creating the url connection
        urlConnection =[[NSURLConnection alloc]initWithRequest:getRequest delegate:self];
    }
}

-(void)cancelDownload
{
    //releasing the resources
    urlConnection = nil;
    _responseData = nil;
    _completionHandler = nil;
    _progressReporter = nil;
    _errorHandler = nil;
}





#pragma mark- NSURLConnectionDataDelagate Methods

//called only once when the NSURLConnection receives response from the server
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //allocating memory for the data to be downloaded
    _responseData = [[NSMutableData alloc]init];
    totalBytesToBeDownloaded =0;
    
    //getting information about the content leangth
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
    totalBytesToBeDownloaded = httpResponse.expectedContentLength;
    _connectionStatusCode = httpResponse.statusCode;
    
    if (totalBytesToBeDownloaded < 0) {
        
        #ifdef DEBUG_MODE
                NSLog(@"NetworkRequestDownloader ERROR: Content length is not availavle from server ,download progress report is not possible.");
        #endif
        
    }
    
}

//called when data chunk is received from the server
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //appending the receied data
    [_responseData appendData:data];
    _downloadProgressFraction = (_responseData.length*1.0)/totalBytesToBeDownloaded;
    
    //if progressReporter block is defined ,going to execute that
    if(_progressReporter){
        _progressReporter();
    }
}

//called when netwrok connection failed
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    #ifdef DEBUG_MODE
       NSLog(@"NetworkRequestDownloader ERROR:Download failed.");
    #endif
    
    
    //collecting the error string
    _errorString = [error localizedDescription];
    
    
    //if error handler is defined then going to execute the error handler
    if (_errorHandler) {
        _errorHandler(error);
    }
    
}

//called after download is completed
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    #ifdef DEBUG_MODE
         NSLog(@"NetworkRequestDownloader REPORTS:Download completed successfully.");
    #endif   
    
    //if completion handler is defined ,going to execute the completion handler
    if (_completionHandler) {
        _completionHandler();
    }
    
}
//-(NSURLRequest *)connection:(NSURLConnection *)connection
//            willSendRequest:(NSURLRequest *)request
//           redirectResponse:(NSURLResponse *)redirectResponse {
//    
//    if (redirectResponse) {
//        // we don't use the new request built for us, except for the URL
//        NSURL *newURL = [request URL];
//        // Previously, store the original request in _originalRequest.
//        // We rely on that here!
//        NSMutableURLRequest *newRequest = [request mutableCopy];
//        [newRequest setURL: newURL];
//        
//        
//        url = newURL;
//        NSLog(@"New URL found = %@",url);
//        
//        [self startDownload];
//        
//        return newRequest;
//    } else {
//        return request;
//    }
//    
//}

-(void)loadPicFromURL:(NSString*)picURL withCompletionBlock:(void(^)(UIImage* image))completionBlock
{
    NetworkResourceDownLoader *imageLoader = [[NetworkResourceDownLoader alloc]initWithBaseURL:picURL obejectPath:nil];
    __weak NetworkResourceDownLoader *weakLoader = imageLoader;
    [weakLoader setCompletionHandler:^{
        //NSLog(@"FBUser Profile Picture Loaded for user");
        
        UIImage *image = [UIImage imageWithData:weakLoader.responseData];
        if ([image respondsToSelector:@selector(drawAtPoint:)]) {
            // Executing completion block
            if (completionBlock) {
                completionBlock(image);
            }
        }
        
    }];
    [weakLoader setErrorHandler:^(NSError *error) {
        NSLog(@"Error: Error in laoding the image from url %@",error);
    }];
    [weakLoader setProgressReporter:^{
        //NSLog(@"progress = %f",weakLoader.downloadProgressFraction);
    }];
    [weakLoader startDownload];
}
@end
