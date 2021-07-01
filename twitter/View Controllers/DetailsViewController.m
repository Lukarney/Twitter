//
//  DetailsViewController.m
//  twitter
//
//  Created by Luke Arney on 7/1/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "DateTools.h"

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
