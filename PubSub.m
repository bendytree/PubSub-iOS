
//
// PubSub.m
//
// Josh Wright
// http://bendytree.com
// @BendyTree
// June 4, 2013
//
// Use this however you want.
//

#import "PubSub.h"
#import <Foundation/Foundation.h>


@implementation Sub

+ (id) mockSubscribeWhile:(id)keepAlive callback:(void(^)(id arg))callback { return nil; }

+ (NSMethodSignature *) methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (!signature) {
        signature = [self methodSignatureForSelector:@selector(mockSubscribeWhile:callback:)];
    }
    return signature;
    
    return nil;
}

+ (void) forwardInvocation:(NSInvocation *)anInvocation
{    
    SEL aSelector = [anInvocation selector];
    
    __unsafe_unretained id keepAlive = nil;
    [anInvocation getArgument:&keepAlive atIndex:2];
    
    void(^callback)(id arg) = nil;
    [anInvocation getArgument:&callback atIndex:3];
    
    NSString* notificationName = [NSStringFromSelector(aSelector) componentsSeparatedByString:@":"][1];
    
    __weak id keepAliveWeakRef = keepAlive;
    __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:notificationName object:nil queue:[NSOperationQueue currentQueue] usingBlock:^(NSNotification* notification){
        id keepAliveStrong = keepAliveWeakRef;
        
        if(keepAliveStrong == nil){
            [[NSNotificationCenter defaultCenter] removeObserver:observer];
            return;
        }
        
        callback(notification.object);
    }];
}

@end



@implementation Pub

+ (void) mockPublish:(id)arg { }

+ (NSMethodSignature *) methodSignatureForSelector:(SEL)selector
{
    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (!signature)
    {
        signature = [self methodSignatureForSelector:@selector(mockPublish:)];
    }
    return signature;
}

+ (void)forwardInvocation:(NSInvocation *)i
{
    id arg = nil;
    [i getArgument:&arg atIndex:2];
    
    NSString* notificationName = [NSStringFromSelector(i.selector) componentsSeparatedByString:@":"][0];
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:arg];
}

@end
