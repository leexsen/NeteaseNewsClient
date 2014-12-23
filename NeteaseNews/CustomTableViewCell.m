//
//  CustomTableViewCell.m
//  NeteaseNews
//
//  Created by leeXsen on 14-4-24.
//  Copyright (c) 2014年 leeXsen. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        _imgView = [UIImageView new];
        _titleText = [UILabel new];
        _detailText = [UILabel new];
        
        [self.contentView addSubview:_imgView];
        [self.contentView addSubview:_detailText];
        [self.contentView addSubview:_titleText];
    }
    
    return self;
}

@end