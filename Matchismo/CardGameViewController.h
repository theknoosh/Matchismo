//
//  CardGameViewController.h
//  Matchismo
//
//  Created by DPayne on 11/18/13.
//  Copyright (c) 2013 Sanctuary of Darkness. All rights reserved.
//
// This is an abstract class. DO NOT implement directly

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

// This method must be implemented in derived classes
-(Deck *)createDeck;

@end

