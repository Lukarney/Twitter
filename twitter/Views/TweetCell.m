//
//  TweetCell.m
//  twitter
//
//  Created by Luke Arney on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "Tweet.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refreshData {
    self.tweetText.text = self.tweet.text;
    self.retweetLabel.text = [NSString stringWithFormat:@"%d",self.tweet.retweetCount];
    self.favoriteLabel.text = [NSString stringWithFormat:@"%d",self.tweet.favoriteCount];
}

- (IBAction)didTapFavorite:(id)sender {
    // TODO: Update the local tweet model
    self.tweet.favorited = YES;
    self.tweet.favoriteCount += 1;
    // TODO: Update cell UI
    [self.favoriteButton setSelected:YES];
    
    
    // TODO: Send a POST request to the POST favorites/create endpoint
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error){
        if(error){
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            [self refreshData];
        }
    }];
    
}





@end
