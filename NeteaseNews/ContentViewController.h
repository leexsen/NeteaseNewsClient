//
//  ContentViewController.h
//  NeteaseNews
//
//  Created by leeXsen on 14-12-14.
//  Copyright (c) 2014年 leeXsen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController

- (ContentViewController *)init:(CGRect)frame docID:(NSString *)docID;

@property (strong, nonatomic) NSString *docID;

@end
