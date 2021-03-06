//
//  Card.h
//  Matchismo
//
//  Created by DPayne on 11/21/13.
//  Copyright (c) 2013 Sanctuary of Darkness. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSMutableAttributedString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

-(int)match:(NSArray *)otherCards;
-(int)match:(NSArray *)otherCards withAttribToCheck:(int)check;

@end
