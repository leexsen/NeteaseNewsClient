//
//  Downloader.m
//  News
//
//  Created by leeXsen on 14-4-23.
//  Copyright (c) 2014年 leeXsen. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "Downloader.h"

@implementation Downloader

+ (void)downloadImage:(NSString *)url complete:(block_img_t)block
{
    NSURL *imgUrl = [NSURL URLWithString:url];
    [[SDWebImageManager sharedManager] downloadImageWithURL:imgUrl options:0 progress:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        if (finished) {
            block(image, error);
        }
    }];
}

+ (void)downloadJSON:(NSString *)url complete:(block_json_t)block
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSError *error;
        
        NSData *data = [Downloader readDataFromNetwork:url error:&error];
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            block(json, error);
        });
    });
}

+ (NSData *)readDataFromNetwork:(NSString *)urlStr error:(NSError **)error
{
    NSURL *url = [NSURL URLWithString:urlStr];
    
    NSURLResponse *response;
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSData *data = [NSURLConnection
                    sendSynchronousRequest:request
                    returningResponse:&response
                    error:error];
    
    return data;
}

@end