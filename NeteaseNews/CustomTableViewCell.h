//
//  CustomTableViewCell.h
//  NeteaseNews
//
//  Created by leeXsen on 14-4-24.
//  Copyright (c) 2014年 leeXsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView *imgView;
@property (strong, nonatomic) UILabel *titleText;
@property (strong, nonatomic) UILabel *detailText;

@end