//
//  AJLoadingHUD.h
//  AJLoadingHUD
//
//  Created by Arki-J on 2018/10/12.
//  Copyright © 2018 Arki-J. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AJLoadingHUD : UIView
-(void)start;

-(void)hide;

+(AJLoadingHUD*)showIn:(UIView*)view;

+(AJLoadingHUD*)hideIn:(UIView*)view;
@end

NS_ASSUME_NONNULL_END
