//
//  Card.h
//  Matchismo
//
//  Created by DPayne on 11/21/13.
//  Copyright (c) 2013 Sanctuary of Darkness. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

-(int)match:(NSArray *)otherCards;

@end
