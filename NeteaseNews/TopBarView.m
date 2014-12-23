//
//  TopBarView.m
//  NeteaseNews
//
//  Created by leeXsen on 14-4-27.
//  Copyright (c) 2014年 leeXsen. All rights reserved.
//

#import "TopBarView.h"

@interface TopBarView ()
@property (strong, nonatomic) UILabel *topBarIndicator;
@end

@implementation TopBarView

- (id)initWithFrame:(CGRect)frame buttonSpacing:(CGFloat)buttonSpacing buttonFontSize:(CGFloat)buttonFontSize buttonTitles:(NSArray *)data
{
    self = [super initWithFrame:frame];
    
    if (self) {
        CGFloat x = 20;
        self.scrollsToTop = NO;
        
        for (NSString *name in data) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [button setTitle:name forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            button.titleLabel.font = [UIFont systemFontOfSize:buttonFontSize];
            [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchDown];
            
            CGSize buttonSize = [self stringSize:name font:button.titleLabel.font];
            button.frame = CGRectMake(x, (frame.size.height-buttonSize.height)/2, buttonSize.width, buttonSize.height);
            
            [self addSubview:button];
            x += buttonSize.width + buttonSpacing;
        }
        self.contentSize = CGSizeMake(x, frame.size.height);
        self.showsHorizontalScrollIndicator = NO;
        self.backgroundColor = [UIColor colorWithRed:230/255.0f green:230/255.0f blue:230/255.0f alpha:1.0f];
        
        CGSize buttonSize = [self stringSize:data[0] font:[UIFont systemFontOfSize:buttonFontSize]];
        _topBarIndicator = [[UILabel alloc] initWithFrame:CGRectMake(20, frame.size.height-3, buttonSize.width, 3)];
        _topBarIndicator.backgroundColor = [UIColor colorWithRed:190/255.0f green:2/255.0f blue:1/255.0f alpha:1.0f];
        
        [self addSubview:_topBarIndicator];
    }
    
    return self;
}

- (CGSize)stringSize:(NSString *)str font:(UIFont *)font
{
    return [str sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
}

- (void)click:(UIButton *)button
{
    [_topBarDelegate click:button];
    
    [UIView animateWithDuration:0.2f animations:^{
        /* 移动topBarIndicator */
        CGSize buttonSize = [self stringSize:button.titleLabel.text font:button.titleLabel.font];
        CGRect rect = _topBarIndicator.frame;
        
        _topBarIndicator.frame = CGRectMake(button.frame.origin.x, rect.origin.y, buttonSize.width, rect.size.height);
        
        /* 移动scrollView */
        CGFloat offsetX = self.contentOffset.x;
        CGFloat x = button.frame.origin.x - offsetX;
        x -= self.frame.size.width / 2;
        x += buttonSize.width / 2;
        
        if (x > 0) {
            CGFloat width = self.contentSize.width - offsetX - self.frame.size.width;
            x = x < width ? x : width;
        } else
            x = -x < offsetX ? x : -offsetX;
        
        self.contentOffset = CGPointMake(offsetX + x, self.contentOffset.y);
    }];
}

@end