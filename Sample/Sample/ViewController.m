//
//  ViewController.m
//  Sample
//
//  Created by africa on 2019/11/04.
//  Copyright © 2019 africa. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController {
    long _count;
    NSOperationQueue *_queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _count = 3;
    
    //_queue = [[NSOperationQueue alloc] init];
    _queue = [NSOperationQueue mainQueue];

    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];

    // Execute
    [thread start];
    
    /*thread = [[NSThread alloc] initWithTarget:self selector:@selector(run2) object:nil];

    // Execute
    [thread start];*/
}

- (void)run {
    while (YES) {
        [_queue cancelAllOperations];
        
        //[_queue addOperationWithBlock:^{
            _count = 100;
            
            [self.tableView reloadData];
            
            //[self.tableView layoutIfNeeded];
            
            for (long i = 0; i < 99999999; i++) {
                i * (LONG_MAX + log(i));
            }
            
        @try {
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:50 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        } @catch (NSException *exception) {
            NSLog(@"%@", exception);
        } @finally {
        }
            //[self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:50 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        //}];

        NSLog(@"++++++++------------------------------------%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.5];
    }
}

- (void)run2 {
    while (YES) {
        [_queue cancelAllOperations];
        
        [_queue addOperationWithBlock:^{
            _count = 5;
            
            [self.tableView reloadData];
            
            //[self.tableView layoutIfNeeded];
            
            for (long i = 0; i < 99999999; i++) {
                i * (LONG_MAX + log(i));
            }
            
            [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            //[self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:50 inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
        }];

        NSLog(@"++++++++------------------------------------%@", [NSThread currentThread]);
        [NSThread sleepForTimeInterval:0.3];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _count;
}

/*- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    UIWebView *webView = [cell viewWithTag:1000];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.daum.net"]]];
    return cell;
}

/*- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}*/

- (IBAction)more:(id)sender {
    [_queue cancelAllOperations];

    [_queue addOperationWithBlock:^{
        self->_count = 3;
        [self.tableView reloadData];

        NSLog(@"+++++++++++++++++++++++++++++%@", [NSThread currentThread]);
    }];
}

@end
