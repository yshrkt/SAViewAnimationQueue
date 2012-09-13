//
//  SAViewAnimationQueue.h
//  SAViewAnimationQueueSample
//
//  Created by Yoshihiro Kato on 12/03/01.
//  Copyright (c) 2012年 Yoshihiro Kato. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAViewAnimationQueue : NSObject
{
    NSMutableArray* _queue;
}

+ (id)queue;
- (void)addAnimationWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations;
- (void)addAnimationWithDuration:(NSTimeInterval)duration 
                      animations:(void (^)(void))animations 
                      completion:(void (^)(BOOL finished))completion;
- (void)addAnimationWithDuration:(NSTimeInterval)duration 
                           delay:(NSTimeInterval)delay 
                         options:(UIViewAnimationOptions)options 
                      animations:(void (^)(void))animations 
                      completion:(void (^)(BOOL finished))completion;
- (void)start;
@end
