//
//  ContentViewController.m
//  NeteaseNews
//
//  Created by leeXsen on 14-12-14.
//  Copyright (c) 2014年 leeXsen. All rights reserved.
//

#import "Downloader.h"
#import "ContentViewController.h"

@interface ContentViewController ()

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation ContentViewController

- (ContentViewController *)init:(CGRect)frame docID:(NSString *)docID
{
    self = [super init];
    
    if (self) {
        self.docID = docID;
        self.view.frame = frame;
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBar.backIndicatorImage = nil;
        
        self.webView = [[UIWebView alloc] initWithFrame:frame];
        [self.view addSubview:self.webView];
        
        NSString *url = @"http://c.3g.163.com/nc/article/%@/full.html";
        url = [NSString stringWithFormat:url, self.docID];
        [Downloader downloadJSON:url complete:^(NSDictionary *data, NSError *error) {
            NSDictionary *d = data[self.docID];
            
            NSString *str = [self parse:d[@"img"] str:d[@"body"]];
            [self.webView loadHTMLString:str baseURL:nil];
        }];
    }
    
    return self;
}

- (NSString *)parse:(NSArray *)imgUrlSet str:(NSString *)str
{
    NSString *replace = @"<img width=304 src=%@></img>";
    NSString *search = @"<!--IMG#%d-->";
    NSMutableString *body = [NSMutableString stringWithString:str];
    NSRange range;
    
    for (int i = 0; i < imgUrlSet.count; i++) {
        NSString *s = [NSString stringWithFormat:search, i];
        range = [body rangeOfString:s];
        
        if (range.length != NSNotFound) {
            NSString *urlStr = imgUrlSet[i][@"src"];
            urlStr = [urlStr substringFromIndex:30];
            urlStr = [NSString stringWithFormat:@"http://s.cimg.163.com/i/img3.cache.netease.com/%@.640x200.75.auto.jpg", urlStr];
            NSString *str= [NSString stringWithFormat:replace, urlStr];
            
            [body replaceCharactersInRange:range withString:str];
        }
    }
    
    return body;
}

@end
