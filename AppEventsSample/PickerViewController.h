//
//  PickerViewController.h
//  platformTest
//
//  Created by Pu Guannan on 4/15/15.
//  Copyright (c) 2015 Pu Guannan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) IBOutlet UIPickerView *pickerView;
@property (nonatomic, strong) IBOutlet UILabel *eventNameLabel;
@property (nonatomic, strong) NSArray *content;
@property (nonatomic, strong) NSString *eventName;
-(void) setEventName:(NSString *)eventName setContent:(NSArray *)content;
-(NSDictionary*) getSelectedContent;
@end
