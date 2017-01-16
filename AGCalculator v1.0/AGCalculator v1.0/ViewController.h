//
//  ViewController.h
//  AGCalculator v1.0
//
//  Created by Anton Gorlov on 11.04.16.
//  Copyright © 2016 Anton Gorlov. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *indicatorLabel;
- (IBAction)actionButtons:(UIButton *)sender;
- (IBAction)actionOperationButtons:(UIButton *)sender;
- (IBAction)actionCleanButton:(UIButton *)sender;
- (IBAction)actionEquallyButton:(UIButton *)sender;
- (IBAction)actionPlusMinus:(UIButton *)sender;
- (IBAction)actionPoint:(UIButton *)sender;

@end

