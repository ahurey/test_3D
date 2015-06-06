//
//  ViewController.m
//  test_3D
//
//  Created by space on 15/4/3.
//  Copyright (c) 2015年 ZY. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)NSMutableArray *images;
@property(nonatomic,strong)UIImageView *imageview;
@property(nonatomic)NSInteger index;
@property(nonatomic)NSInteger value;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.images = [NSMutableArray array];
    self.value = 0;
    NSFileManager *fm = [[NSFileManager alloc]init];
    NSString *Path = [[NSBundle mainBundle] pathForResource:@"屏幕快照 2015-04-03 下午2.23.20" ofType:@"png"];
    NSArray *arr = [Path componentsSeparatedByString:@"/屏幕快照"];
    
    NSString *path = arr[0];
    NSArray *array = [fm subpathsAtPath:path];
    [array enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj hasSuffix:@"png"]) {
//            NSLog(@"==%@",obj);
            [self.images addObject:obj];
        }
    }];
    
    self.imageview = [[UIImageView alloc]initWithFrame:self.view.frame];
    self.imageview.image = [UIImage imageNamed:@"屏幕快照 2015-04-03 下午2.23.20"];
    [self.view addSubview:self.imageview];
    self.imageview.userInteractionEnabled = YES;
    UIPinchGestureRecognizer *pin = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(ZZZ:)];
    [self.imageview addGestureRecognizer:pin];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint Point = [touch locationInView:self.view];
    self.index = Point.x;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint Point = [touch locationInView:self.view];
    if (self.index < Point.x) {
        self.value--;
    }else{
        self.value++;
    }
    self.index = Point.x;
    self.value = self.value<0?self.images.count-1:self.value;
    self.value = self.value>self.images.count-1?0:self.value;
    self.imageview.image = [UIImage imageNamed:self.images[self.value]];
}

-(void)ZZZ:(UIPinchGestureRecognizer *)pin{
    pin.scale = pin.scale < 1?1:pin.scale;
    pin.scale = pin.scale > 1.5?1.5:pin.scale;
    self.imageview.transform = CGAffineTransformMakeScale(pin.scale, pin.scale);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
