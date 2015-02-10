//
//  QRCode.h
//  QRBook
//
//  Created by Konstantin Sukharev on 10/02/15.
//  Copyright (c) 2015 P0ed. All rights reserved.
//


@import Foundation;


@interface QRCode : NSObject <NSCoding>
@property (nonatomic) NSString *message;
@property (nonatomic) NSDate *scanDate;
@end
