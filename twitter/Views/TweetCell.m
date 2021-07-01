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
    if(self.tweet.favorited){
        // TODO: Update the local tweet model
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        // TODO: Update cell UI
        [self.favoriteButton setSelected:NO];
        
        
        // TODO: Send a POST request to the POST favorites/destroy endpoint
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error){
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
                
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                [self refreshData];
            }
        }];
        
    }
    else{
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
    
    
}
- (IBAction)didTapRetweet:(id)sender {
    if(self.tweet.retweeted){
        // TODO: Update the local tweet model
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        // TODO: Update cell UI
        [self.retweetButton setSelected:NO];
        
        
        // TODO: Send a POST request to the POST unretweet/destroy endpoint
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error){
            if(error){
                NSLog(@"Error unRetweeting tweet: %@", error.localizedDescription);
                
            }
            else{
                NSLog(@"Successfully unRetweeted the following Tweet: %@", tweet.text);
                [self refreshData];
            }
        }];
        
    }
    else{
        // TODO: Update the local tweet model
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        // TODO: Update cell UI
        [self.retweetButton setSelected:YES];
        
        
        // TODO: Send a POST request to the POST retweet/create endpoint
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error){
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
                
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                [self refreshData];
            }
        }];
        
    }
    
    
}





@end
