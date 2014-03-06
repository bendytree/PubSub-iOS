
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
}

+ (void) forwardInvocation:(NSInvocation *)anInvocation
{    
    SEL aSelector = [anInvocation selector];
    
    __unsafe_unretained id keepAlive = nil;
    [anInvocation getArgument:&keepAlive atIndex:2];
    
    void(^callbackZero)(void) = nil;
    void(^callbackOne)(id arg1) = nil;
    void(^callbackTwo)(id arg1, id arg2) = nil;
    void(^callbackThree)(id arg1, id arg2, id arg3) = nil;
    [anInvocation getArgument:&callbackZero atIndex:3];
    [anInvocation getArgument:&callbackOne atIndex:3];
    [anInvocation getArgument:&callbackTwo atIndex:3];
    [anInvocation getArgument:&callbackThree atIndex:3];
    
    NSString* notificationName = [NSStringFromSelector(aSelector) componentsSeparatedByString:@":"][1];
    
    __weak id keepAliveWeakRef = keepAlive;
    __block id observer = [[NSNotificationCenter defaultCenter] addObserverForName:notificationName object:nil queue:[NSOperationQueue currentQueue] usingBlock:^(NSNotification* notification){
        id keepAliveStrong = keepAliveWeakRef;
        
        if(keepAliveStrong == nil){
            [[NSNotificationCenter defaultCenter] removeObserver:observer];
            return;
        }
        
        if(notification.userInfo.count == 0){
            callbackZero();
            return;
        }
        
        __block id (^getArgAtIndex)(NSString *) = ^id(NSString *index) {
            id result = notification.userInfo[index];
            if(result == [NSNull null]){
                return nil;
            }
            return result;
        };
        
        
        if(notification.userInfo.count == 1){
            callbackOne(getArgAtIndex(@"0"));
            return;
        }
        
        if(notification.userInfo.count == 2){
            callbackTwo(getArgAtIndex(@"0"), getArgAtIndex(@"1"));
            return;
        }
        
        if(notification.userInfo.count == 3){
            callbackThree(getArgAtIndex(@"0"), getArgAtIndex(@"1"), getArgAtIndex(@"2"));
            return;
        }
        
    }];
}

@end



@implementation Pub

+ (void) mockPublishZero { }
+ (void) mockPublishOne:(id)arg1 { }
+ (void) mockPublishTwo:(id)arg1 :(id)arg2 { }
+ (void) mockPublishThree:(id)arg1 :(id)arg2 :(id)arg3 { }

+ (NSMethodSignature *) methodSignatureForSelector:(SEL)selector
{

    NSMethodSignature* signature = [super methodSignatureForSelector:selector];
    if (!signature)
    {
        NSString *selectorName = NSStringFromSelector(selector);
        NSArray *selectorArgs = [selectorName componentsSeparatedByString:@":"];
        int argCount = selectorArgs.count - 1;
        if(argCount == 0) {
            signature = [self methodSignatureForSelector:@selector(mockPublishZero)];
        } else if(argCount == 1) {
            signature = [self methodSignatureForSelector:@selector(mockPublishOne:)];
        } else if(argCount == 2) {
            signature = [self methodSignatureForSelector:@selector(mockPublishTwo::)];
        } else if(argCount == 3) {
            signature = [self methodSignatureForSelector:@selector(mockPublishThree:::)];
        }
    }
    return signature;
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation
{
    
    NSString *selectorName = NSStringFromSelector(anInvocation.selector);
    NSArray *selectorArgs = [selectorName componentsSeparatedByString:@":"];

    NSString* notificationName = selectorArgs[0];
    
    NSMutableDictionary *argsDict = [NSMutableDictionary new];
    
    for (NSUInteger i = 0; i < (selectorArgs.count-1); i++) {
        id arg = nil;
        NSInteger paramIndex = i+2;
        [anInvocation getArgument:&arg atIndex:paramIndex];
        
        if(arg == nil){
            arg = [NSNull null];
        }
        
        [argsDict setObject:arg forKey:[[NSNumber numberWithInt:i] stringValue]];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:nil userInfo:argsDict];
}

@end
