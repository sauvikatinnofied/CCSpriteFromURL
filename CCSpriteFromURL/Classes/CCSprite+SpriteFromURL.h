//
//  CCSprite+SpriteFromURL.h
//  CCSpriteFromURL
//
//  Created by Sauvik Dolui on 8/29/14.
//  Copyright (c) 2014 Innofied Solution Pvt. Ltd. All rights reserved.
//

#import "CCSprite.h"

@interface CCSprite (SpriteFromURL)

/**
 * Set the texture first from a default Image. Further
 * it sets image texture from a loadedimage from Internet.
 *
 * @param imageURL      URL to load as the image texture of the image.
 * @param defalutImage  Default Sprite file name.
 *
 * Added By Sauvik Dolui, Innofied Solution Pvt. Ltd.
 */

+ (id)spriteWithURL:(NSString*)imageURL defaultSprite:(NSString*)defalutImage;
@end
