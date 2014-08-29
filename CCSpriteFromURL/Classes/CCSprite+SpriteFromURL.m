//
//  CCSprite+SpriteFromURL.m
//  CCSpriteFromURL
//
//  Created by Sauvik Dolui on 8/29/14.
//  Copyright (c) 2014 Innofied Solution Pvt. Ltd. All rights reserved.
//

#import "CCSprite+SpriteFromURL.h"
#import "NetworkResourceDownLoader.h"

@implementation CCSprite (SpriteFromURL)
+ (id)spriteWithURL:(NSString*)imageURL defaultSprite:(NSString*)defalutImage
{
    
    CCSprite *sprite = [CCSprite spriteWithImageNamed:defalutImage];
    NetworkResourceDownLoader *downloader = [[NetworkResourceDownLoader alloc]init];
    [downloader loadPicFromURL:imageURL withCompletionBlock:^(UIImage *image) {
        CCSprite *loadedSprite = [CCSprite spriteWithCGImage:image.CGImage
                                                         key:[NSString stringWithFormat:@"%d",(int)(arc4random()% 200)]];
        sprite.texture = [loadedSprite texture];
    }];    
    return sprite;
}
@end
