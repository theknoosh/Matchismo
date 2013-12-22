//
//  SetCard.h
//  Matchismo
//
//  Created by DPayne on 12/11/13.
//  Copyright (c) 2013 Sanctuary of Darkness. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) UIColor *color;
@property (nonatomic)NSInteger atrib;


+(NSArray *)validSuits;
+(NSArray *)validColors;

// +(NSUInteger)maxRank;

@end