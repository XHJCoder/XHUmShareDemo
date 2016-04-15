//
//  ViewController.m
//  XHUmShareDemo
//
//  Created by huahua on 16/4/12.
//  Copyright © 2016年 jxh. All rights reserved.
//

#import "ViewController.h"
#import "UMSocial.h"
#import "XHCustomShareView.h"

@interface ViewController ()<UMSocialUIDelegate>
- (IBAction)shareAction:(id)sender;


- (IBAction)customShareAction:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//友盟提供的默认分享UI
- (IBAction)shareAction:(id)sender {
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"570c660367e58e91600010a5"
                                      shareText:@"花花的简书"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite,UMShareToQQ,UMShareToQzone,nil]
                                       delegate:self];
}


//自定义分享UI
- (IBAction)customShareAction:(id)sender {
    
    XHCustomShareView *shareView = [XHCustomShareView shareViewWithPresentedViewController:self items:@[UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQzone] title:@"欢迎进入花花的简书" image:[UIImage imageNamed:@"icon.png"] urlResource:nil];
    [[UIApplication sharedApplication].keyWindow addSubview:shareView];
}


//点击每个平台后默认会进入内容编辑页面，若想点击后直接分享内容，可以实现下面的回调方法
//弹出列表方法presentSnsIconSheetView需要设置delegate为self  默认yes
-(BOOL)isDirectShareInIconActionSheet
{
    return YES;
}

//实现回调方法
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}
@end
