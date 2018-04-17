//
//  YFNewsView.h
//  YFNewsView
//
//  Created by ios_yangfei on 2018/4/12.
//  Copyright © 2018年 jianghu3. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YFNewsViewScrollType) {
    YFNewsViewScrollTypeScroll,
    YFNewsViewScrollTypeCube,
};

@interface YFNewsView : UIView

@property(nonatomic,strong)NSArray *dataSource;

-(instancetype)initWithNewsCount:(int)count frame:(CGRect)frame scrollType:(YFNewsViewScrollType)scrollType;
@end
