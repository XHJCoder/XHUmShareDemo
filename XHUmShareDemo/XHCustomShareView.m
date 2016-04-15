//
//  XHCustomShareView.m
//  XHUmShareDemo
//
//  Created by huahua on 16/4/12.
//  Copyright © 2016年 jxh. All rights reserved.
//

#import "XHCustomShareView.h"
#define KHeight self.frame.size.height
#define kWidth self.frame.size.width
#define ShareViewHeight 155

@interface XHCustomShareView()

@property (nonatomic,strong)NSArray *items;
@property (nonatomic,copy)NSString *title;
@property (nonatomic,copy)UIImage *image;
@property (nonatomic,copy)NSString *url;
@property (nonatomic,strong)UIViewController *controller;


@property (nonatomic,strong)UIView *buttomView;
@property (nonatomic,strong)UIView *contentView;

@end

@implementation XHCustomShareView

#pragma mark - 自定义初始化类方法
+(instancetype)shareViewWithPresentedViewController:(UIViewController *)controller items:(NSArray *)items title:(NSString *)title image:(UIImage *)image urlResource:(NSString *)url{
    XHCustomShareView *view = [[XHCustomShareView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    
    view.title = title;
    view.url = url;
    view.image = image;
    view.items = items;
    view.controller = controller;
    
    [view createShareView];
    
    return view;
}

#pragma mark - 创建分享UI
-(void)createShareView{
    /*------------------  添加蒙板  -------------------*/
    _buttomView = [[UIView alloc] initWithFrame:self.bounds];
    _buttomView.backgroundColor = [UIColor blackColor];
    _buttomView.alpha = 0.0;
    [_buttomView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissShareView)]];
    [self addSubview:_buttomView];
    /*------------------------------------------------*/
    
    /*---------- 内容view，包括分享itemsView以及取消按钮 ----------*/
   _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, KHeight, kWidth, ShareViewHeight)];
    _contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:_contentView];
    
    //分享ItemsView
    UIScrollView *shareItemView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 0, kWidth-20, 100)];
    shareItemView.backgroundColor = [UIColor whiteColor];
    shareItemView.layer.cornerRadius = 10;
    shareItemView.layer.masksToBounds = YES;
    shareItemView.showsVerticalScrollIndicator = NO;
    shareItemView.showsHorizontalScrollIndicator = NO;
    [_contentView addSubview:shareItemView];
    
    if (_items.count) {
        CGFloat itemWidth  = 50;
        CGFloat itemHeight = 50;
        CGFloat pading = _items.count<5 ? (shareItemView.width-itemHeight*_items.count)/(_items.count+1) : 30;
        for (int i=0; i<_items.count; i++) {
            UIButton * itemBtn = [[UIButton alloc] initWithFrame:CGRectMake((itemWidth+pading)*i+pading, 15, itemWidth, itemHeight)];
            itemBtn.tag = i;
            NSString *itemName =  [self getTitleAndImageWithItem:itemBtn];
            [itemBtn addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
        
            [shareItemView addSubview:itemBtn];
            
            UILabel *itemLabel = [[UILabel alloc] initWithFrame:CGRectMake(itemBtn.left, itemBtn.bottom+5, itemWidth, 20)];
            itemLabel.text = itemName;
            itemLabel.font = [UIFont systemFontOfSize:12];
            itemLabel.textAlignment = NSTextAlignmentCenter;
            [shareItemView addSubview:itemLabel];
        }
        shareItemView.contentSize = CGSizeMake((itemWidth+pading)*_items.count+pading, 0);
    }

    //取消按钮
    UIButton *cancelbtn = [[UIButton alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(shareItemView.frame)+10, kWidth-20, 40)];
    cancelbtn.layer.cornerRadius = 10;
    cancelbtn.layer.masksToBounds = YES;
    [cancelbtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelbtn.backgroundColor = [UIColor whiteColor];
    [cancelbtn addTarget:self action:@selector(dismissShareView) forControlEvents:UIControlEventTouchUpInside];
    [cancelbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_contentView addSubview:cancelbtn];
    
    [UIView animateWithDuration:0.3 animations:^{
        _buttomView.alpha = 0.3;
        _contentView.frame = CGRectMake(0, KHeight-ShareViewHeight, kWidth, ShareViewHeight);
        
    }];
    
    /*----------------------------------------------------------*/
    
}

#pragma mark - 设置item图片以及获取title
-(NSString *)getTitleAndImageWithItem:(UIButton *)itemBtn{
    NSString *itemTitle = @"";
    NSString *itemImage = @"";
    NSString *type = _items[itemBtn.tag];
    if ([type isEqualToString:UMShareToQzone]) {
        itemTitle = @"QQ空间";
        itemImage = @"share_qzone";
    }
    else if([type isEqualToString:UMShareToQQ])
    {
        itemTitle = @"QQ";
        itemImage = @"";
    }
    else if([type isEqualToString:UMShareToWechatSession])
    {
        itemTitle = @"微信好友";
        itemImage = @"share_weixin";
    }
    else if([type isEqualToString:UMShareToWechatTimeline])
    {
        itemTitle = @"朋友圈";
        itemImage = @"share_circle";
    }
    else if([type isEqualToString:UMShareToWechatFavorite])
    {
        itemTitle = @"微信收藏";
        itemImage = @"";
    }
    else if([type isEqualToString:UMShareToSina])
    {
        itemTitle = @"新浪";
        itemImage = @"share_sina";
    }
    else{
        NSLog(@"其他设备自行添加");
    }
    
    [itemBtn setImage:[UIImage imageNamed:itemImage] forState:UIControlStateNormal];
    
    return itemTitle;
}

#pragma mark - 点击item进行分享操作
-(void)itemClick:(UIButton *)btn{
    NSInteger index = btn.tag;
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[_items[index]] content:_title image:_image location:nil urlResource:nil presentedController:_controller completion:^(UMSocialResponseEntity *response){
        if (response.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}


#pragma mark - 点击 取消或者蒙板 消除分享View
-(void)dismissShareView{
    
    [UIView animateWithDuration:0.3 animations:^{
        _buttomView.alpha = 0.0;
        _contentView.frame = CGRectMake(0, KHeight, kWidth, ShareViewHeight);
    } completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    }];
    
}




@end
