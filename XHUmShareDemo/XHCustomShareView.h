//
//  XHCustomShareView.h
//  XHUmShareDemo
//
//  Created by huahua on 16/4/12.
//  Copyright © 2016年 jxh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocial.h"


@interface XHCustomShareView : UIView

+(instancetype)shareViewWithPresentedViewController:(UIViewController *)controller items:(NSArray *)items title:(NSString *)title image:(UIImage *)image urlResource:(NSString *)url;

@end
