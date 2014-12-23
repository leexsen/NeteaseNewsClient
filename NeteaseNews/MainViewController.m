//
//  MainViewController.m
//  News
//
//  Created by leeXsen on 14-4-21.
//  Copyright (c) 2014年 leeXsen. All rights reserved.
//

#import "Downloader.h"
#import "TopBarView.h"
#import "MainViewController.h"
#import "ChannelViewController.h"

@interface MainViewController ()

@property (strong, nonatomic) NSMutableDictionary *topicSet;
@property (strong, nonatomic) ChannelViewController *currentChannelViewController;
@property (strong, nonatomic) TopBarView *topBar;

@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _topicSet = [[NSMutableDictionary alloc] initWithCapacity:31];
    
    [self initTopBar];
    [self initData];
}

- (void)initTopBar
{
    NSArray *data = @[@"头条", @"科技", @"原创", @"历史", @"手机", @"财经", @"电影", @"体育", @"轻松一刻"];
    
    _topBar = [[TopBarView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35) buttonSpacing:20 buttonFontSize:16 buttonTitles:data];
    _topBar.topBarDelegate = self;
    
    [self.view addSubview:_topBar];
}

- (void) initData
{
    NSString *url = @"http://c.m.163.com/nc/topicset/ios/v4/subscribe/news/all.html";
    
    [Downloader downloadJSON:url complete:^(NSDictionary *json, NSError *error) {
        NSArray *data = (NSArray *)json;
        
        for (NSDictionary *json in data) {
            NSArray *array = json[@"tList"];
            
            for (NSDictionary *jd in array)
                _topicSet[jd[@"tname"]] = jd;
        }

        /* init channel view controller */
        CGFloat heigh = _topBar.frame.size.height;
        CGRect frame = CGRectMake(0, heigh, self.view.frame.size.width, self.view.frame.size.height-heigh);
        NSString *channelID = _topicSet[@"头条"][@"tid"];
        NSString *channelName = @"头条";
        ChannelViewController *viewController = [[ChannelViewController alloc] init:frame channelID:channelID channelName:channelName];
        
        self.currentChildViewController = viewController;
    }];
}

- (void)setCurrentChildViewController:(ChannelViewController *)viewController
{
    [_currentChannelViewController willMoveToParentViewController:nil];
    [_currentChannelViewController.view removeFromSuperview];
    [_currentChannelViewController removeFromParentViewController];
    
    _currentChannelViewController = viewController;
    
    [self.view addSubview:_currentChannelViewController.view];
    [self addChildViewController:_currentChannelViewController];
    [_currentChannelViewController didMoveToParentViewController:self];
}

- (void)click:(UIButton *)sender
{
    NSString *name = sender.titleLabel.text;
    
    if ([name isEqualToString:_currentChannelViewController.channelName])
        return;
    
    CGFloat heigh = _topBar.frame.size.height;
    CGRect frame = CGRectMake(0, heigh, self.view.frame.size.width, self.view.frame.size.height-heigh);
    NSString *channelID = _topicSet[name][@"tid"];
    NSString *channelName = name;
    ChannelViewController *viewController = [[ChannelViewController alloc] init:frame channelID:channelID channelName:channelName];
    
    self.currentChildViewController = viewController;
}

@end