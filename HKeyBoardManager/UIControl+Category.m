//
//  UIControl+Category.m
//  KeyBoard
//
//  Created by 王会洲 on 16/1/13.
//  Copyright © 2016年 王会洲. All rights reserved.
//

#import "UIControl+Category.h"
#import "objc/runtime.h"

static const void * OrderTagsBy = &OrderTagsBy;

@implementation UIControl (Category)
@dynamic OrderTags;


-(void)setOrderTags:(NSString *)OrderTags {
    objc_setAssociatedObject(self, OrderTagsBy, OrderTags, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)OrderTags {
  return objc_getAssociatedObject(self, OrderTagsBy);
}

@end
