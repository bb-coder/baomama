//
//  RecipeCell.h
//  baomama
//
//  Created by bihongbo on 4/23/15.
//  Copyright (c) 2015 bb-coder. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipeCell : UICollectionViewCell

@property (copy, nonatomic) NSString * imageUrlStr;

@property (copy, nonatomic) NSString * textDescription;
@property (nonatomic,weak) UIImageView * iconImageView;


@end
