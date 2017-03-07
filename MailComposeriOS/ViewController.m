//
//  ViewController.m
//  MailComposeriOS
//
//  Created by Prakash Maharjan on 8/26/16.
//  Copyright © 2016 Prakash Maharjan. All rights reserved.
//

#import "ViewController.h"
#import <MessageUI/MessageUI.h> // importing messageUI framewok


@interface ViewController ()<MFMailComposeViewControllerDelegate,MFMessageComposeViewControllerDelegate> // set mail amd message composer delegate

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//send email action
- (IBAction)sendEmail:(id)sender {
    
    //check if device can send email
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailComposer = [[MFMailComposeViewController alloc] init];
        mailComposer.mailComposeDelegate = self;
        
        [mailComposer setToRecipients:@[@"prakash@gmail.com"]];
        
        [mailComposer setTitle:@"Test"];
        [mailComposer setSubject:@"This is test subject"];
        [mailComposer setMessageBody:@"hi. this is test message" isHTML:NO];
        
        [self presentViewController:mailComposer animated:YES completion:^{}];
        
    }
    else
    {
        //show alert if device cannot send email or email is not set up
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                        message:@"Sorry your device doesn't seem to support the mail composer sheet."
                                                       delegate:self
                                              cancelButtonTitle:@"Dissmiss"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    
    
    
}

//send text sms action
- (IBAction)sendSMS:(id)sender {
    
    //check if device can send message/sms
    if ([MFMessageComposeViewController canSendText])
    {
        MFMessageComposeViewController *messageComposer = [[MFMessageComposeViewController alloc] init];
        messageComposer.messageComposeDelegate = self;
        
        NSArray *smsRecipents = @[@"9841414141", @"980343434", @"34565443"];
        NSString *smsMessage = [NSString stringWithFormat:@"Hey guys lets meet this saturday at the old coffee shop"];
        
        MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
        
        [messageController setRecipients:smsRecipents];
        [messageController setBody:smsMessage];
        
        [self presentViewController:messageComposer animated:YES completion:^{}];
        
    }
    else
    {
        //show alert if device cannot send text message
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!"
                                                        message:@"Sorry your device doesn't seem to support the message composer."
                                                       delegate:self
                                              cancelButtonTitle:@"Dissmiss"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    
    
    
}

#pragma mark - Mail Composer Delegates
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
        {
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            UIAlertView *mailSendingFailedAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send Email!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [mailSendingFailedAlert show];
            break;
        }
            
        default:
            break;
    }
    
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - Message Composer Delegates
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            NSLog(@"Message sending canceled");
            break;
            
        case MessageComposeResultFailed:
        {
            NSLog(@"Message Sending Failed");
            UIAlertView *messageSendingFailedAlert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [messageSendingFailedAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            NSLog(@"Message Sent");
            break;
            
        default:
            break;
    }
    
    // Close the Message Interface
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
