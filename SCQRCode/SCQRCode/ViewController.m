//
//  ViewController.m
//  SCQRCode
//
//  Created by admin on 2018/11/15.
//  Copyright © 2018 admin. All rights reserved.
//

#import "ViewController.h"
#import <CoreImage/CoreImage.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *QRCodeImage;

@end 

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createQRCodeImage];
}

- (void)createQRCodeImage {
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];

    [filter setDefaults];

//    NSString *dataString = @"拜拜拜";
    NSString *dataString = @"https://onevcat.com/#blog";
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];

    [filter setValue:data forKey:@"inputMessage"];//value必须是NSData类型

    CIImage *outputImage = [filter outputImage];

    CGFloat scale = CGRectGetWidth(self.QRCodeImage.bounds) / CGRectGetWidth(outputImage.extent);
    CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
    CIImage *transformImage = [outputImage imageByApplyingTransform:transform];

    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:transformImage fromRect:transformImage.extent];

    self.QRCodeImage.image = [UIImage imageWithCGImage:imageRef];
}


@end
