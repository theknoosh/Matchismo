//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by DPayne on 12/19/13.
//  Copyright (c) 2013 Sanctuary of Darkness. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetDeck.h"
#import "SetCard.h"

@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

-(Deck *)createDeck
{
    return [[SetDeck alloc]init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"dealloc SetCardGameViewController");
}


@end
