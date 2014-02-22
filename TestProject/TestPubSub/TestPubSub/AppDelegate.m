//
//  AppDelegate.m
//  TestPubSub
//
//  Created by Joshua Wright on 6/4/13.
//  Copyright (c) 2013 Joshua Wright. All rights reserved.
//

#import "AppDelegate.h"
#import "Notifications.h"


@implementation AppDelegate{
    
    id keeper;
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    keeper = [[NSObject alloc] init];

    [Sub while:keeper nicknameChanged:^(NSString* newNickname) {
        NSLog(@"nickname changed to: %@", newNickname);
    }];
    
    [Pub nicknameChanged:@"A"];
    
    
    [Sub while:keeper testWithZeroArgs:^{
        NSLog(@"sub fired with zero args");
    }];
    [Pub testWithZeroArgs];
    
    [self performSelector:@selector(b) withObject:nil afterDelay:.1];
    [self performSelector:@selector(c) withObject:nil afterDelay:.15];
    [self performSelector:@selector(d) withObject:nil afterDelay:.2];
    
    return YES;
}

- (void) b
{
    NSLog(@"publishing b");
    [Pub nicknameChanged:@"B"];
}

- (void) c
{
    NSLog(@"keeper = nil");
    keeper = nil;
}

- (void) d
{
    NSLog(@"publishing d");
    [Pub nicknameChanged:@"D"];
}

@end
