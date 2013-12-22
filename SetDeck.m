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
        SetCard *card = [[SetCard alloc]init];
        for (NSString *suit in [SetCard validSuits]) {
            card.suit = suit;
            for (UIColor *cColor in [SetCard validColors]) {
                card.color = cColor;
                cardAtrib cAtrib;
                for ( cAtrib = OUTLINE; cAtrib < TOTAL; ++cAtrib)
                {
                    switch (cAtrib) {
                        case OUTLINE:
                            card.atrib = 1;
                            break;
                        case SOLID:
                            card.atrib = 2;
                            break;
                        case TINT:
                            card.atrib = 3;
                            break;
                        default:
                            break;
                    }
                    [self addCard:card atTop:YES];
                }
            }
        }
    }
    return self;
}

@end
