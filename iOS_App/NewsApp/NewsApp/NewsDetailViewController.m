//
//  NewsDetailViewController.m
//  NewsApp
//
//  Created by Mohamed Haseel on 12/11/16.
//  Copyright © 2016 Reflections. All rights reserved.
//

#define STORY_LINKS [UIColor colorWithRed:15.0/255.0 green:111.0/255.0 blue:255.0/255.0 alpha:1.0]

#import "NewsDetailViewController.h"
#import <SafariServices/SafariServices.h>
#import <AVFoundation/AVFoundation.h>

@interface NewsDetailViewController () {
    __weak IBOutlet UIScrollView *storyLinksView;
    AVSpeechSynthesizer *synthesizer;
}

@end

@implementation NewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadTags:@[@"Buy US Flag", @"How to emigrate to US", @"Trump", @"Connect with US gov FB page"]];
}

- (IBAction)close:(id)sender {
    if (synthesizer) {
        [synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)loadTags:(NSArray *)tags {
    int count = 0;
    int x = 0;
    for (NSString *tag in tags) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitleColor:STORY_LINKS forState:UIControlStateNormal];
        [button setTitle:tag forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:10.0];
        [button setTag:count++];
        
        if (x > 0) {
            x += 5;
        } else {
            x += 35;
        }
        
        button.frame = CGRectMake(x, 10, 100, 30);
        
        [NewsDetailViewController sizeButtonToText:button availableSize:CGSizeMake(1000, 30) padding:UIEdgeInsetsMake(10, 10, 10, 10)];
        
        button.layer.cornerRadius = button.frame.size.height/2;
        button.layer.borderWidth = 1.0;
        button.layer.borderColor = STORY_LINKS.CGColor;
        button.showsTouchWhenHighlighted = YES;
        
        [button addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [storyLinksView addSubview:button];
        
        x += button.frame.size.width;
    }
    
    storyLinksView.contentSize = CGSizeMake(x + 100, 30);
}

- (IBAction)handleButton:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            [self openUrl:@"https://www.amazon.com/Flags-Unlimited-U-S-Nylon-Flag/dp/B01I1WIIS4"];
            break;
            
        case 1:
            [self openUrl:@"http://casa-us.org/immigration-assitance/?gclid=CPi6hbP9otACFdGOaAodDXMOYA"];
            break;
            
        case 2:
            [self openTwitterProfile:@"realDonaldTrump"];
            break;
            
        case 3:
            [self openFBProfile:@"DonaldTrump"];
            break;
            
        default:
            break;
    }
}

- (void)openUrl:(NSString *)url {
    SFSafariViewController *safariController = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url] entersReaderIfAvailable:YES];
    [self presentViewController:safariController animated:YES completion:nil];
}

- (void)openTwitterProfile:(NSString *)profileName {
    if(![[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"twitter://user?screen_name=%@", profileName]]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://twitter.com/%@", profileName]]];
    }
}

- (void)openFBProfile:(NSString *)page {
    NSURL *facebookURL = [NSURL URLWithString:[NSString stringWithFormat:@"fb://profile/%@", page]];
    if ([[UIApplication sharedApplication] canOpenURL:facebookURL]) {
        [[UIApplication sharedApplication] openURL:facebookURL];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://facebook.com/%@", page]]];
    }
}

+ (void)sizeButtonToText:(UIButton *)button availableSize:(CGSize)availableSize padding:(UIEdgeInsets)padding {
    
    CGRect boundsForText = button.frame;
    
    // Measures string
    CGSize stringSize = [button.titleLabel.text sizeWithFont:button.titleLabel.font];
    stringSize.width = MIN(stringSize.width + padding.left + padding.right, availableSize.width);
    
    // Center's location of button
    boundsForText.size.width = stringSize.width;
    [button setFrame:boundsForText];
}

- (IBAction)readAloud:(id)sender {
    if (!synthesizer) {
        synthesizer = [[AVSpeechSynthesizer alloc] init];
    }
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"Mr Trump has called the president the worst in history, while Mr Obama said the Republican was unfit for the office. The New York hotel developer, now president-elect, persistently questioned the birth legitimacy of the Hawaii-born president, and was publicly mocked for it by Mr Obama. The two men spoke for more than an hour in the Oval Office on Thursday and when they emerged, they tried to put their bitter past behind them, speaking warmly about unity and a peaceful transition. But the cameras told another story."];
    [utterance setRate:0.5];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"ml_IN"];
    [synthesizer speakUtterance:utterance];
}

@end
