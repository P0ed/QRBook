//
//  ScanCodeViewController.m
//  QRBook
//
//  Created by Konstantin Sukharev on 10/02/15.
//  Copyright (c) 2015 P0ed. All rights reserved.
//


#import "ScanCodeViewController.h"
#import "QRCode.h"
#import <RubyLikeExtensions.h>
#import <PromiseKit/PromiseKit.h>
@import AVFoundation;


@interface ScanCodeViewController () <AVCaptureMetadataOutputObjectsDelegate>
@property (nonatomic) AVCaptureSession *session;
@property (weak, nonatomic) IBOutlet UIView *hintView;
@property (nonatomic) AVCaptureVideoPreviewLayer *previewLayer;
@end


@implementation ScanCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.session = AVCaptureSession.new;
	
	AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
	AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:NULL];
	[self.session addInput:input];
	
	AVCaptureMetadataOutput *output = AVCaptureMetadataOutput.new;
	[output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
	[self.session addOutput:output];
	output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.session startRunning];
	self.previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:self.session];
	[self.view.layer insertSublayer:self.previewLayer atIndex:0];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	int64_t time = 3 * NSEC_PER_SEC;
	dispatch_after(dispatch_time(DISPATCH_TIME_NOW, time), dispatch_get_main_queue(), ^{
		
		CATransition *animation = [CATransition animation];
		animation.type = kCATransitionFade;
		animation.duration = 0.4;
		[self.hintView.layer addAnimation:animation forKey:@"Removage"];
		self.hintView.hidden = YES;
	});
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	[self.session stopRunning];
}

- (void)viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];
	self.previewLayer.frame = self.view.bounds;
	
	/*
	 let map = [
	 UIInterfaceOrientation.Portrait: AVCaptureVideoOrientation.Portrait,
	 UIInterfaceOrientation.PortraitUpsideDown: AVCaptureVideoOrientation.PortraitUpsideDown,
	 UIInterfaceOrientation.LandscapeLeft: AVCaptureVideoOrientation.LandscapeLeft,
	 UIInterfaceOrientation.LandscapeRight: AVCaptureVideoOrientation.LandscapeRight,
	 ]
	 if let orientation = map[UIApplication.sharedApplication().statusBarOrientation] {
	 
	 previewLayer?.connection.videoOrientation = orientation
	 }
	 */
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
	
	[self fulfill:metadataObjects.map(^(AVMetadataMachineReadableCodeObject *metadataObject) {
		
		QRCode *code = QRCode.new;
		code.scanDate = NSDate.date;
		code.message = metadataObject.stringValue;
		
		return code;
	})];
}

@end
