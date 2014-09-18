//
//  CheckoutViewController.m
//  ExampleKeyChain
//
//  Created by Vy Systems - iOS1 on 9/15/14.
//  Copyright (c) 2014 Vy Systems - iOS1. All rights reserved.
//

#import "CheckoutViewController.h"

@interface CheckoutViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnItem1Add;
@property (weak, nonatomic) IBOutlet UIButton *btnItem2Add;
@property (weak, nonatomic) IBOutlet UIButton *btnItem3Add;

@property (weak, nonatomic) IBOutlet UIButton *btnDeleteItem1;

@property (weak, nonatomic) IBOutlet UIButton *btnDeleteItem2;
@property (weak, nonatomic) IBOutlet UIButton *btnDeleteItem3;

- (IBAction)addItem1:(id)sender;
- (IBAction)addItem2:(id)sender;

- (IBAction)addItem3:(id)sender;

- (IBAction)deleteItem1:(id)sender;

- (IBAction)deleteItem2:(id)sender;
- (IBAction)deleteItem3:(id)sender;


@end

@implementation CheckoutViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addItem1:(id)sender
{
}

- (IBAction)addItem2:(id)sender
{
}

- (IBAction)addItem3:(id)sender
{
}

- (IBAction)deleteItem1:(id)sender
{
}

- (IBAction)deleteItem2:(id)sender
{
}

- (IBAction)deleteItem3:(id)sender
{
}
@end
