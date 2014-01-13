//
//  HistoryViewController.m
//  Matchismo
//
//  Created by DPayne on 1/7/14.
//  Copyright (c) 2014 Sanctuary of Darkness. All rights reserved.
//

#import "HistoryViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

-(void)setContentForBox:(NSAttributedString *)contentForBox
{
    _contentForBox = contentForBox;
    // if (self.view.window)[self updateUI];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    // NSAttributedString *textString =  [[NSAttributedString alloc] initWithString:@"Hello World" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"HoeflerText-Italic" size:12]}];
    NSTextStorage *textStorage = [[NSTextStorage alloc] initWithAttributedString:self.contentForBox];
    NSLayoutManager *textLayout = [[NSLayoutManager alloc] init];
    // Add layout manager to text storage object
    [textStorage addLayoutManager:textLayout];
    // Create a text container
    NSTextContainer *textContainer = [[NSTextContainer alloc] initWithSize:self.view.bounds.size];
    // Add text container to text layout manager
    [textLayout addTextContainer:textContainer];
    // Instantiate UITextView object using the text container
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(20,100,self.view.bounds.size.width-40,self.view.bounds.size.height-200)
                                               textContainer:textContainer];
    
    textView.editable = NO;
    textView.backgroundColor = [UIColor grayColor];
    // Add text view to the main view of the view controler
    
    [self.view addSubview:textView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done:(id)sender
{
    [self.delegate historyViewControllerDidSave:self];
}

- (void)dealloc
{
    self.contentForBox = nil;
    self.delegate = nil;
    NSLog(@"dealloc HistoryViewController");
}


@end
