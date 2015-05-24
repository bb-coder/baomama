//
//  RecipeCell.m
//  baomama
//
//  Created by bihongbo on 4/23/15.
//  Copyright (c) 2015 bb-coder. All rights reserved.
//

#import "RecipeCell.h"

@interface RecipeCell ()



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
    if (!self.textDescriptionLabel) {
        UILabel * label = [[UILabel alloc]init];
        label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:label];
        self.textDescriptionLabel = label;
    }
//    self.textDescriptionLabel.frame = CGRectMake(0, self.height - 20, self.width, 20);
    [self.textDescriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView * superView = self.contentView;
        make.leading.equalTo(superView.mas_leading);
        make.trailing.equalTo(superView.mas_trailing);
        make.height.mas_equalTo(20);
        make.bottom.equalTo(superView.mas_bottom);
    }];
    self.textDescriptionLabel.text = textDescription;
    
}

-(void)setImageUrlStr:(NSString *)imageUrlStr
{
    _imageUrlStr = imageUrlStr;
    if (!self.iconImageView) {
        UIImageView * imageView = [[UIImageView alloc]init];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:imageView];
        self.iconImageView = imageView;
    }
    self.iconImageView.frame = self.contentView.bounds;
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        UIView * superView = self.contentView;
        make.leading.equalTo(superView.mas_leading);
        make.trailing.equalTo(superView.mas_trailing);
        make.top.equalTo(superView.mas_top);
        make.bottom.equalTo(superView.mas_bottom);
    }];

//    BBLog(@"%@",NSStringFromCGRect(self.iconImageView.frame));
//    [self.iconImageView setImage:[UIImage imageNamed:@"place.jpg"]];
    
    
}

@end
