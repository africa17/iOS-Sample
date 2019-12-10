//
//  ViewController.m
//  Sample
//
//  Created by africa on 2019/11/04.
//  Copyright © 2019 africa. All rights reserved.
//

#import "ViewController.h"
#import "WebViewTableViewCell.h"

//#define STATIC_CELL

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController {
    long _count;
    NSMutableArray *_cells;
    NSOperationQueue *_queue;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _count = 7;
    
#ifdef STATIC_CELL
    _cells = [NSMutableArray array];
    for (long i = 0; i < _count; i++) {
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"WebViewTableViewCell" owner:self options:nil];
        WebViewTableViewCell *cell = subviewArray[0];
        [cell.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.daum.net"]]];
        cell.webView.scrollView.scrollEnabled = false;
        [_cells addObject:cell];
    }
#endif
    
    //_queue = [[NSOperationQueue alloc] init];
    _queue = [NSOperationQueue mainQueue];

    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(run) object:nil];

    // Execute
    //[thread start];
    
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
}*/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

/*- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
#ifdef STATIC_CELL
    cell = _cells[indexPath.row];
#else
    if (indexPath.row == 5) {
        NSArray *subviewArray = [[NSBundle mainBundle] loadNibNamed:@"WebViewTableViewCell" owner:self options:nil];
        cell = subviewArray[0];
        [((WebViewTableViewCell*)cell).webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.daum.net"]]];
        ((WebViewTableViewCell*)cell).webView.scrollView.scrollEnabled = false;
        cell = [[UITableViewCell alloc] init];
    } else {
        WebViewTableViewCell *webViewCell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
        cell = webViewCell;
        [webViewCell.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.daum.net"]]];
        webViewCell.webView.scrollView.scrollEnabled = false;
    }
#endif
    
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
    return;
    
    [_queue cancelAllOperations];

    [_queue addOperationWithBlock:^{
        self->_count += 5;
        [self.tableView reloadData];

        NSLog(@"+++++++++++++++++++++++++++++%@", [NSThread currentThread]);
    }];
}

@end
