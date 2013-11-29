//
//  PlayingCard.h
//  Matchismo
//
//  Created by DPayne on 11/21/13.
//  Copyright (c) 2013 Sanctuary of Darkness. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+(NSArray *)validSuits;
+(NSUInteger)maxRank;


@end
