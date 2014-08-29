//
//  NetworkResourceDownLoader.h
//  DownLoadProgress
//
//  Created by Sandip Saha on 13/02/14.
//  Copyright (c) 2014 Sandip Saha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkResourceDownLoader : NSObject

@property(readonly) float downloadProgressFraction;
@property(readonly) NSString *errorString;
@property(readonly) NSInteger connectionStatusCode;
@property(readonly) NSMutableData *responseData;

/* 
    This completion block will be defined from owner class
    and will be executed after download completed successfully
 */
@property(nonatomic,copy)   void(^completionHandler)(void);


/* 
    This completion block will be defined from owner class
    and will be executed show the download progess
*/
@property(nonatomic,copy)   void(^progressReporter)(void);


/*
    This completion block will be defined from owner class
    and will be executed to inform download failue
 */
@property(nonatomic,copy)   void(^errorHandler)(NSError *error);


//Designated initializer
-(id)initWithBaseURL:(NSString*)baseURL obejectPath:(NSString*)objectPath;
-(void)loadPicFromURL:(NSString*)picURL withCompletionBlock:(void(^)(UIImage* image))completionBlock;

//methods to start and stop download
-(void)startDownload;
-(void)cancelDownload;




@end
