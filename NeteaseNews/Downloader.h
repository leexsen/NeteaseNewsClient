//
//  Downloader.h
//  News
//
//  Created by leeXsen on 14-4-23.
//  Copyright (c) 2014年 leeXsen. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^block_img_t)(UIImage *, NSError *);
typedef void (^block_json_t)(NSDictionary *, NSError *);

@interface Downloader : NSObject

+ (void)downloadImage:(NSString *)url complete:(block_img_t)block;
+ (void)downloadJSON:(NSString *)url complete:(block_json_t)block;

@end