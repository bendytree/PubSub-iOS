
//
// PubSub.h
//
// Josh Wright
// http://bendytree.com
// @BendyTree
// June 4, 2013
//
// Use this however you want.
//

#import <Foundation/Foundation.h>

@interface Pub : NSObject
@end

@interface Sub : NSObject
@end


#define PubSub(name, type) \
@interface Pub (PubSub_ ## name ## _Category) \
+ (void) name:(type*)arg; \
@end\
@interface Sub (PubSub_ ## name ## _Category)\
+ (void) while:(id)obj name:(void(^)(type*))callback;\
@end

