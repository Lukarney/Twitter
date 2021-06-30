//
//  ComposeViewController.m
//  twitter
//
//  Created by Luke Arney on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"



@interface ComposeViewController ()

@end



@implementation ComposeViewController
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];

}
- (IBAction)tweet:(id)sender {
    [[APIManager shared] postStatusWithText:self.tweetContent.text completion:^(Tweet *tweet, NSError *error) {
        if(error){
            
            NSLog(@"Error while creating tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            [self dismissViewControllerAnimated:true completion:nil];
            NSLog(@"Tweet sent successfully");
        
           
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
