//
//  QRCode.m
//  QRBook
//
//  Created by Konstantin Sukharev on 10/02/15.
//  Copyright (c) 2015 P0ed. All rights reserved.
//

#import "QRCode.h"
#import <RubyLikeExtensions.h>


@implementation QRCode

#pragma mark - NSCoding Protocol

- (id)initWithCoder:(NSCoder *)aDecoder {
	_message = [aDecoder decodeObjectForKey:SELString(message)];
	_scanDate = [aDecoder decodeObjectForKey:SELString(scanDate)];
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:_message forKey:SELString(message)];
	[aCoder encodeObject:_scanDate forKey:SELString(scanDate)];
}

@end
