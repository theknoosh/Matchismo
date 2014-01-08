//
//  SetDeck.m
//  Matchismo
//
//  Created by DPayne on 12/17/13.
//  Copyright (c) 2013 Sanctuary of Darkness. All rights reserved.
//

#import "SetDeck.h"
#import "SetCard.h"

typedef enum { OUTLINE=0,  SOLID, TINT, TOTAL  }cardAtrib;

@interface SetDeck(){ // Private interface
    
}

@end

@implementation SetDeck

-(id)init
{
    self = [super init];
    if (self) {
        int sCount,sShape;
        for (NSString *suit in [SetCard validSuits]) {
            if ([suit isEqualToString:@"▲"]) {
                sCount = 1;
                sShape = 1;
            } else if ([suit isEqualToString:@"▲▲"])
            {
                sCount = 2;
                sShape = 1;
            } else if ([suit isEqualToString:@"▲▲▲"])
            {
                sCount = 3;
                sShape = 1;
            }else if ([suit isEqualToString:@"●"])
            {
                sCount = 1;
                sShape = 2;
            }else if ([suit isEqualToString:@"●●"])
            {
                sCount = 2;
                sShape = 2;
            } else if ([suit isEqualToString:@"●●●"])
            {
                sCount = 3;
                sShape = 2;
            }else if ([suit isEqualToString:@"■"])
            {
                sCount = 1;
                sShape = 3;
            } else if ([suit isEqualToString:@"■■"])
            {
                sCount = 2;
                sShape = 3;
            } else if ([suit isEqualToString:@"■■■"])
            {
                sCount = 3;
                sShape = 3;
            }
            
            for (UIColor *cColor in [SetCard validColors]) {
                cardAtrib cAtrib;
                for ( cAtrib = OUTLINE; cAtrib < TOTAL; ++cAtrib)
                {
                    SetCard *card = [[SetCard alloc]init];
                    card.color = cColor;
                    card.suit = suit;
                    card.shapeNumber = sCount;
                    card.cardShape = sShape;
                    switch (cAtrib) {
                        case OUTLINE:
                            card.cardFill = 1;
                            [self addCard:card atTop:YES];
                            break;
                        case SOLID:
                            card.cardFill = 2;
                            [self addCard:card atTop:YES];
                            break;
                        case TINT:
                            card.cardFill = 3;
                            [self addCard:card atTop:YES];
                            break;
                        default:
                            break;
                    }
                    // NSLog(@"Card; %@",[card.contents string]);
                }
            }
        }
    }
    return self;
}

@end
