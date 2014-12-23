//
//  ChannelView.h
//  News
//
//  Created by leeXsen on 14-4-21.
//  Copyright (c) 2014年 leeXsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullTableView.h"

@protocol ChannelTableViewDelegate <NSObject>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)pullRefresh;
- (void)pullDownRefresh;

@end

@interface ChannelTableView : PullTableView <UITableViewDataSource, PullTableViewDelegate>

@property (weak, nonatomic) id<ChannelTableViewDelegate> channelDelegate;
@property (weak, nonatomic) NSMutableArray *infoTableData;

- (id)initWithFrame:(CGRect)frame;
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end