//
//  DetailsViewController.m
//  twitter
//
//  Created by Luke Arney on 7/1/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "DateTools.h"
#import "APIManager.h"
#import "Tweet.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *tweetText;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *retweetsNumber;
@property (weak, nonatomic) IBOutlet UILabel *retweetsUnit;
@property (weak, nonatomic) IBOutlet UILabel *likesNumber;
@property (weak, nonatomic) IBOutlet UILabel *likesUnit;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //set author, username, & text
    self.author.text = self.tweet.user.name;
    self.username.text = self.tweet.user.screenName;
    self.tweetText.text = self.tweet.text;
    
    self.date.text = self.tweet.createdAtString;
    self.time.text = self.tweet.createdAtDate.timeAgoSinceNow;
    
    
    //set retweets and likes
    self.retweetsNumber.text = [NSString stringWithFormat:@"%d",self.tweet.retweetCount];
    if([self.retweetsNumber.text isEqualToString:@"1"]){
        self.retweetsUnit.text = @"Retweet";
    }
    else{
        self.retweetsUnit.text = @"Retweets";
    }
    
    self.likesNumber.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    if([self.likesNumber.text isEqualToString:@"1"]){
        self.likesUnit.text = @"Retweet";
    }
    else{
        self.likesUnit.text = @"Retweets";
    }
    
    //set buttons
    
    //set image
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    
    UIImage *picture = [UIImage imageWithData:urlData];
    self.profilePicture.image = nil;
    [self.profilePicture setImage:picture];
}
-(void)refreshData {
    self.tweetText.text = self.tweet.text;
    self.retweetsNumber.text = [NSString stringWithFormat:@"%d",self.tweet.retweetCount];
    self.likesNumber.text = [NSString stringWithFormat:@"%d",self.tweet.favoriteCount];
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
        [[APIManager shared] unRetweet:self.tweet completion:^(Tweet *tweet, NSError *error){
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
