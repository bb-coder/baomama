//
//  RecipeCell.m
//  baomama
//
//  Created by bihongbo on 4/23/15.
//  Copyright (c) 2015 bb-coder. All rights reserved.
//

#import "RecipeCell.h"

@interface RecipeCell ()

@property (nonatomic,weak) UIImageView * iconImageView;

@property (nonatomic,weak) UILabel * textDescriptionLabel;

@end

@implementation RecipeCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setTextDescription:(NSString *)textDescription
{
    _textDescription = textDescription;
    if (!self.textDescription) {
        UILabel * label = [[UILabel alloc]init];
        label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        label.frame = CGRectMake(0, self.height - 20, self.width, 20);
        [self.contentView addSubview:label];
        self.textDescriptionLabel = label;
    }
    self.textDescriptionLabel.text = textDescription;
    
}

-(void)setImageUrlStr:(NSString *)imageUrlStr
{
    _imageUrlStr = imageUrlStr;
    if (!self.iconImageView) {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.frame = self.contentView.bounds;
        [self.contentView addSubview:imageView];
        self.iconImageView = imageView;
    }
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:_imageUrlStr] placeholderImage:[UIImage imageNamed:@"place"]];
    
}

@end
