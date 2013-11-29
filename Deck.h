//
//  Deck.h
//  Matchismo
//
//  Created by DPayne on 11/22/13.
//  Copyright (c) 2013 Sanctuary of Darkness. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;

- (Card *)drawRandomCard;

@end
