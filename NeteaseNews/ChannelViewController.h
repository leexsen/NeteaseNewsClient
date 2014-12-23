//
//  ChannelViewController.h
//  News
//
//  Created by leeXsen on 14-4-21.
//  Copyright (c) 2014年 leeXsen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChannelView.h"

@interface ChannelViewController : UIViewController <ChannelTableViewDelegate>

- (ChannelViewController *)init:(CGRect)frame channelID:(NSString *)id channelName:(NSString *)name;

@property (strong, nonatomic) NSString *channelID;
@property (strong, nonatomic) NSString *channelName;

@end