//
//  tmCustomSegue.m
//  TimeReport
//
//  Created by Nils Cronstedt on 2013-08-15.
//  Copyright (c) Nils Cronstedt 2013 All rights reserved.
//

#import "tmCustomSegue.h"

@implementation tmCustomSegue

- (void) perform {
    
    UIViewController *src = (UIViewController *) self.sourceViewController;
    UIViewController *dst = (UIViewController *) self.destinationViewController;
    
    [UIView transitionWithView:src.view
                      duration:0.5
                       options:UIViewAnimationOptionTransitionFlipFromBottom
                    animations:^{ [dst.   view removeFromSuperview]; [src.view addSubview:dst.view]; }
                    completion:NULL];
    
    /*
    [UIView transitionWithView:src.view duration:0.2 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
                        [dst.navigationController pushViewController:src.navigationController animated:YES];
                    }
    completion:NULL];

    */
    
}


@end

/*
 [UIView beginAnimations:nil context:nil];
 [UIView setAnimationDuration:0.5];
 [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.view cache:YES];
 [self.view addSubview:myText];
 [UIView commitAnimations]; 
*/