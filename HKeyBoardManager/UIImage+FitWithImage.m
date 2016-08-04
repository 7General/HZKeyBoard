//
//  UIImage+FitWithImage.m
//  GuoShui
//
//  Created by ysyc on 15/12/22.
//  Copyright © 2015年 ysyc. All rights reserved.
//

#import "UIImage+FitWithImage.h"

@implementation UIImage (FitWithImage)
+ (UIImage *)FitWithBackBgroudImage {
    UIImage * SizeWithImage = [UIImage imageNamed:@"whiteBack"];
    SizeWithImage = [SizeWithImage stretchableImageWithLeftCapWidth:SizeWithImage.size.width * 0.5 topCapHeight:SizeWithImage.size.height * 0.5];
    return SizeWithImage;
}

+ (UIImage *)FitWithBackConsoleViewImage {
    UIImage * SizeWithImage = [UIImage imageNamed:@"congsoleView"];
    SizeWithImage = [SizeWithImage stretchableImageWithLeftCapWidth:SizeWithImage.size.width * 0.5 topCapHeight:SizeWithImage.size.height * 0.5];
    return SizeWithImage;
}





@end
