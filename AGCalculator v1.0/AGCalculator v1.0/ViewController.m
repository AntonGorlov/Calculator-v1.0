//
//  ViewController.m
//  AGCalculator v1.0
//
//  Created by Anton Gorlov on 11.04.16.
//  Copyright © 2016 Anton Gorlov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

typedef enum {
    
    AGOperatorsMinus,
    AGOperatorsPlus,
    AGOperatorsMultiplication, //умножение
    AGOperatorsDivide, // Деление
    AGOperatorsReset //удалять (чистить)
    
} AGOperators;

@property (strong, nonatomic) NSMutableString* tempNumberOne;
@property (assign, nonatomic) double firstNumber;
@property (assign, nonatomic) double secondNumber;
@property (assign, nonatomic) BOOL equalingDone;
@property (assign, nonatomic) AGOperators operatorsEnum;
@property (assign, nonatomic) NSInteger twoActionsIsEqual;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tempNumberOne = [[NSMutableString alloc] init];
    self.operatorsEnum = AGOperatorsReset;
    self.twoActionsIsEqual = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark- Actions

- (IBAction)actionButtons:(UIButton *)sender {
    
    NSLog(@"action Buttons tag = %ld",(long)sender.tag);//выводит на консоль какие кнопки нажали
    self.indicatorLabel.text = [NSString stringWithFormat:@"%ld",(long)sender.tag];//выводит на экран какие кнопки нажали
    
    if (self.operatorsEnum == AGOperatorsReset) {
        self.secondNumber = 0;
        NSLog(@"button number - %ld pressed", sender.tag);
        [self.tempNumberOne appendString:[NSString stringWithFormat:@"%ld", sender.tag]];
        self.indicatorLabel.text = self.tempNumberOne;
        self.firstNumber = [[NSString stringWithFormat:@"%@",self.tempNumberOne]doubleValue]; // put NSString to number property
        
        NSLog(@"firstNumber - %.2f", self.firstNumber);
    } else {
        NSLog(@"button number - %ld pressed", sender.tag);
        [self.tempNumberOne appendString:[NSString stringWithFormat:@"%ld", sender.tag]];
        self.indicatorLabel.text = self.tempNumberOne; // увеличивает число на экране
        self.secondNumber = [[NSString stringWithFormat:@"%@",self.tempNumberOne]doubleValue]; // put NSString to number property
        
        NSLog(@"secondNumber - %.2f", self.secondNumber);
    }

}

- (IBAction)actionOperationButtons:(UIButton *)sender {
    
    NSLog(@"action Operation Buttons tag = %ld",(long)sender.tag);
    // self.indicatorLabel.text = [sender titleForState:UIControlStateNormal];//выводит на экран какие кнопки нажали (одинаковые функиции с методом self.indicatorLabel.text = [NSString stringWithFormat:@"%ld",(long)sender.tag])
    
    self.twoActionsIsEqual = self.twoActionsIsEqual +1;
    
    if (self.twoActionsIsEqual > 1) {
        
        
        [self equaling];
        
    }
    
    [self showEnum:sender];
    [self.tempNumberOne setString:@""];

    
}

- (IBAction)actionCleanButton:(UIButton *)sender {
    
    // NSLog(@"action Clean Button tag = %ld",sender.tag);
    // self.indicatorLabel.text = [sender titleForState:UIControlStateNormal];
    
    [self.tempNumberOne setString:@""];
    // self.operatorsEnum  = APOperatorsReset;
    self.firstNumber = 0;
    self.secondNumber = 0;
    self.indicatorLabel.text = @"0";
    self.twoActionsIsEqual = 0;

    
}

- (IBAction)actionEquallyButton:(UIButton *)sender {
    
    //  NSLog(@"action Equally Button tag = %ld",sender.tag);
    //  self.indicatorLabel.text = [sender titleForState:UIControlStateNormal];
    
    [self equaling];
    
    self.twoActionsIsEqual = 0;

}

- (IBAction)actionPlusMinus:(UIButton *)sender {
    
    
    
    if (self.equalingDone == 1) {
        
        self.secondNumber =0;
        [self.tempNumberOne setString:[NSString stringWithFormat:@"%.f", self.firstNumber]];
    }
    
    self.equalingDone = 0;
    
    if (self.secondNumber == 0) { //if first number or second number we are typing
        if (self.firstNumber < 0) {
            
            
            [self.tempNumberOne deleteCharactersInRange:NSMakeRange(0, 1)]; //delete on label value
            self.indicatorLabel.text = self.tempNumberOne;
            self.firstNumber = [[NSString stringWithFormat:@"%@",self.tempNumberOne]doubleValue]; // put NSString to number property
            
        } else if (self.firstNumber !=0) {
            
            [self.tempNumberOne insertString:@"-" atIndex:0];//add "-" on label value
            self.indicatorLabel.text = self.tempNumberOne;
            self.firstNumber = [[NSString stringWithFormat:@"%@",self.tempNumberOne]doubleValue]; // put NSString to number property
        }
    } else {
        if (self.secondNumber < 0) {
            
            [self.tempNumberOne deleteCharactersInRange:NSMakeRange(0, 1)];//delete on label value
            self.indicatorLabel.text = self.tempNumberOne;
            self.secondNumber = [[NSString stringWithFormat:@"%@",self.tempNumberOne]doubleValue]; // put NSString to number property
            
        } else if (self.firstNumber !=0) {
            
            [self.tempNumberOne insertString:@"-" atIndex:0];//add "-" on label value
            self.indicatorLabel.text = self.tempNumberOne;
            self.secondNumber = [[NSString stringWithFormat:@"%@",self.tempNumberOne]doubleValue]; // put NSString to number property
        }
    }

}

- (IBAction)actionPoint:(UIButton *)sender {
    
    if ([self.tempNumberOne length] == 0) {
        [self.tempNumberOne insertString:@"0." atIndex:[self.tempNumberOne length]];
    } else if (![self.tempNumberOne containsString:@"."]){
        [self.tempNumberOne insertString:@"." atIndex:[self.tempNumberOne length]];
    }
    
    self.indicatorLabel.text = self.tempNumberOne;

}



#pragma mark- Methods

- (void) equaling {
    
    
    
    NSLog(@"action = starts");
    [self.tempNumberOne setString:@""]; // dont forget to cancel label
    
    CGFloat result = 0;
    
    if (self.operatorsEnum == AGOperatorsDivide) {
        result = self.firstNumber / self.secondNumber;
    } else if (self.operatorsEnum == AGOperatorsMinus) {
        result = self.firstNumber - self.secondNumber;
    } else if (self.operatorsEnum == AGOperatorsMultiplication) {
        result = self.firstNumber * self.secondNumber;
    } else if (self.operatorsEnum == AGOperatorsPlus) {
        result = self.firstNumber + self.secondNumber;
    }
    
    [self.tempNumberOne setString:@""]; // dont forget to cancel label
    [self.tempNumberOne setString:[self floatToString:result]];
    
    self.firstNumber =result;
    
    self.indicatorLabel.text = self.tempNumberOne;
    //[self.tempNumberOne setString:@""]; // dont forget to cancel label again
    self.operatorsEnum = AGOperatorsReset;
    self.equalingDone = 1; // for plusMinus
    
    NSLog(@"equal = %.2f first number - %.2f, second - %.2f",result, self.firstNumber, self.secondNumber);
}

- (void) showEnum:(UIButton*) sender {
    
    switch (sender.tag) {
        case 16:
            self.operatorsEnum = AGOperatorsMinus;
            break;
            
        case 17:
            self.operatorsEnum = AGOperatorsPlus;
            break;
        case 15:
            self.operatorsEnum = AGOperatorsMultiplication;
            break;
        case 14:
            self.operatorsEnum = AGOperatorsDivide;
            break;
        case 11:
            self.operatorsEnum = AGOperatorsReset;
            break;
    }
}

//convert and elaborate CGFLoat to Nsstring
- (NSString*) floatToString:(CGFloat) floatNumber {
    
    NSInteger integerNumber = floatNumber;
    
    CGFloat difference = floatNumber - integerNumber;
    
    NSString *string;
    
    if (difference > 0) {
        
        if (integerNumber >999999999999999999) {
            
            string = @"big number";
            
        } else {
            
            string = [NSString stringWithFormat:@"%.8f",floatNumber];
        }
        
        
        if ([string length] > 10) {
            
            string = [string substringWithRange:NSMakeRange(0, 10)];
            
        }
        
        
        NSInteger indexOfRange = 10;
        
        
        while ([[string substringWithRange:NSMakeRange(indexOfRange-1, 1)] isEqualToString:@"0"]) {
            
            indexOfRange--;
        }
        string = [string substringWithRange:NSMakeRange(0, indexOfRange)];
        
        
        
    } else {
        
        if (integerNumber >999999999999999999) {
            string = @"big number";
        } else {
            string = [NSString stringWithFormat:@"%ld",integerNumber];
        }
        
    }
    
    return string;
    
}


@end
