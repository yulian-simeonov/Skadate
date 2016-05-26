//
//  newsPostAddCell.m
//  Skadate
//
//  Created by Heinz Vallonthaiel on 27/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "newsPostAddCell.h"

@implementation newsPostAddCell

#pragma mark initWithNibName

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        // Initialization code
                
        UILabel *testlbl=[[UILabel alloc]initWithFrame:CGRectMake(5, 5, 70, 30)];
        testlbl.text=@"newsPostAddCell";
        [self.contentView addSubview:testlbl];
        [testlbl release];

    }
    
    return self;
}

#pragma mark Custom Methods

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
