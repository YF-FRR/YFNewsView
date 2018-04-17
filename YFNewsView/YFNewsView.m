//
//  YFNewsView.m
//  YFNewsView
//
//  Created by ios_yangfei on 2018/4/12.
//  Copyright © 2018年 jianghu3. All rights reserved.
//

#import "YFNewsView.h"
#import "UIView+Extension.h"

#define LabH 30

@interface YFNewsView ()<UIScrollViewDelegate>
@property(nonatomic,assign)int count;
@property(nonatomic,assign)YFNewsViewScrollType scrollType;
@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,strong)NSMutableArray *labsArr;

@property (nonatomic,assign) CGFloat timeInterval;
@property (nonatomic,assign) NSUInteger index;
@property (nonatomic,assign) CGRect currentRect;
@property (nonatomic, weak)  UIScrollView *scrollView;

@end

@implementation YFNewsView

-(instancetype)initWithNewsCount:(int)count frame:(CGRect)frame scrollType:(YFNewsViewScrollType)scrollType{
    if (self = [super initWithFrame:frame]) {
        _count = count;
        _timeInterval = 3;
        _currentRect = frame;
        _scrollType = scrollType;
        [self initScrollView];
        [self initLabs];
    }
    return self;
}

//初始化主滑动视图
-(void)initScrollView{
    
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.currentRect.size.width, self.currentRect.size.height)];
    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.scrollEnabled = NO;
    scrollView.contentSize = CGSizeMake(self.currentRect.size.width , (LabH + 10) * 6 + 10);
    scrollView.delegate = self;
    [scrollView setContentOffset:CGPointMake(0, (LabH + 10) * 2)];
    [self addSubview:scrollView];
    self.scrollView = scrollView;
}

//初始化imageview
-(void)initLabs{
    
    for (int i = 0; i < _count * 3; i++) {
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, LabH * i + 10 *(i + 1), _currentRect.size.width - 20, LabH)];
        [self.scrollView addSubview:lab];
        lab.font = [UIFont systemFontOfSize:14.0];
        lab.textColor = [UIColor blackColor];
        lab.lineBreakMode = NSLineBreakByTruncatingTail;
        lab.userInteractionEnabled = YES;
        lab.tag = 100 + i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickNews:)];
        [lab addGestureRecognizer:tap];
        
        [self.labsArr addObject:lab];
    }
    
}

-(void)clickNews:(UITapGestureRecognizer *)tap{
    NSInteger index = self.index + tap.view.tag % 2;
    NSLog(@"%ld",index);
//    YF_SAFE_BLOCK(self.clickBlock,index,@"");
}

//定时器事件
-(void)timerActive{
    
    [self.scrollView scrollRectToVisible:CGRectMake(0, (LabH + 10) * 4, self.currentRect.size.width, self.currentRect.size.height) animated:YES];
    
}


#pragma mark ======滚动处理=======
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y == 0) {
        if (self.index == 0) {
            self.index = self.dataSource.count - _count;
        }else{
            self.index -= _count;
        }
        [scrollView setContentOffset:CGPointMake(0 , (LabH + 10) * 2) animated:NO];
        
    }else if(scrollView.contentOffset.y == (LabH + 10) * 4){
        
        if (self.index == self.dataSource.count - _count ) {
            self.index = 0;
        }else{
            self.index += _count;
        }
        [scrollView setContentOffset:CGPointMake(0 , (LabH + 10) * 2) animated:NO];
    }
    
    [self resetText];
    
}

//触摸后停止定时器
- (void)scrollViewWillBeginDragging:( UIScrollView *)scrollView{
    
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

//触摸停止后再次启动定时器
- (void)scrollViewDidEndDragging:( UIScrollView *)scrollView willDecelerate:( BOOL )decelerate{
    if (self.timeInterval == 0) {
        return;
    }
    [self.timer fire];
}


// 重新分配图片
-(void)resetText{
    if (_dataSource.count == 0) return;
    //    NSLog(@"%ld",self.index);
    NSInteger count = _dataSource.count;
    UILabel *lab_1 = [self.scrollView viewWithTag:100];
    UILabel *lab_2 = [self.scrollView viewWithTag:101];
    UILabel *lab_3 = [self.scrollView viewWithTag:102];
    UILabel *lab_4 = [self.scrollView viewWithTag:103];
    UILabel *lab_5 = [self.scrollView viewWithTag:104];
    UILabel *lab_6 = [self.scrollView viewWithTag:105];
    
    if (self.index == 0) {
        //        for (NSInteger i=0; i<_count * 3; i++) {
        //            UILabel *lab = _labsArr[i];
        //            lab.text = _dataSource[i] ?: @"";
        //        }
        if (_dataSource.count < _count * 2) {
            lab_1.text = _dataSource[count - 2][@"title"];
            lab_2.text = _dataSource[count - 1][@"title"];
            lab_3.text = _dataSource[self.index][@"title"];
            lab_4.text = _dataSource[self.index + 1][@"title"];
        }else{
            lab_1.text = _dataSource[count - 2][@"title"];
            lab_2.text = _dataSource[count - 1][@"title"];
            lab_3.text = _dataSource[self.index][@"title"];
            lab_4.text = _dataSource[self.index + 1][@"title"];
            lab_5.text = _dataSource[self.index + 2][@"title"];
            lab_6.text = _dataSource[self.index + 3][@"title"];
        }
       
        
    }else if(self.index == self.dataSource.count - 2){
        //        for (NSInteger i=0; i<_count * 3; i++) {
        //            UILabel *lab = _labsArr[i];
        //            lab.text = _dataSource[ 1 + i];
        //        }
        
        lab_1.text = _dataSource[count - 4][@"title"];
        lab_2.text = _dataSource[count - 3][@"title"];
        lab_3.text = _dataSource[count - 2][@"title"];
        lab_4.text = _dataSource[count - 1][@"title"];
        lab_5.text = _dataSource[0][@"title"];
        lab_6.text = _dataSource[1][@"title"];
    }else{
        //        for (NSInteger i=0; i<_count * 3; i++) {
        //            UILabel *lab = _labsArr[i];
        //            NSInteger index = 1 + (self.index + i - _count);
        //            lab.text = _dataSource[index];
        //            NSLog(@"======%@",_dataSource[index]);
        //        }
        lab_1.text = _dataSource[self.index - _count][@"title"];
        lab_2.text = _dataSource[self.index - _count + 1][@"title"];
        lab_3.text = _dataSource[self.index - _count + 2][@"title"];
        lab_4.text = _dataSource[self.index - _count + 3][@"title"];
        lab_5.text = _dataSource[self.index - _count + 4][@"title"];
        lab_6.text = _dataSource[self.index - _count + 5][@"title"];
        //
        
    }
    
}

-(void)invalidateTimer{
    [self.timer invalidate];
    _timer = nil;
}

#pragma mark ====== Getter AND Setter=======
-(void)setDataSource:(NSArray *)dataSource{
    
    if (dataSource.count % 2 == 1) {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:dataSource];
        [arr addObject:@{@"title":@"adlfjaldsf"}];
        _dataSource = [arr copy];
    }else{
        _dataSource = dataSource;
    }
    
    if (dataSource.count <= _count ) {
        [_timer invalidate];
    }else{
        
        if (![_timer isValid]) {
            [self.timer fire];
        }
    }
    self.index = 0;
    [self resetText];
}

-(NSTimer *)timer{
    if (_timer==nil) {
        _timer = [[NSTimer alloc]initWithFireDate:[NSDate dateWithTimeIntervalSinceNow:self.timeInterval]
                                         interval:self.timeInterval
                                           target:self
                                         selector:@selector(timerActive)
                                         userInfo:nil
                                          repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

-(NSMutableArray *)labsArr{
    if (_labsArr==nil) {
        _labsArr=[[NSMutableArray alloc] init];
    }
    return _labsArr;
}
@end


