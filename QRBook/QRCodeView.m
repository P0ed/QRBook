//
//  QRCodeView.m
//  QRBook
//
//  Created by Konstantin Sukharev on 10/02/15.
//  Copyright (c) 2015 P0ed. All rights reserved.
//


#import "QRCodeView.h"
#import <RubyLikeExtensions.h>


@implementation QRCodeView

#pragma mark - NSCoding Protocol

- (id)initWithCoder:(NSCoder *)aDecoder {
	
	self = [super initWithCoder:aDecoder];
    if (self) {
        _dataValue = [aDecoder decodeObjectForKey:SELString(dataValue)];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:_dataValue forKey:SELString(dataValue)];
}

#pragma mark - Reload Data

- (void)reloadData {
	
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setValue:self.dataValue forKey:@"inputMessage"];
    CIImage *outputImage = filter.outputImage;
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:outputImage.extent];
    UIImage *image = [UIImage imageWithCGImage:cgImage scale:1 orientation:UIImageOrientationUp];
	CGImageRelease(cgImage);
	
	CGSize size = CGSizeMake(image.size.width * 16, image.size.height * 16);
	UIGraphicsBeginImageContextWithOptions(size, NO, 0);
	CGContextRef cgContext = UIGraphicsGetCurrentContext();
	CGContextSetInterpolationQuality(cgContext, kCGInterpolationNone);
	[image drawInRect:CGRectMake(0, 0, size.width, size.height)];
	image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
    self.image = image;
}

#pragma mark - Properties

- (NSString *)stringValue {
	return [[NSString alloc] initWithData:_dataValue encoding:NSUTF8StringEncoding];
}

- (void)setStringValue:(NSString *)stringValue {
	self.dataValue = [stringValue dataUsingEncoding:NSUTF8StringEncoding];
}

- (void)setDataValue:(NSData *)dataValue {
    _dataValue = dataValue;
    [self reloadData];
}

#pragma mark - IBDesignable

- (void)prepareForInterfaceBuilder {
	[self reloadData];
}

@end
