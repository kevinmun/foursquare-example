//
//  WebViewController.m
//  FourSquare
//
//  Created by Kevin Mun Kuang Tzer on 6/10/15.
//  Copyright (c) 2015 Kevin Mun Kuang Tzer. All rights reserved.
//

#import "WebViewController.h"
#import "AppPref.h"
#import "UIViewController+AppController.h"

@interface WebViewController ()

@end

@implementation WebViewController
NSString * const webPage = @"https://foursquare.com/oauth2/authenticate?client_id=%@&response_type=token&redirect_uri=%@";
NSString * const clientId = @"KLPQNXUA20I3R1E0EMOACYM3AEKFJSEWRTGPI2YNCHOEMXVE";
NSString * const redirect_uri = @"http://foursquare.com/developers/apps";
NSString * const landing_uri =@"https://foursquare.com/developers/apps#access_token=";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"WebViewController_title", nil);
    [self.retryButton addTarget:self action:@selector(loadUrl) forControlEvents:UIControlEventTouchUpInside];
    [self.retryButton setTitle:NSLocalizedString(@"WebViewController_retrybutton", nil) forState:UIControlStateNormal];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.webView setDelegate:self];
    //[AppPref clearCookie];
    [self loadUrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) loadUrl {
    self.retryButton.hidden = TRUE;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:webPage,clientId,redirect_uri]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}

-(void) dealloc {
    [self.webView setDelegate:nil];
}

#pragma WebView Delegate

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    self.webView.hidden =TRUE;
    self.retryButton.hidden = FALSE;
    [self.activityIndicator stopAnimating];
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    self.webView.hidden =TRUE;
    [self.activityIndicator startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView {
    self.webView.hidden =FALSE;
    [self.activityIndicator stopAnimating];
    if([webView.request.URL.absoluteString containsString:landing_uri]){
        NSString *token = [webView.request.URL.absoluteString stringByReplacingOccurrencesOfString:landing_uri withString:@""];
        [AppPref saveToken:token];
        [self.appController launchLoginSession];
    }
}

@end
