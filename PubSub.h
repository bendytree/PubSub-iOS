
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




// Variable expansion with variable arguments thanks to
// http://stackoverflow.com/questions/11761703/overloading-macro-on-number-of-arguments
// TODO look at a generic PubSub(name, ...) macro?


#define PubSub0(name) \
@interface Pub (PubSub_ ## name ## _Category) \
+ (void) name; \
@end\
@interface Sub (PubSub_ ## name ## _Category)\
+ (void) while:(id)obj name:(void(^)(void))callback;\
@end

#define PubSub1(name, arg1Type, arg1Name) \
@interface Pub (PubSub_ ## name ## _Category) \
+ (void) name:(arg1Type)arg1Name; \
@end\
@interface Sub (PubSub_ ## name ## _Category)\
+ (void) while:(id)obj name:(void(^)(arg1Type arg1Name))callback;\
@end

#define PubSub2(name, arg1Type, arg1Name, arg2Type, arg2Name) \
@interface Pub (PubSub_ ## name ## _Category) \
+ (void) name:(arg1Type)arg1Name arg2Name:(arg2Type)arg2Name; \
@end\
@interface Sub (PubSub_ ## name ## _Category)\
+ (void) while:(id)obj name:(void(^)(arg1Type arg1Name, arg2Type arg2Name))callback;\
@end


#define PubSub3(name, arg1Type, arg1Name, arg2Type, arg2Name, arg3Type, arg3Name) \
@interface Pub (PubSub_ ## name ## _Category) \
+ (void) name:(arg1Type)arg1Name arg2Name:(arg2Type)arg2Name arg3Name:(arg3Type)arg3Name; \
@end\
@interface Sub (PubSub_ ## name ## _Category)\
+ (void) while:(id)obj name:(void(^)(arg1Type arg1Name, arg2Type arg2Name, arg3Type arg3Name))callback;\
@end



