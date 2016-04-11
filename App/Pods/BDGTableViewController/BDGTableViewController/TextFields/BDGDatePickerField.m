//
//  BDGDatePickerField.m
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BDGDatePickerField.h"

@interface BDGDatePickerField ()
{
    
}

@end

@implementation BDGDatePickerField

#pragma mark Init

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(!self) {
        return nil;
    }
    
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.backgroundColor = [UIColor whiteColor];
    self.inputView = self.datePicker;
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
    toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(dateFieldCancelled)];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dateFieldSelected)];
    [toolBar setItems:@[cancel, space, done]];
    [toolBar sizeToFit];
    self.inputAccessoryView = toolBar;
    
    return self;
}

-(void)setDate:(NSDate *)date
{
    _date = date;
    self.datePicker.date = date;
}

-(void)dateFieldCancelled
{
    [self resignFirstResponder];
    if(self.dateCancelled) {
        self.dateCancelled();
    }    
}

-(void)dateFieldSelected
{
    [self resignFirstResponder];
    self.date = self.datePicker.date;
    if(self.dateSelected) {
        self.dateSelected(self.datePicker.date);
    }
}

-(CGRect)caretRectForPosition:(UITextPosition *)position
{
    return CGRectZero;
}

@end













