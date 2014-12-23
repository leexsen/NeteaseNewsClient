//
//  ChannelViewController.m
//  News
//
//  Created by leeXsen on 14-4-21.
//  Copyright (c) 2014年 leeXsen. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>

#import "ContentViewController.h"
#import "ChannelViewController.h"
#import "Downloader.h"
#import "Info.h"

@interface ChannelViewController ()
{
    int pageNum;
}

@property (strong, nonatomic) NSMutableArray *infoList;
@property (strong, nonatomic) ChannelTableView *channelView;

@end

@implementation ChannelViewController

- (ChannelViewController *)init:(CGRect)frame channelID:(NSString *)id channelName:(NSString *)name
{
    self = [super init];
    
    if (self) {
        self.channelID = id;
        self.channelName = name;
        self.view.frame = frame;
        self.infoList = [[NSMutableArray alloc] initWithCapacity:20];
        [self getData];
        
        CGSize size = self.view.frame.size;
        _channelView = [[ChannelTableView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
        _channelView.channelDelegate = self;
        _channelView.infoTableData = self.infoList;
        [self.view addSubview:_channelView];
    }
    
    return self;
}

- (void)getData
{
    NSString *url;
    if ([_channelName isEqual:@"头条"])
        url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/%@/%d-20.html", _channelID, pageNum*20];
    else
        url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/list/%@/%d-20.html", _channelID, pageNum*20];
    
    [Downloader downloadJSON:url complete:^(NSDictionary *json, NSError *error) {
        NSArray *data = json[_channelID];
        
        for (NSDictionary *d in data) {
            Info *info = [Info new];
            
            info.title = d[@"title"];
            info.replyCount = d[@"replyCount"];
            info.desc = d[@"digest"];
            
            if (d[@"specialextra"])
                info.docID = d[@"specialextra"][0][@"docid"];
            else
                info.docID = d[@"docid"];
            
            [_infoList addObject:info];
            
            // using this method is due to the fucking Neweast's API
            NSString *imgsrc = d[@"imgsrc"];
            NSString *imgSize;
            imgsrc = [imgsrc substringFromIndex:30];
            if (d[@"hasHead"] != nil)
                imgSize = @"640x370";
            else
                imgSize = @"162x124";
            
            NSString *url = @"http://s.cimg.163.com/pi/img3.cache.netease.com/%@.%@.auto.webp";
            url = [NSString stringWithFormat:url, imgsrc, imgSize];
          
            [Downloader downloadImage:url complete:^(UIImage *img, NSError *error) {
                info.img = img;
                [_channelView reloadData];
            }];
        }
        
        [_channelView reloadData];
        _channelView.pullTableIsLoadingMore = NO;
    }];
}

/* 上拉刷新 */
- (void)pullRefresh
{
    [_infoList removeAllObjects];
    pageNum = 0;
    [self getData];
}

/* 下拉刷新 */
- (void)pullDownRefresh
{
    ++pageNum;
    [self getData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height+35); // 35 is width of topBar
    NSString *docID = ((Info *)self.infoList[indexPath.row]).docID;
    ContentViewController *viewController = [[ContentViewController alloc] init:frame docID:docID];
    
    [self.navigationController pushViewController:viewController animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end