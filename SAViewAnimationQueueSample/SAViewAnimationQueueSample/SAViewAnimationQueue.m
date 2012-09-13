//
//  SAViewAnimationQueue.m
//  SAViewAnimationQueueSample
//
//  Created by Yoshihiro Kato on 12/03/01.
//  Copyright (c) 2012年 Yoshihiro Kato. All rights reserved.
//

#import "SAViewAnimationQueue.h"

@interface SAViewAnimationQueueItem : NSObject {
@private
    NSTimeInterval _duration;
    NSTimeInterval _delay;
    UIViewAnimationOptions _options;
    void (^_animations)(void);
    void (^_completion)(BOOL finished);
}
@property (nonatomic, readonly)NSTimeInterval duration;
@property (nonatomic, readonly)NSTimeInterval delay;
@property (nonatomic, readonly)UIViewAnimationOptions options;
@property (nonatomic, readonly)void (^animations)(void);
@property (nonatomic, readonly)void (^completion)(BOOL finished);

- (id)initWithDuration:(NSTimeInterval)duration 
                 delay:(NSTimeInterval)delay 
               options:(UIViewAnimationOptions)options 
            animations:(void (^)(void))animations 
            completion:(void (^)(BOOL finished))completion;
@end

@implementation SAViewAnimationQueueItem
@synthesize duration = _duration;
@synthesize delay = _delay;
@synthesize options = _options;
@synthesize animations = _animations;
@synthesize completion = _completion;

- (id)initWithDuration:(NSTimeInterval)duration 
                 delay:(NSTimeInterval)delay 
               options:(UIViewAnimationOptions)options 
            animations:(void (^)(void))animations 
            completion:(void (^)(BOOL finished))completion {
    self = [super init];
    if(self){
        _duration = duration;
        _delay = delay;
        _options = options;
        _animations = [animations copy];
        _completion = [completion copy];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
    _animations = nil;
    _completion = nil;
}

@end

@implementation SAViewAnimationQueue
+ (id)queue {
    return [[SAViewAnimationQueue alloc] init];
}

- (id)init{
    self = [super init];
    if(self){
        _queue = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)dealloc{
    _queue = nil;
}

- (void)addAnimationWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations {
    SAViewAnimationQueueItem* item;
    item = [[SAViewAnimationQueueItem alloc] initWithDuration:duration 
                                                        delay:0 
                                                      options:0 
                                                   animations:animations 
                                                   completion:nil];
    [_queue insertObject:item atIndex:0];
}

- (void)addAnimationWithDuration:(NSTimeInterval)duration 
                      animations:(void (^)(void))animations 
                      completion:(void (^)(BOOL finished))completion {
    SAViewAnimationQueueItem* item;
    item = [[SAViewAnimationQueueItem alloc] initWithDuration:duration 
                                                        delay:0 
                                                      options:0
                                                   animations:animations 
                                                   completion:completion];
    [_queue insertObject:item atIndex:0];
}

- (void)addAnimationWithDuration:(NSTimeInterval)duration 
                           delay:(NSTimeInterval)delay 
                         options:(UIViewAnimationOptions)options 
                      animations:(void (^)(void))animations 
                      completion:(void (^)(BOOL finished))completion {
    SAViewAnimationQueueItem* item;
    item = [[SAViewAnimationQueueItem alloc] initWithDuration:duration 
                                                        delay:delay 
                                                      options:options 
                                                   animations:animations 
                                                   completion:completion];
    [_queue insertObject:item atIndex:0];
}

- (void)startAnimationWithItem:(SAViewAnimationQueueItem*)item {
    NSLog(@"%s", __FUNCTION__);
    [UIView animateWithDuration:item.duration 
                          delay:item.delay 
                        options:item.options 
                     animations:item.animations 
                     completion:^(BOOL finsished){
                         if(item.completion){
                             item.completion(finsished);
                         }
                         [_queue removeLastObject];
                         if([_queue count] > 0)
                             [self startAnimationWithItem:[_queue lastObject]];
                     }];
}

- (void)start {
    if([_queue count] > 0){
        [self startAnimationWithItem:[_queue lastObject]];
    }
}
@end
