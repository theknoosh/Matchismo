//
//  SetCard.h
//  Matchismo
//
//  Created by DPayne on 12/11/13.
//  Copyright (c) 2013 Sanctuary of Darkness. All rights reserved.
//

#import "Card.h"

typedef enum { NUMBER=1,  SYMBOL, SHADING, COLOR  }AttribToCheck;

@interface SetCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) UIColor *color;
@property (nonatomic)NSInteger cardFill;
@property (nonatomic)NSInteger cardShape;
@property (nonatomic)NSInteger shapeNumber;


+(NSArray *)validSuits;
+(NSArray *)validColors;

// +(NSUInteger)maxRank;

@end