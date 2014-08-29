CCSpriteFromURL
===============

CCSpriteFromURL


1. Copy Networking folder.
2. Copy CCSprite + SpriteFromURL.h
3. Copy CCSprite + SpriteFromURL.m

//=======================================//
//              USAGES                   //
//=======================================//

    CCSprite *sprite = [CCSprite spriteWithURL:@"http://3.bp.blogspot.com/-k5_junLLnOE/Uhx4gL2YKuI/AAAAAAAATQ8/zbvatkOM2Sc/s1600/woofster.png"
                                 defaultSprite:@"Icon-72.png"];
    sprite.positionType = CCPositionTypeNormalized;
    sprite.position = ccp(0.5,0.5);
    [<scene> addChild:sprite];
