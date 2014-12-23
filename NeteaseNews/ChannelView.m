//
//  ChannelView.m
//  News
//
//  Created by leeXsen on 14-4-21.
//  Copyright (c) 2014年 leeXsen. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "ChannelView.h"
#import "Info.h"

@implementation ChannelTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.frame = frame;
        self.pullDelegate = self;
        self.dataSource = self;
        
        // 使分割线顶满屏幕
        if ([self respondsToSelector:@selector(setSeparatorInset:)])
            [self setSeparatorInset:UIEdgeInsetsZero];
        
        if ([self respondsToSelector:@selector(setLayoutMargins:)])
            [self setLayoutMargins:UIEdgeInsetsZero];
    }
    
    return self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _infoTableData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell;
    static NSString *cellWithIdentifier;
    
    if (indexPath.row == 0)
        cellWithIdentifier = @"TopCell";
    else
        cellWithIdentifier = @"Cell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellWithIdentifier];
    if (cell == nil) {
        if (indexPath.row == 0) {
            cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellWithIdentifier];
            cell.imgView.frame = CGRectMake(0, 0, 320, 185);
            cell.titleText.frame = CGRectMake(15, 185, 310, 25);
            cell.detailText.frame = CGRectMake(0, 185, 15, 25);
            cell.detailText.backgroundColor = [UIColor colorWithRed:227/255.0f green:227/255.0f blue:227/255.0f alpha:1.0f];
            cell.titleText.backgroundColor = [UIColor colorWithRed:227/255.0f green:227/255.0f blue:227/255.0f alpha:1.0f];
            cell.titleText.font = [UIFont systemFontOfSize:14.0f];
            
        } else {
            cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellWithIdentifier];
            cell.imgView.frame = CGRectMake(10, 5, 81, 62);
            cell.titleText.frame = CGRectMake(98, 5, 218, 25);
            cell.detailText.frame = CGRectMake(98, 30, 218, 43);
            cell.imgView.contentMode = UIViewContentModeScaleToFill;
            
            cell.titleText.font = [UIFont systemFontOfSize:16.0f];
            cell.detailText.font = [UIFont systemFontOfSize:13.0f];
            cell.detailText.textColor = [UIColor grayColor];
            
            /* 设置detailTextLabel自动换行 */
            cell.detailText.lineBreakMode = NSLineBreakByWordWrapping;
            cell.detailText.numberOfLines = 0;
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
    
    if (self.infoTableData.count != 0) {
        Info *info = self.infoTableData[indexPath.row];
        
        cell.titleText.text = info.title;
        cell.imgView.image = info.img;
        
        if (indexPath.row != 0)
            cell.detailText.text = info.desc;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
        return 210.0f;
    
    return 72.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_channelDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (void)pullRefresh
{
    [_channelDelegate pullRefresh];
    self.pullLastRefreshDate = [NSDate date];
    self.pullTableIsRefreshing = NO;
}

- (void)pullDownRefresh
{
    [_channelDelegate pullDownRefresh];
}

/* 实现上拉刷新的方法 */
- (void)pullTableViewDidTriggerRefresh:(PullTableView *)pullTableView
{
    [self performSelector:@selector(pullRefresh) withObject:nil afterDelay:0.0f];
}

/* 实现下拉刷新的方法 */
- (void)pullTableViewDidTriggerLoadMore:(PullTableView *)pullTableView
{
    [self performSelector:@selector(pullDownRefresh) withObject:nil afterDelay:0.0f];
}

// 使分割线顶满屏幕
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
        [cell setSeparatorInset:UIEdgeInsetsZero];
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
        [cell setLayoutMargins:UIEdgeInsetsZero];
}

@end