//
//  BDGSegmentedControlTableViewCell.m
//  MINGL
//
//  Created by Bob de Graaf on 26-06-15.
//  Copyright (c) 2015 Digitalisma. All rights reserved.
//

#import "BDGSegmentedControlTableViewCell.h"

@implementation BDGSegmentedControlTableViewCell

-(void)updateCell
{
    [self.segmentedControl removeAllSegments];
    for(int i = 0; i < self.row.selectorOptions.count; i++) {
        [self.segmentedControl insertSegmentWithTitle:self.row.selectorOptions[i] atIndex:i animated:FALSE];
    }
    
    self.segmentedControl.selectedSegmentIndex = self.row.selectedSegmentIndex;
}

-(IBAction)segmentedChanged
{
    [self.row updatedValue:@(self.segmentedControl.selectedSegmentIndex)];
}

@end