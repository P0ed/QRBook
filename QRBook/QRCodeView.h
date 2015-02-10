//
//  QRCodeView.h
//  QRBook
//
//  Created by Konstantin Sukharev on 10/02/15.
//  Copyright (c) 2015 P0ed. All rights reserved.
//


@import UIKit;


IB_DESIGNABLE @interface QRCodeView : UIImageView

@property (nonatomic) NSData *dataValue;
@property (nonatomic) IBInspectable NSString *stringValue;

@end
