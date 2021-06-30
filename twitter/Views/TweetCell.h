//
//  TweetCell.h
//  twitter
//
//  Created by Luke Arney on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;

@property (nonatomic, strong) NSDictionary *tweet;

@end

NS_ASSUME_NONNULL_END
