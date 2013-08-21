//
//  CustomAlert.h
//  TimeReport
//
//  Created by Nils Cronstedt on 2013-08-15.
//  Copyright (c) Nils Cronstedt 2013 All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlert : UIAlertView
{
    
}

+ (void) setBackgroundColor:(UIColor *) background 
            withStrokeColor:(UIColor *) stroke;
@property(retain, nonatomic) UIColor *fillColor ;
@property(retain, nonatomic) UIColor *borderColor ;
@end