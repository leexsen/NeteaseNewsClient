//
//  TopBarView.h
//  NeteaseNews
//
//  Created by leeXsen on 14-4-27.
//  Copyright (c) 2014年 leeXsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TopBarViewDelegate <NSObject>
- (void)click:(UIButton *)sender;
@end

@interface TopBarView : UIScrollView

@property (weak, nonatomic) id<TopBarViewDelegate> topBarDelegate;

- (id)initWithFrame:(CGRect)frame buttonSpacing:(CGFloat)buttonSpacing buttonFontSize:(CGFloat)buttonFontSize buttonTitles:(NSArray *)data;

@end