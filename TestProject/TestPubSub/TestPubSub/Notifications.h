//
//  Notifications.h
//  TestPubSub
//
//  Created by Joshua Wright on 6/4/13.
//  Copyright (c) 2013 Joshua Wright. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PubSub.h"


PubSub0(testWithZeroArgs)

PubSub1(testWithOneArg, \
        NSString*, a)

PubSub2(testWithTwoArgs, \
        NSString*, a, \
        NSString*, b)

PubSub3(testWithThreeArgs, \
        NSString*, a, \
        NSString*, b, \
        NSString*, c)



