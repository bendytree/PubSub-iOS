


## PubSub-iOS

PubSub-iOS is a very simple, block based wrapper around `NSNotificationCenter`.

Here's what it looks like:

    // Declare your notification
    PubSub(nameChanged, NSString)

    // Subscribe
    [Sub while:self nameChanged:^(NSString* name){
        NSLog(@"New Name: %@", name);
    }];
    
    // Publish
    [Pub nameChanged:@"Josh"];



## Getting Started

This library has no dependencies and requires arc.

### Copy 3 Files

Copy `PubSub.h`, `PubSub.m`, and `Notifications.h` into your XCode project. The PubSub files
do all the work and `Notifications.h` is where you declare your notifications.

If your project doesn't have ARC enabled, add the `-fobjc-arc` flag for `PubSub.m`.

### Import Notifications.h

In your `AppName-Prefix.pch` file, add `#import "Notifications.h"`. This makes it available
in all your classes. You can skip this step if you want to do it differently.

### Declare your Notifications

In `Notifications.h` you will use a preprocessor statement to declare your notifications. Declare one per line. For example:

    PubSub(nameChanged, NSString)
    
This generates two strongly typed methods that look kinda like this:

    @interface Pub
    + (void) nameChanged:(NSString*)arg;
    @end
    @interface Sub
    + (void) while:(id)obj nameChanged:(void(^)(NSString*))callback;
    @end

The first argument to `PubSub` is the name - it can be anything you want. The second argument
is the type of object you are sending out.
    
    
### Publishing

Now whenever you want to post a `nameChanged` notification, you just call:

    [Pub nameChanged:@"Josh"];
    
    
### Subscribing

When you want to subscribe to an event, you pass it the block of code that should run:

    [Sub while:self nameChanged:^(NSString* name){
        NSLog(@"New Name: %@", name);
    }];

The first argument `while` is the best part. It keeps a weak reference to an object. When
that object goes away, the subscription is automatically cancelled. So "while" the object
is not NULL, it subscribes.

For the most part you will pass `self`. That means when `self` goes away you are automatically
unsubscribed. No cleanup necessary.

Compare that to `NSNotificationCenter` where you have to retain an observer then you have
to explicitly unregister when you're done.

    
    
    
    
    
    
    
    
    
    
    
