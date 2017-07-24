//
//  UIColor+App.h
//
//  Created by Bob de Graaf on 10-03-14.
//  Copyright (c) 2014 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (App)

//App Colors

//Utilities
+(UIImage *)imageFromColor:(UIColor *)color;
+(UIColor *)colorFromHexCode:(NSString *)hexCode;

@end
