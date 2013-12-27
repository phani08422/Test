//
//  MTViewController.m
//  RssFeeds
//
//  Created by iappease on 11/15/13.
//  Copyright (c) 2013 iAPPease. All rights reserved.
//

#import "MTViewController.h"

@interface MTViewController ()
{
    NSMutableString *foundCharex;
    NSMutableArray *infoArray;
    NSMutableDictionary *rssDict;
}

@end

@implementation MTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UITextField *tfText = [[UITextField alloc] initWithFrame:CGRectMake(65, 200, 200, 30)];
    tfText.backgroundColor = [UIColor colorWithRed:0.2 green:0.9 blue:0.5 alpha:0.3];
    tfText.textAlignment = NSTextAlignmentCenter;
    tfText.layer.borderWidth = 1;
    tfText.layer.borderColor = [[UIColor redColor] CGColor];
    // Border Style None
    [tfText setBorderStyle:UITextBorderStyleLine];
    [self.view addSubview:tfText];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://newsrss.bbc.co.uk/rss/newsonline_world_edition/americas/rss.xml"]];
    infoArray = [[NSMutableArray alloc] init];
    parser.delegate = self;
//    if ([parser parse]) {
//        
//        NSLog(@"sucess");
//    }
//    else
//    {
//        NSLog(@"Fail");
//
//    }
//    
    NSLog(@"rss count %d",[infoArray count]);
    
    [self connectServerWithURL:[NSURL URLWithString:@"http://54.200.20.52:8080/recruiter/rest/initiative?token=IBobGmhUXl1ZWlNGekwUQHZw&uname=john&projID=6"] fetchDataForInputs:[NSString stringWithFormat:@"token=IBobGmhUXl1ZVV1Cf00TQ3R1&uname=john&projID=5"]];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NSXMLParser delegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    NSLog( @"Start element name %@",elementName);
    if ([elementName isEqualToString:@"item"]) {
        rssDict = [[NSMutableDictionary alloc] init];
    }
    foundCharex = [[NSMutableString alloc] init];

}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"title"]||[elementName isEqualToString:@"link"]||[elementName isEqualToString:@"category"]||[elementName isEqualToString:@"pubDate"]) {
        [rssDict setObject:foundCharex forKey:elementName];
    }
    if ([elementName isEqualToString:@"item"]) {
        [infoArray addObject:rssDict];
        rssDict = nil;
    }
    
    NSLog( @"found Character %@",foundCharex);
    
    NSLog( @"End element name %@",elementName);
    foundCharex = nil;
    
    
    


}
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    

    [foundCharex appendString:string];
}


- (id)connectServerWithURL:(NSURL *)url
        fetchDataForInputs:(NSString *)args
{
   // NSData *postData = [NSData dataWithBytes:[args UTF8String] length:[args length]];

    NSLog(@"inputs %@",args);
    NSError *error = nil;
    NSURLResponse *response = nil;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10.0];
    
        [request setHTTPMethod:@"GET"];
        
       // [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        
    
        
   // [request setHTTPBody:postData];
  //  [request setValue:[NSString stringWithFormat:@"%d", [postData length]] forHTTPHeaderField:@"Content-Length"];
    
   NSData *data= [NSURLConnection sendSynchronousRequest:request
                                returningResponse:&response
                                            error:&error
           
           ];
    if (error) {
        
        NSLog(@"error %@",error.localizedDescription);
        
    }
    else
    {
        NSError *error1;
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error1];
        if (error1) {
            NSLog(@"error %@",error1.localizedDescription);

        }
        else
        {
            NSLog(@"output %@",dict);

        }
    }
    return data;
}


/**
 An error occurred while parsing the earthquake data: post the error as an NSNotification to our app delegate.
 */
@end
