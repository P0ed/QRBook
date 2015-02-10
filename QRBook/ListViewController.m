//
//  ViewController.m
//  QRBook
//
//  Created by Konstantin Sukharev on 10/02/15.
//  Copyright (c) 2015 P0ed. All rights reserved.
//

#import "ListViewController.h"
#import "DetailsViewController.h"
#import "QRCode.h"
#import <RubyLikeExtensions.h>
#import <PromiseKit/PromiseKit.h>


@interface ListViewController ()
@property (nonatomic) NSArray *codes;
@end


@implementation ListViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	_codes = @[];
}

- (IBAction)addCode:(id)sender {

	[self promiseSegueWithIdentifier:@"ScanCode" sender:nil].then(^(NSArray *codes) {
		
		_codes = [_codes arrayByAddingObjectsFromArray:codes];
		[self.tableView reloadData];
		[self performSegueWithIdentifier:@"Details" sender:codes.lastObject];
	});
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _codes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId" forIndexPath:indexPath];
	
	QRCode *code = _codes[indexPath.row];
	cell.textLabel.text = code.scanDate.stringUsingFormat(@"hh:mm:ss dd.MM.yyyy");
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self performSegueWithIdentifier:@"Details" sender:_codes[indexPath.row]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	
	if ([segue.identifier isEqualToString:@"Details"]) {
		
		DetailsViewController *controller = segue.destinationViewController;
		controller.code = sender;
	}
}

- (IBAction)unwind:(UIStoryboardSegue *)unwindSegue {
	
}

@end
