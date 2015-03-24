//
//  WebpageViewController.m
//  MeetMeUp
//
//  Created by Justin Haar on 3/23/15.
//  Copyright (c) 2015 Justin Haar. All rights reserved.
//

#import "WebpageViewController.h"

@interface WebpageViewController () <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIButton *onBackButtonPressed;
@property (weak, nonatomic) IBOutlet UIButton *onForwardButtonPressed;


@end

@implementation WebpageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView.delegate = self;

    self.activityIndicator.hidesWhenStopped = YES;
    [self performLoadRequestWithString:self.webURL];
}


-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];

    self.onBackButtonPressed.enabled = self.webView.canGoBack;
    self.onForwardButtonPressed.enabled = self.webView.canGoForward;
}


-(void)performLoadRequestWithString:(NSString *)string
{
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}


- (IBAction)onBackButtonPressed:(UIButton *)sender
{
    [self.webView goBack];
}

- (IBAction)onForwardButtonPressed:(UIButton *)sender
{
    [self.webView goForward];
}


@end
