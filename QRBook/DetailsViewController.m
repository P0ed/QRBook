//
//  DetailsViewController.m
//  QRBook
//
//  Created by Konstantin Sukharev on 10/02/15.
//  Copyright (c) 2015 P0ed. All rights reserved.
//


#import "DetailsViewController.h"
#import "QRCodeView.h"
#import "QRCode.h"


@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet QRCodeView *codeView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@end


@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.codeView.stringValue = self.code.message;
	self.textLabel.text = self.code.message;
}

- (IBAction)performAction:(id)sender {
	
	
}

@end
