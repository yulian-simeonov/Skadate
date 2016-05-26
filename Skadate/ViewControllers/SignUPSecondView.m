//
//  SignUPSecondView.m
//  Chk
//

//  Created by SODTechnologies on 29/08/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import <CommonCrypto/CommonDigest.h>
#import "SignUPSecondView.h"
#import "SkadateAppDelegate.h"
#import "HomeView.h"
#import "SignUPFirstView.h"
#import "SkadateAppDelegate.h"
#import "TermsOfUse.h"
#import "JSON.h"


#define tableRowHeight 30.0
#define tableViewHeight 180.0

@implementation SignUPSecondView
@synthesize segmentControlCountry;
@synthesize segmentControlState;
@synthesize segmentControlCity;
@synthesize uiCountryPickerView;
@synthesize uiStatePickerView;
@synthesize uiCityPickerView;
@synthesize countryPicker;
@synthesize statePicker;
@synthesize cityPicker;
@synthesize txtRegion;
@synthesize txtCountry;
@synthesize countrynamesArray;
@synthesize selectedCountryLbl;
@synthesize selectedCityLbl;
@synthesize selectedRegionLbl;
@synthesize cityNamesArray;
@synthesize countryCodeArray;
@synthesize countryId;
@synthesize countryName;
@synthesize lblCity;
@synthesize lblRegion;
@synthesize lblCountry;
@synthesize zipNamesArray,zipCodeArray;
@synthesize txtCity,strPswStore,strSelectedZipStore,strIpStorage;
@synthesize signUpView,touView;
@synthesize homeScreenView;
@synthesize tempScrollView;
@synthesize txtEmail;
@synthesize txtConfirmEmail;
@synthesize minAgePicker;
@synthesize maxAgePicker;
@synthesize monthPickerView;
@synthesize dayPickerView;
@synthesize yearPickerView;
@synthesize lablMonth;
@synthesize lablDate;
@synthesize lablYear;
@synthesize uiPickerDayView,uiPickerMonthView;
@synthesize yearLabel;
@synthesize monthLabel;
@synthesize dayLabel;
@synthesize minAgeLabel;
@synthesize maxAgeLabel;
@synthesize uiPickerView,uiMinAgePickerView,uiMaxAgePickerView;
@synthesize segmentCtrlMonth,segmentCtrlMinAge,segmentCtrlMaxAge;
@synthesize segmentCtrlDate,segmentCtrlYear;
@synthesize minAgeArray;
@synthesize maxAgeArray;
@synthesize username, password, encryptedPass,month;
@synthesize btnTOU;
@synthesize btnMinAge,btnMaxAge;
//@synthesize siteSALT;
@synthesize domain;
@synthesize imgBGIam;
@synthesize imgBGLookingFor;
@synthesize imgBGEmail;
@synthesize imgBGDOB;
@synthesize imgBGMatchAge;
@synthesize imgBGCountry;
@synthesize imgBGCheckboxes;
@synthesize btnback;
@synthesize lblFrom;
@synthesize lblTo;
@synthesize lblYearsOld;
@synthesize lblAdult;
@synthesize lblAgreeTerms;
@synthesize btnTerms;
@synthesize btnIamAdult;
@synthesize btnSignUp;
@synthesize lblIam,lblMatchAge,lblLookingFor,lblDateOfBirth,strCityCodeStore;

@synthesize isSignUP;
@synthesize NewXval;


#pragma mark Memory Management

- (void)dealloc
{    

    [lblIam release];
    [lblLookingFor release];
    [lblDateOfBirth release];
    [lblCountry release];
    [lblMatchAge release];
    [btnback release];
    [lablMonth release];
    [lablDate release];
    [lablYear release];
    [txtCountry release];
    [txtRegion release];
    [uiCountryPickerView release];
    [uiStatePickerView release];
    [uiCityPickerView release];
    [countryPicker release];
    [statePicker release];
    [cityPicker release];
    [segmentControlCountry release];
    [segmentControlCity release];
    [segmentControlState release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark initWithNibName

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) 
    {
        // Custom initialization
    }
    return self;
    
}

#pragma mark Custom Methods

-(void) fillCountry 
{    
    countrynamesArray = [[NSMutableArray alloc] init];
    countryCodeArray= [[NSMutableArray alloc] init];
    
	NSString *Path = [[NSBundle mainBundle]bundlePath];
	NSString *DataPath = [Path stringByAppendingPathComponent:@"country.xml"];
	NSData *Data = [[NSData alloc]initWithContentsOfFile:DataPath];
    
    rssParser = [[NSXMLParser alloc] initWithData:Data];
	[Data release];
    [rssParser setDelegate:self];
	
    [rssParser setShouldProcessNamespaces:NO];
    [rssParser setShouldReportNamespacePrefixes:NO];
    [rssParser setShouldResolveExternalEntities:NO];
	
    [rssParser parse];
    
}

- (NSString *)stringToSha1:(NSString *)str
{    
    const char *s = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *keyData = [NSData dataWithBytes:s length:strlen(s)];
    
    // This is the destination
    uint8_t digest[CC_SHA1_DIGEST_LENGTH] = {0};
    // This one function does an unkeyed SHA1 hash of your hash data
    CC_SHA1(keyData.bytes, keyData.length, digest);
    
    // Now convert to NSData structure to make it usable again
    NSData *out = [NSData dataWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];
    // description converts to hex but puts <> around it and spaces every 4 bytes
    NSString *hash = [out description];
    hash = [hash stringByReplacingOccurrencesOfString:@" " withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@"<" withString:@""];
    hash = [hash stringByReplacingOccurrencesOfString:@">" withString:@""];
    
    return hash;
}

-(void)HiddenAllPickers
{      
  //  countryPicker.hidden=YES;
  //  statePicker.hidden=YES;
  //  cityPicker.hidden=YES;
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
     
    monthPickerView.hidden = YES;
    dayPickerView.hidden = YES;
    yearPickerView.hidden = YES;
   
    
    uiCountryPickerView.hidden = YES;
    uiStatePickerView.hidden = YES;
    uiCityPickerView.hidden = YES;
    
    uiMaxAgePickerView.hidden = YES;
    uiMinAgePickerView.hidden = YES;
   
    uiPickerView.hidden = YES;
    uiPickerDayView.hidden = YES;
    uiPickerMonthView.hidden = YES;
     
          
    btnMinAge.hidden = NO;
    btnMaxAge.hidden =  NO;
    minAgeLabel.hidden = NO;
    maxAgeLabel.hidden = NO;
    lblCountry.hidden=NO;
    lblMatchAge.hidden=NO;
   
    tempScrollView.scrollEnabled=YES;
    lablDate.enabled=YES;
    lablMonth.enabled=YES;
    lablYear.enabled=YES;
    txtEmail.enabled=YES;
    txtCity.enabled=YES;
    txtRegion.enabled=YES;
    txtCountry.enabled=YES;
    txtConfirmEmail.enabled=YES;
    btnMaxAge.enabled=YES;
    btnMinAge.enabled=YES;
}


-(void)orientationForIpad
{    
    yearLabel.font = [UIFont fontWithName:@"Ubuntu-Bold" size:12];
    monthLabel.font = [UIFont fontWithName:@"Ubuntu-Bold" size:12];
    dayLabel.font = [UIFont fontWithName:@"Ubuntu-Bold" size:12];
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) 
    {     
        
        [self  HiddenAllPickers];
        
                
        if (self.interfaceOrientation==UIInterfaceOrientationPortrait || self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) 
        {          
                      
            [lblIam setFrame:CGRectMake(155, 28, 150, 20)];
            [lblLookingFor setFrame:CGRectMake(155, 158, 200, 20)];
            [lblDateOfBirth setFrame:CGRectMake(155, 425, 200, 20)];
            [lblMatchAge setFrame:CGRectMake(155, 550, 250, 25)];                                 
             
            [imgBGIam setFrame:(CGRectMake(150, 20, 450, 110))];
            [btnMale setFrame:CGRectMake(200, 60, 60, 60)];
            [btnFemale setFrame:CGRectMake(300, 60, 60, 60)];
            [btnCouple setFrame:CGRectMake(400, 60, 60, 60)];
            [btnGroup setFrame:CGRectMake(500, 60, 60, 60)];
             
            [imgBGLookingFor setFrame:(CGRectMake(150, 150, 450, 110))];
            [btnLFMale setFrame:CGRectMake(200, 190, 60, 60)];
            [btnLFFemale setFrame:CGRectMake(300, 190, 60, 60)];
            [btnLFCouple setFrame:CGRectMake(400, 190, 60, 60)];
            [btnLFGroup setFrame:CGRectMake(500, 190, 60, 60)];
             
            [imgBGEmail setFrame:(CGRectMake(150, 280, 450, 110))];
            [yourvalidlab setFrame:CGRectMake(200, 300, 150, 25)];
            [conformmaillab setFrame:CGRectMake(200, 350, 150, 25)];
            [txtEmail setFrame:CGRectMake(320, 300, 150, 25)];
            [txtConfirmEmail setFrame:CGRectMake(320, 350, 150, 25)];
           
            [imgBGDOB setFrame:(CGRectMake(150, 410, 450, 110))];
            [lablMonth setFrame:CGRectMake(230, 470, 80, 25)];
            [monthLabel setFrame:CGRectMake(225, 470, 90, 25)];
            [lablDate setFrame:CGRectMake(335, 470, 60, 25)];
            [dayLabel setFrame:CGRectMake(330, 470, 70, 25)];
            [lablYear setFrame:CGRectMake(420, 470, 60, 25)];
            [yearLabel setFrame:CGRectMake(415, 470, 70, 25)];
                       
            [imgBGMatchAge setFrame:(CGRectMake(150, 540, 450, 110))];
            [lblFrom setFrame:CGRectMake(200, 600, 30, 30)];
            [minAgeLabel setFrame:CGRectMake(260, 600, 30, 30)];
            [btnMinAge setFrame:CGRectMake(250, 600, 60, 25)];
             
            [lblTo setFrame:CGRectMake(320, 600, 100, 30)];
            [maxAgeLabel setFrame:CGRectMake(360, 600, 30, 30)];
            [btnMaxAge setFrame:CGRectMake(350, 600, 60, 25)];
            
            [lblYearsOld setFrame:CGRectMake(430, 600, 100, 30)];
            
            [imgBGCheckboxes setFrame:(CGRectMake(150, 670, 450, 90))];
            [btnIamAdult setFrame:CGRectMake(200, 680, 30, 30)];
            [lblAdult setFrame:CGRectMake(240, 680, 180, 30)];
            
            [btnTOU setFrame:CGRectMake(200, 720, 30, 30)];
            [lblAgreeTerms setFrame:CGRectMake(240, 720, 100, 30)];
            
            [btnTerms setFrame:CGRectMake(350, 725, 80, 20)];
            [imgBGCountry setFrame:(CGRectMake(150, 770, 450, 110))];
   
            [btnSignUp setFrame:(CGRectMake(200, 900, 350, 50))];
                                        
            txtCountry.frame=CGRectMake(175, 825, 400, 29);
            txtRegion.frame=CGRectMake(175, 875, 400, 29);
            txtCity.frame=CGRectMake(175, 925, 400, 29);
             
            [selectedCountryLbl setFrame:(CGRectMake(300, 825, 220, 29))];
            [selectedRegionLbl setFrame:(CGRectMake(300, 875, 220, 29))];
            [selectedCityLbl setFrame:(CGRectMake(300, 925, 220, 29))];
            
            [lblCountry setFrame:CGRectMake(190, 825, 100, 29)];
            [lblRegion setFrame:(CGRectMake(190, 875, 100, 29))];
            lblCity.frame=CGRectMake(190, 925, 100, 29);
             
            [uiCountryPickerView setFrame:CGRectMake(0, 860, 768, 270)];
            [uiStatePickerView setFrame:CGRectMake(0, 910, 768, 270)];
            [uiCityPickerView setFrame:CGRectMake(0, 960, 768, 270)];
            
            if(sta==YES)
            {
                
                imgBGCountry.image=[UIImage imageNamed:@"location_field2.PNG"];
                [imgBGCountry setFrame:(CGRectMake(150, 770, 450, 165))];
                [btnSignUp setFrame:(CGRectMake(200, 960, 350, 50))];
                tempScrollView.contentSize=CGSizeMake(320,1130);
                 
            }
            else 
            {
                if(cit==YES)
                { 
                    imgBGCountry.image=[UIImage imageNamed:@"location_field3.png"];
                    [imgBGCountry setFrame:(CGRectMake(150, 770, 450, 210))];
                    [btnSignUp setFrame:(CGRectMake(200, 1010, 350, 50))];
                    tempScrollView.contentSize=CGSizeMake(320,1190);
                    
                }
                
            }
        }
        else if (self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation==UIInterfaceOrientationLandscapeRight)
        {                        
                                  
            [lblIam setFrame:CGRectMake(285, 28, 150, 20)];
            [lblLookingFor setFrame:CGRectMake(285, 158, 200, 20)];
            [lblDateOfBirth setFrame:CGRectMake(285, 425, 200, 20)];
            [lblMatchAge setFrame:CGRectMake(285, 550, 250, 25)];                        
            
            [imgBGIam setFrame:(CGRectMake(280, 20, 450, 110))];
            [btnMale setFrame:CGRectMake(330, 60, 60, 60)];
            [btnFemale setFrame:CGRectMake(430, 60, 60, 60)];
            [btnCouple setFrame:CGRectMake(530, 60, 60, 60)];
            [btnGroup setFrame:CGRectMake(630, 60, 60, 60)];
            
            [imgBGLookingFor setFrame:(CGRectMake(280, 150, 450, 110))];
            [btnLFMale setFrame:CGRectMake(330, 190, 60, 60)];
            [btnLFFemale setFrame:CGRectMake(430, 190, 60, 60)];
            [btnLFCouple setFrame:CGRectMake(530, 190, 60, 60)];
            [btnLFGroup setFrame:CGRectMake(630, 190, 60, 60)];
            
            [imgBGEmail setFrame:(CGRectMake(280, 280, 450, 110))];
            [yourvalidlab setFrame:CGRectMake(330, 300, 150, 25)];
            [conformmaillab setFrame:CGRectMake(330, 350, 150, 25)];
            [txtEmail setFrame:CGRectMake(450, 300, 150, 25)];
            [txtConfirmEmail setFrame:CGRectMake(450, 350, 150, 25)];
            
            [imgBGDOB setFrame:(CGRectMake(280, 410, 450, 110))];
            [lablMonth setFrame:CGRectMake(360, 470, 80, 25)];
            [monthLabel setFrame:CGRectMake(355, 470, 90, 25)];
            [lablDate setFrame:CGRectMake(465, 470, 60, 25)];
            [dayLabel setFrame:CGRectMake(460, 470, 70, 25)];
            [lablYear setFrame:CGRectMake(550, 470, 60, 25)];
            [yearLabel setFrame:CGRectMake(545, 470, 70, 25)];
            
            [imgBGMatchAge setFrame:(CGRectMake(280, 540, 450, 110))];
            [lblFrom setFrame:CGRectMake(330, 600, 30, 30)];
            [minAgeLabel setFrame:CGRectMake(390, 600, 30, 25)];
            [btnMinAge setFrame:CGRectMake(380, 600, 60, 25)];
            
            [lblTo setFrame:CGRectMake(450, 600, 100, 30)];
            [maxAgeLabel setFrame:CGRectMake(490, 600, 30, 25)];
            [btnMaxAge setFrame:CGRectMake(480, 600, 60, 25)];
            
            [lblYearsOld setFrame:CGRectMake(560, 600, 100, 30)];
            
            [imgBGCheckboxes setFrame:(CGRectMake(280, 670, 450, 90))];
            [btnIamAdult setFrame:CGRectMake(330, 680, 30, 30)];
            [lblAdult setFrame:CGRectMake(370, 680, 180, 30)];
            
            [btnTOU setFrame:CGRectMake(330, 720, 30, 30)];
            [lblAgreeTerms setFrame:CGRectMake(370, 720, 100, 30)];
            [btnTerms setFrame:CGRectMake(470, 725, 80, 20)];
            
            [imgBGCountry setFrame:(CGRectMake(280, 770, 450, 110))];
                                 
            [btnSignUp setFrame:(CGRectMake(330, 900, 350, 50))];
                                  
            txtCountry.frame=CGRectMake(303, 825, 400, 29);
            txtRegion.frame=CGRectMake(303, 875, 400, 29);
            txtCity.frame=CGRectMake(303, 925, 400, 29);
                        
            [selectedCountryLbl setFrame:(CGRectMake(408, 825, 220, 29))];
            [selectedRegionLbl setFrame:(CGRectMake(408, 875, 220, 29))];
            [selectedCityLbl setFrame:(CGRectMake(408, 925, 220, 29))];
            
            [lblCountry setFrame:CGRectMake(317, 825, 100, 29)];
            [lblRegion setFrame:(CGRectMake(317, 875, 100, 29))];
            lblCity.frame=CGRectMake(317, 925, 100, 29);
            
            [uiCountryPickerView setFrame:CGRectMake(0, 860, 1024, 270)];
            [uiStatePickerView setFrame:CGRectMake(0, 910, 1024, 270)];
            [uiCityPickerView setFrame:CGRectMake(0, 960, 1024, 270)];
            
            if(sta==YES)
            {
                imgBGCountry.image=[UIImage imageNamed:@"location_field2.PNG"];
                
                [imgBGCountry setFrame:(CGRectMake(280, 770, 450, 165))];
                [btnSignUp setFrame:(CGRectMake(330, 960, 350, 50))];
            }
            else 
            {
                if(cit==YES)
                {
                    imgBGCountry.image=[UIImage imageNamed:@"location_field3.png"];
                    [imgBGCountry setFrame:(CGRectMake(280, 770, 450, 210))];
                    [btnSignUp setFrame:(CGRectMake(330, 1010, 350, 50))];
                }
                
            }
            
        } 
        
    }
    else
    {
        if(sta==YES)
        {            
            [imgBGCountry setFrame:(CGRectMake(5, 688, 308, 140))];
            imgBGCountry.image=[UIImage imageNamed:@"location_field2.PNG"];
            [btnSignUp setFrame:(CGRectMake(30, 850, 260, 45))];
        }
        else 
        {
            if(cit==YES)
            {                
                [imgBGCountry setFrame:(CGRectMake(5, 688, 308, 183))];
                imgBGCountry.image=[UIImage imageNamed:@"location_field3.png"];
                [btnSignUp setFrame:(CGRectMake(30, 885, 260, 45))];
            }
            else
            {
                [imgBGCountry setFrame:(CGRectMake(5, 688, 308, 100))];
                imgBGCountry.image=[UIImage imageNamed:@"location_field1.png"];
                [btnSignUp setFrame:(CGRectMake(30, 800, 260, 45))];
            }
            
        }
        
        if ((selectedRegionLbl.hidden==YES) && (selectedCityLbl.hidden==YES) )
        {
            if(isStateCountZero)
            {
                tempScrollView.contentSize=CGSizeMake(320,912);
            }
            else
            {
                tempScrollView.contentSize=CGSizeMake(320,910);
            }
        }
        else if ((selectedRegionLbl.hidden==NO) && (selectedCityLbl.hidden==YES) )
        {

            if(isCityCountZero)
            {     
                tempScrollView.contentSize=CGSizeMake(320,966);
            }
            else
            {
                tempScrollView.contentSize=CGSizeMake(320,968);
            }

        }
        
        else if ((selectedRegionLbl.hidden==NO) && (selectedCityLbl.hidden==NO) )
        {
            tempScrollView.contentSize=CGSizeMake(320,1000);
            
        }
        
    }
    
}


#pragma mark View lifecycle

- (void)viewDidAppear:(BOOL)animated
{    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	BOOL touCheck = [prefs boolForKey:@"touAgreed"];
    
    if (YES == touCheck)
    {
        [btnTOU setImage:imgChecked forState:normal];
        termsOfUSe = YES;
    }
    else
    {
        [btnTOU setImage:imgUnChecked forState:normal];
        termsOfUSe = NO;
    }
    
}

- (void)viewDidLoad
{    
    [super viewDidLoad]; 
    uiCountryPickerView.hidden=YES;
    uiStatePickerView.hidden=YES;
    uiCityPickerView.hidden=YES;
    txtRegion.hidden=YES;
    txtCity.hidden=YES;
    sta=cit=NO;
        
    [lablMonth setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    
    [lablDate setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    
    [lablYear setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    
    [btnMinAge setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    
    [btnMaxAge setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    [txtCity setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    [txtCountry setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
    [txtRegion setBackgroundColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redVal/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenVal/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueVal/255.0 alpha:1.0]];
       
    boolUs=NO;
     
    NSString *urlReq=[NSString stringWithFormat:@"http://api.externalip.net/ip/"]; 
    
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:urlReq, @"url", @"forGettingIp", @"meta", nil];
    [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:params waitUntilDone:NO];
      
    selectedCountryLbl.userInteractionEnabled=NO;
    selectedRegionLbl.userInteractionEnabled=NO;
    selectedCityLbl.userInteractionEnabled=NO;
    selectedCityLbl.hidden=YES;
 
    selectedRegionLbl.hidden=YES;
    lblCity.hidden=YES;
    txtCity.hidden=YES;
    
    selectedCityLbl.text=@"Please Select";
    selectedCountryLbl.text=@"Please Select";
    selectedRegionLbl.text=@"Please Select";
    
    
    /* if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
     {
     [self orientationForIpad];
     }*/
    
    [self orientationForIpad];
        
    lblRegion.hidden=YES;
    
    selectedCountryLbl.hidden=NO;
    
    [self performSelector:@selector(fillCountry) withObject:nil];
    
    selectedCountryLbl.text=@"Please Select";
    selectedCountryLbl.textColor=[UIColor darkGrayColor];
    selectedRegionLbl.textColor=[UIColor darkGrayColor];
    selectedCityLbl.textColor=[UIColor darkGrayColor];
    txtCity.textColor=[UIColor darkGrayColor];
         
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    domain = [prefs stringForKey:@"URL"];
    
    [navBar setTintColor:[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavbar/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavbar/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavbar/255.0 alpha:1.0]];
    navBar.layer.borderColor=[UIColor colorWithRed:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).redNavBorder/255.0 green:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).greenNavBorder/255.0 blue:((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).blueNavBorder/255.0 alpha:1.0].CGColor;
    navBar.layer.borderWidth=1.0f;
    
    signuplab.font= ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).fontNavTitle;
    
    signuplab.text=@"My Profile";
      
    [txtEmail setDelegate:self];
    [txtConfirmEmail setDelegate:self];
       
    segmentCtrlMonth.momentary = YES;
    segmentCtrlDate.momentary = YES;
    segmentCtrlYear.momentary = YES;
  
    segmentCtrlMinAge.momentary = YES;
    segmentCtrlMaxAge.momentary = YES;
    segmentControlCity.momentary=YES;
    segmentControlState.momentary=YES;
    segmentControlCountry.momentary=YES;
        
    flag = 0;
    
    uiPickerView.hidden = YES;
    uiPickerDayView.hidden = YES;
    uiPickerMonthView.hidden = YES;
    
    minAgeArray = [[NSMutableArray alloc] init];
    
	
    for (int i = 20; i <= 103; i ++)
    {   
		NSString *myString = [NSString stringWithFormat:@"%d", i];
		[minAgeArray addObject:myString]; 
	}
    
    maxAgeArray = [[NSMutableArray alloc] init];
    
   
	for (int i = 20; i <= 103; i ++) 
    {   
		NSString *myString = [NSString stringWithFormat:@"%d", i];
		[maxAgeArray addObject:myString]; 
	}
    
    [self performSelector:@selector(fillCountry) withObject:nil];
    
    UITapGestureRecognizer *tapDatePicker = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapPicker:)];
    tapDatePicker.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer *tapMinAgePicker = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapPicker:)];
    tapMinAgePicker.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer *tapMaxAgePicker = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapPicker:)];
    tapMaxAgePicker.cancelsTouchesInView = NO;
    
    
    UITapGestureRecognizer *tapCountryPicker = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapPicker:)];
    tapCountryPicker.cancelsTouchesInView = NO;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    singleTap.cancelsTouchesInView = NO;
       
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) 
    {
        tempScrollView.contentSize=CGSizeMake(768,1140);
    }
           
    tempScrollView.canCancelContentTouches = NO;
    [tempScrollView flashScrollIndicators];
    [minAgePicker addGestureRecognizer:tapMinAgePicker];
    [maxAgePicker addGestureRecognizer:tapMaxAgePicker];
       
    [singleTap release];
    [tapMinAgePicker release];
    [tapMaxAgePicker release];
    [tapCountryPicker release];
        
    
    btnMinAge.placeholder = @"20";
    btnMaxAge.placeholder = @"103";
    
    yearLabel.text=@"";
    monthLabel.text=@"";
    dayLabel.text=@"";
             
    yearLabel.font = [UIFont fontWithName:@"Ubuntu-Bold" size:14];
    monthLabel.font = [UIFont fontWithName:@"Ubuntu-Bold" size:14];
    dayLabel.font = [UIFont fontWithName:@"Ubuntu-Bold" size:14];
    minAgeLabel.font = [UIFont fontWithName:@"Ubuntu-Bold" size:12];
    maxAgeLabel.font = [UIFont fontWithName:@"Ubuntu-Bold" size:12];
    lblFrom.text=@"From";
    lblFrom.font = [UIFont fontWithName:@"Ubuntu-Bold" size:12];
    lblTo.text=@"To";
    lblTo.font = [UIFont fontWithName:@"Ubuntu-Bold" size:12];
   
    lblAdult.font = [UIFont fontWithName:@"Ubuntu-Bold" size:12];
 
    lblAgreeTerms.font = [UIFont fontWithName:@"Ubuntu-Bold" size:12];
   
    lblYearsOld.font = [UIFont fontWithName:@"Ubuntu-Bold" size:12];
    iamMaleBtnClicked=NO;
    lfFemaleBtnCLicked=NO;
    iamAdult=NO;
    termsOfUSe=NO;
    
    imgMale=[UIImage imageNamed:@"man.png"];
    imgMaleClicked=[UIImage imageNamed:@"man_click.png"];
    imgFemale=[UIImage imageNamed:@"women.png"];
    imgFemaleClicked=[UIImage imageNamed:@"women_click.png"];
    imgCouple=[UIImage imageNamed:@"man_women.png"];
    imgCoupleClicked=[UIImage imageNamed:@"man_women_click.png"];
    imgGroup=[UIImage imageNamed:@"man_women_a.png"];
    imgGroupClicked=[UIImage imageNamed:@"man_women_a_click.png"];
    
    imgUnChecked=[UIImage imageNamed:@"checkbox_normal.png"];
    imgChecked=[UIImage imageNamed:@"checkbox_cheched.png"];
    
    txtCity.textColor=[UIColor darkGrayColor];
    txtCity.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    
    lablMonth.layer.cornerRadius = 5;
    lablDate.layer.cornerRadius = 5;
    lablYear.layer.cornerRadius = 5;
    btnMaxAge.layer.cornerRadius = 5;
    btnMinAge.layer.cornerRadius = 5;
    
    monthArrayNo = [[NSMutableArray alloc] initWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December", nil];
    [monthPickerView selectRow:0 inComponent:0 animated:NO];
       
    dateArrayNo = [[NSMutableArray alloc] init];
	
    for (int j = 1; j <= 31; j ++) 
    {   
		NSString *myDateString = [NSString stringWithFormat:@"%d", j];
		[dateArrayNo addObject:myDateString]; 
	}
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSYearCalendarUnit fromDate:[NSDate date]];
    currentYear = [components year];
   
    NSInteger endingYear = (currentYear) - 20;

    yearArrayNo = [[NSMutableArray alloc] init];
	
    for (int k = 1911; k <= endingYear; k ++)
    {   
		NSString *myYearString = [NSString stringWithFormat:@"%d", k];
		[yearArrayNo addObject:myYearString]; 
	}
    
    selectedCountryId=@"";
    selectedRegionId=@"";
    strCityCodeStore=@"";

}

-(void) viewWillDisappear:(BOOL)animated 
{    
	[[NSNotificationCenter defaultCenter]
	 removeObserver:self];
}

-(void)viewWillAppear:(BOOL)animated
{    
    
  /*  if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        [self orientationForIpad];
    }*/
            
    UITapGestureRecognizer* gesturel;
    gesturel = [[UITapGestureRecognizer alloc]  initWithTarget:self action:@selector(handleSwipeFrom:)];
    gesturel.delegate=self;
    [gesturel setNumberOfTapsRequired:2];
    [gesturel setDelaysTouchesBegan:NO];
    [self.view addGestureRecognizer:gesturel];
    [gesturel release];
    
}

- (void)viewDidUnload
{    
    [self setBtnback:nil];
    [self setLablMonth:nil];
    [self setLablDate:nil];
    [self setLablYear:nil];
    [self setTxtCountry:nil];
    [self setTxtRegion:nil];
    [self setUiCountryPickerView:nil];
    [self setUiStatePickerView:nil];
    [self setUiCityPickerView:nil];
    [self setCountryPicker:nil];
    [self setStatePicker:nil];
    [self setCityPicker:nil];
    [self setSegmentControlCountry:nil];
    [self setSegmentControlCity:nil];
    [self setSegmentControlState:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
    
    /*if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {        
        [self orientationForIpad];
        
        return YES;
    }
    else 
    {        
        return NO;
    }*/
}


#pragma mark XMLParserDelegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict
{     
    if ([elementName isEqualToString:@"Country_str_code"]) 
    {    
        countryCodeFound=YES;
    }
      
    if ([elementName isEqualToString:@"Country_str_name"]) 
    { 
        countryNameFound=YES;
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string 
{	
    if (countryCodeFound) 
    {
        [countryCodeArray addObject:string];
        countryCodeFound=NO;
    }
    if (countryNameFound)
    {
        [countrynamesArray addObject:string];
        countryNameFound=NO;
    }
  
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{     
}


#pragma mark IBAction

- (IBAction)datePickerDone:(id)sender
{   
    
    uiPickerView.hidden = YES;
    uiPickerDayView.hidden = YES;
    uiPickerMonthView.hidden = YES;
    
    uiMaxAgePickerView.hidden = YES;
    uiMinAgePickerView.hidden = YES;
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    
    monthPickerView.hidden = YES;
    dayPickerView.hidden = YES;
    yearPickerView.hidden = YES;
    
    btnMinAge.hidden = NO;
    btnMaxAge.hidden =  NO;
    minAgeLabel.hidden = NO;
    maxAgeLabel.hidden = NO;
    tempScrollView.scrollEnabled=YES;
    lblCountry.hidden=NO;
    lblMatchAge.hidden=NO;
        
    tempScrollView.scrollEnabled=YES;
    lablDate.enabled=YES;
    lablMonth.enabled=YES;
    lablYear.enabled=YES;
    txtEmail.enabled=YES;
    txtCity.enabled=YES;
    txtRegion.enabled=YES;
    txtCountry.enabled=YES;
    txtConfirmEmail.enabled=YES;
    btnMaxAge.enabled=YES;
    btnMinAge.enabled=YES;
    
}

- (IBAction)yearPickerDoneButton:(id)sender
{ 
    uiPickerView.hidden = YES;
    uiPickerDayView.hidden = YES;
    uiPickerMonthView.hidden = YES;
    uiMaxAgePickerView.hidden = YES;
    uiMinAgePickerView.hidden = YES;
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    
    monthPickerView.hidden = YES;
    dayPickerView.hidden = YES;
    yearPickerView.hidden = YES;
    btnMinAge.hidden = NO;
    btnMaxAge.hidden =  NO;
    minAgeLabel.hidden = NO;
    maxAgeLabel.hidden = NO;

    tempScrollView.scrollEnabled=YES;
    lblCountry.hidden=NO;
    lblMatchAge.hidden=NO;
     
    tempScrollView.scrollEnabled=YES;
    lablDate.enabled=YES;
    lablMonth.enabled=YES;
    lablYear.enabled=YES;
    txtEmail.enabled=YES;
    txtCity.enabled=YES;
    txtRegion.enabled=YES;
    txtCountry.enabled=YES;
    txtConfirmEmail.enabled=YES;
    btnMaxAge.enabled=YES;
    btnMinAge.enabled=YES;
     
    if(([monthLabel.text isEqualToString :@"February"]) && ([dayLabel.text isEqualToString :@"29"]) && (leapYear %4 != 0) && (leapYear %100 != 0))
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:[@"You have selected an invalid Date Of Birth" description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return ;
    }
      
}

- (IBAction)minAgePickerDone:(id)sender
{          
    uiPickerView.hidden = YES;
    uiPickerDayView.hidden = YES;
    uiPickerMonthView.hidden = YES;
    
    uiMaxAgePickerView.hidden = YES;
    uiMinAgePickerView.hidden = YES;
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    
    monthPickerView.hidden = YES;
    dayPickerView.hidden = YES;
    yearPickerView.hidden = YES;
    
    btnMinAge.hidden = NO;
    btnMaxAge.hidden =  NO;
    minAgeLabel.hidden = NO;
    maxAgeLabel.hidden = NO;
  
    tempScrollView.scrollEnabled=YES;
    lblCountry.hidden=NO;
    selectedCountryLbl.hidden=NO;
     
    tempScrollView.scrollEnabled=YES;
    lablDate.enabled=YES;
    lablMonth.enabled=YES;
    lablYear.enabled=YES;
    txtEmail.enabled=YES;
    txtCity.enabled=YES;
    txtRegion.enabled=YES;
    txtCountry.enabled=YES;
    txtConfirmEmail.enabled=YES;
    btnMaxAge.enabled=YES;
    btnMinAge.enabled=YES;
    
}

- (IBAction)maxAgePickerDone:(id)sender
{         
    uiPickerView.hidden = YES;
    uiPickerDayView.hidden = YES;
    uiPickerMonthView.hidden = YES;
    
    uiMaxAgePickerView.hidden = YES;
    uiMinAgePickerView.hidden = YES;
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    
    monthPickerView.hidden = YES;
    dayPickerView.hidden = YES;
    yearPickerView.hidden = YES;
    
    btnMinAge.hidden = NO;
    btnMaxAge.hidden =  NO;
    minAgeLabel.hidden = NO;
    maxAgeLabel.hidden = NO;
 
    tempScrollView.scrollEnabled=YES;
    lblCountry.hidden=NO;
    selectedCountryLbl.hidden=NO;
             
    tempScrollView.scrollEnabled=YES;
    lablDate.enabled=YES;
    lablMonth.enabled=YES;
    lablYear.enabled=YES;
    txtEmail.enabled=YES;
    txtCity.enabled=YES;
    txtRegion.enabled=YES;
    txtCountry.enabled=YES;
    txtConfirmEmail.enabled=YES;
    btnMaxAge.enabled=YES;
    btnMinAge.enabled=YES;
    
}


- (IBAction) clickedSegCtrlDOB:(id)sender
{    
    int selectedsegment=segmentCtrlMonth.selectedSegmentIndex;
    
    if (selectedsegment==0) 
	{
        if (indexMonthRange!=0) 
        {
            indexMonthRange--;
            [self pickerView:monthPickerView didSelectRow:indexMonthRange inComponent:1];
            [monthPickerView selectRow:indexMonthRange inComponent:0 animated:YES];
            [monthPickerView reloadComponent:0];
        }  
    }
	if (selectedsegment==1)
    {
        if (indexMonthRange<([monthArrayNo count]-1))
        {
            indexMonthRange++;
            [self pickerView:monthPickerView didSelectRow:indexMonthRange inComponent:1];
            [monthPickerView selectRow:indexMonthRange inComponent:0 animated:YES];
            [monthPickerView reloadComponent:0];
        }
    }
}


- (IBAction) clickedSegCtrlDay:(id)sender
{
    
    int selectedsegment=segmentCtrlDate.selectedSegmentIndex;
    
    if (selectedsegment==0) 
	{
        if (indexDayRange!=0)
        {
            indexDayRange--;
            [self pickerView:dayPickerView didSelectRow:indexDayRange inComponent:1];
            [dayPickerView selectRow:indexDayRange inComponent:0 animated:YES];
            [dayPickerView reloadComponent:0];
        }  
    }
	if (selectedsegment==1)
    {
        if (indexDayRange<([dateArrayNo count]-1)) 
        {
            indexDayRange++;
            [self pickerView:dayPickerView didSelectRow:indexDayRange inComponent:1];
            [dayPickerView selectRow:indexDayRange inComponent:0 animated:YES];
            [dayPickerView reloadComponent:0];
        }
    }
}


- (IBAction) clickedSegCtrlMonth:(id)sender
{
    
    int selectedsegment=segmentCtrlYear.selectedSegmentIndex;
    if (selectedsegment==0) 
	{
        if (indexYearRange!=0) 
        {
            indexYearRange--;
            [self pickerView:yearPickerView didSelectRow:indexYearRange inComponent:1];
            [yearPickerView selectRow:indexYearRange inComponent:0 animated:YES];
            [yearPickerView reloadComponent:0];
        }  
    }
	if (selectedsegment==1)
    {
        if (indexYearRange<([yearArrayNo count]-1)) 
        {
            indexYearRange++;
            [self pickerView:yearPickerView didSelectRow:indexYearRange inComponent:1];
            [yearPickerView selectRow:indexYearRange inComponent:0 animated:YES];
            [yearPickerView reloadComponent:0];
        }
    }
}


- (IBAction) clickedSegCtrlMinAge
{
    
    int selectedsegment=segmentCtrlMinAge.selectedSegmentIndex;
    if (selectedsegment==0) 
    {
        if (indexMinAge!=0)
        {
            indexMinAge--;
            [self pickerView:minAgePicker didSelectRow:indexMinAge inComponent:1];
            [minAgePicker selectRow:indexMinAge inComponent:0 animated:YES];
            [minAgePicker reloadComponent:0];
        }
    }
    if (selectedsegment==1)
    {
        if (indexMinAge<([minAgeArray count]-1)) 
        {
            indexMinAge++;
            [self pickerView:minAgePicker didSelectRow:indexMinAge inComponent:1];
            [minAgePicker selectRow:indexMinAge inComponent:0 animated:YES];
            [minAgePicker reloadComponent:0];
        }
    }
}

- (IBAction) clickedSegCtrlMaxAge
{
    
    int selectedsegment=segmentCtrlMaxAge.selectedSegmentIndex;
    if (selectedsegment==0) 
    {
        if (indexMaxAge!=0)
        {
            indexMaxAge--;
            [self pickerView:maxAgePicker didSelectRow:indexMaxAge inComponent:1];
            [maxAgePicker selectRow:indexMaxAge inComponent:0 animated:YES];
            [maxAgePicker reloadComponent:0];
        }
    }
    if (selectedsegment==1)
    {
        if (indexMaxAge<([maxAgeArray count]-1)) 
        {
            indexMaxAge++;
            [self pickerView:maxAgePicker didSelectRow:indexMaxAge inComponent:1];
            [maxAgePicker selectRow:indexMaxAge inComponent:0 animated:YES];
            [maxAgePicker reloadComponent:0];
        }
    }
}

- (IBAction)monthAutoFill:(id)sender
{
    
    NSString *chosenMonthSel = [monthArrayNo objectAtIndex:0];
    monthLabel.text = chosenMonthSel;
    lablMonth.placeholder = @"";
    indexMonthRange = 0;
    [self datePickerDone:sender];
}

- (IBAction)dayAutoFill:(id)sender
{
    
    NSString *chosenDaySel = [dateArrayNo objectAtIndex:0];
    dayLabel.text = chosenDaySel;
    lablDate.placeholder = @"";
    indexDayRange = 0;
    [self datePickerDone:sender];
}

- (IBAction)yearAutoFill:(id)sender
{ 
    
    NSString *chosenYearSel = [yearArrayNo objectAtIndex:0];
    yearLabel.text = chosenYearSel;
    lablYear.placeholder = @"";
    indexYearRange = 0;
    [self datePickerDone:sender];
}

- (IBAction)minAgeAutoFill:(id)sender
{
    NSString *chosenAge = [minAgeArray objectAtIndex:0];
    minAgeLabel.text = chosenAge;
    indexMinAge = 0;
    btnMinAge.placeholder = @"";
    [self minAgePickerDone:sender];
}

- (IBAction)maxAgeAutoFill:(id)sender
{
    NSString *chosenAge = [maxAgeArray objectAtIndex:0];
    maxAgeLabel.text = chosenAge;
    indexMaxAge = 0;
    btnMaxAge.placeholder = @"";
    [self maxAgePickerDone:sender];
    
}


- (IBAction)clickedSignUpButton:(id)sender
{
    
    [txtEmail resignFirstResponder];
    [txtConfirmEmail resignFirstResponder];
    [txtCity resignFirstResponder];

    uiPickerView.hidden = YES;
    uiPickerDayView.hidden = YES;
    uiPickerMonthView.hidden = YES;
    
    uiMaxAgePickerView.hidden = YES;
    uiMinAgePickerView.hidden = YES;
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    
    monthPickerView.hidden = YES;
    dayPickerView.hidden = YES;
    yearPickerView.hidden = YES;
        
    btnMinAge.hidden = NO;
    btnMaxAge.hidden =  NO;
    minAgeLabel.hidden = NO;
    maxAgeLabel.hidden = NO;
 
    tempScrollView.scrollEnabled=YES;
    int gender=0;
    int lookingfor=0;
    
    if (iamMaleBtnClicked)
    {
        gender=btnMale.tag;
    }
    else if (iamFemaleBtnCLicked) 
    {
        gender=btnFemale.tag;
    }
    else if (iamCoupleBtnClicked)
    {
        gender=btnCouple.tag;
    }
    else if (iamGroupBtnClicked) 
    {
        gender=btnGroup.tag;
    }
    
    if (lfMaleBtnClicked) 
    {
        lookingfor+=btnLFMale.tag;
    }
    if (lfFemaleBtnCLicked) 
    {
        lookingfor+=btnLFFemale.tag;
    }
    if (lfCoupleBtnClicked)
    {
        lookingfor+=btnLFCouple.tag;
    }
    if (lfGroupBtnClicked) 
    {
        lookingfor+=btnLFGroup.tag;
    }
    
    if (gender==0)
    {        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Please select your gender." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return ;
    }
    if (lookingfor==0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Please select looking for gender." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return ;
    }
    
    if ( (txtEmail.text == (id)[NSNull null])
        || (txtEmail.text == NULL)
        || ([txtEmail.text isEqualToString:@""])
        || ([txtEmail.text length] == 0) )
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Email Id should not be empty." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return ;
    }  
    if ( (txtConfirmEmail.text == (id)[NSNull null])
        || (txtConfirmEmail.text == NULL)
        || ([txtConfirmEmail.text isEqualToString:@""])
        || ([txtConfirmEmail.text length] == 0) )
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please confirm your Email Id." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return ;
    }  
    if (![self validateEmailWithString:txtEmail.text] ||![self validateEmailWithString:txtConfirmEmail.text]) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Please enter a valid Email Id." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return ;
    }
    if (![txtEmail.text isEqualToString:txtConfirmEmail.text])
    {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Email mismatch..." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return ;
    }
    if (([monthLabel.text isEqualToString :@""])||([dayLabel.text isEqualToString :@""])||([yearLabel.text isEqualToString:@""]))
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"Please enter your Date Of Birth." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return ;
    }
    if(([monthLabel.text isEqualToString :@"February"]) && ([dayLabel.text isEqualToString :@"29"]) && (leapYear %4 != 0) && (leapYear %100 != 0))
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert" message:[@"You have selected an invalid Date Of Birth" description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return ;
    }
    if([minAgeLabel.text intValue] == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning Alerts" message:[@"Please enter minimum age range from" description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return ;
    }
    
    if([maxAgeLabel.text intValue] == 0)
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning Alerts" message:[@"Please enter maximum age range from" description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return ; 
    }
    if (NO == iamAdult) 
    {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"You have to be minimum 18 years of age to Sign Up to this site!" description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return ;
    }
    if (NO == termsOfUSe)
    {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:[@"You need to agree to the Terms of use inorder to sign up to this site" description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return ;
    }
    
    if ( (selectedCountryId == (id)[NSNull null])
        || (selectedCountryId == NULL)
        || ([selectedCountryId isEqualToString:@""])
        || ([selectedCountryId length] == 0) )
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please Select your country." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
        return ;
    }
    if(txtRegion.hidden==NO)
    {        
        if((selectedRegionLbl.text== (id)[NSNull null])||(selectedRegionLbl.text==NULL)||([selectedRegionLbl.text isEqualToString:@""])||([selectedRegionLbl.text length]==0)||([selectedRegionLbl.text isEqualToString:@"Please Select"]))
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please select your state." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            return ;
        }
    }
    if(txtCity.hidden==NO)
    {
        if((selectedCityLbl.text== (id)[NSNull null])||(selectedCityLbl.text==NULL)||([selectedCityLbl.text isEqualToString:@""])||([selectedCityLbl.text length]==0)||([selectedCityLbl.text isEqualToString: @"Please Select"]))
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Info" message:@"Please select your city." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];
            return ;
        }
    }
    
    
    month=@"";
    month=[CommonStaticMethods GetMonthNumber:monthLabel.text];
    
    strPswStore=(NSString *)password;
    //NSString *enPass=[NSString stringWithFormat:@"%@%@",siteSALT, password];
    //encryptedPass = [self stringToSha1:enPass];
         
    NSString *req=[ NSString stringWithFormat: @"%@/mobile/Join/index.php?email=\"%@\"&username=\"%@\"&password=\"%@\"&sex=%d&match_sex=%d&birthdate=\"%@-%@-%@\"&match_agerange=\"%@-%@\"&country_id=\"%@\"&state_id=\"%@\"&city_id=\"%@\"&join_ip=%@",domain,txtEmail.text,username,strPswStore,gender,lookingfor,yearLabel.text,month,dayLabel.text,minAgeLabel.text, maxAgeLabel.text,selectedCountryId,selectedRegionId,strCityCodeStore,self.strIpStorage];
            
    isSignUP=YES;

    self.view.userInteractionEnabled=NO;
    NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:req, @"url", @"SignUpCon", @"meta", nil];
    [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
    [self performSelectorOnMainThread:@selector(WebRequest:) withObject:params waitUntilDone:NO];
    
}

- (IBAction)iamBtnsClicked:(UIButton *)button
{  
    uiPickerView.hidden = YES;
    uiPickerDayView.hidden = YES;
    uiPickerMonthView.hidden = YES;
    uiMaxAgePickerView.hidden = YES;
    uiMinAgePickerView.hidden = YES;
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    
    monthPickerView.hidden = YES;
    dayPickerView.hidden = YES;
    yearPickerView.hidden = YES;
    
    if (button.tag==2 && iamMaleBtnClicked)
    {
        [button setImage:imgMale forState:normal];
        
        iamMaleBtnClicked=NO;
    }
    else if (button.tag==2 && !iamMaleBtnClicked)
    {        
        [button setImage:imgMaleClicked forState:normal];
        [btnFemale setImage:imgFemale forState:normal];
        [btnCouple setImage:imgCouple forState:normal];
        [btnGroup setImage:imgGroup forState:normal];
        iamMaleBtnClicked=YES;
        iamCoupleBtnClicked=NO;
        iamFemaleBtnCLicked=NO;
        iamGroupBtnClicked=NO;
    }
    else if (button.tag==1 && iamFemaleBtnCLicked)
    {        
        [button setImage:imgFemale forState:normal];
        iamFemaleBtnCLicked=NO;
    }
    else if (button.tag==1 && !iamFemaleBtnCLicked) 
    {        
        [button setImage:imgFemaleClicked forState:normal];
        [btnMale setImage:imgMale forState:normal];
        [btnCouple setImage:imgCouple forState:normal];
        [btnGroup setImage:imgGroup forState:normal];
        iamFemaleBtnCLicked=YES;
        iamMaleBtnClicked=NO;
        iamCoupleBtnClicked=NO;
        iamGroupBtnClicked=NO;
    }
    else if (button.tag==4 && iamCoupleBtnClicked)
    {        
        [button setImage:imgCouple forState:normal];
        iamCoupleBtnClicked=NO;
    }
    else if (button.tag==4 && !iamCoupleBtnClicked)
    {        
        [button setImage:imgCoupleClicked forState:normal];
        [btnFemale setImage:imgFemale forState:normal];
        [btnMale setImage:imgMale forState:normal];
        [btnGroup setImage:imgGroup forState:normal];
        iamCoupleBtnClicked=YES;
        iamMaleBtnClicked=NO;
        iamFemaleBtnCLicked=NO;
        iamGroupBtnClicked=NO;
    }
    else if (button.tag==8 && iamGroupBtnClicked)
    {        
        [button setImage:imgGroup forState:normal];
        iamGroupBtnClicked=NO;
    }
    else if (button.tag==8 && !iamGroupBtnClicked)
    {        
        [button setImage:imgGroupClicked forState:normal];
        [btnFemale setImage:imgFemale forState:normal];
        [btnCouple setImage:imgCouple forState:normal];
        [btnMale setImage:imgMale forState:normal];
        iamGroupBtnClicked=YES;
        iamMaleBtnClicked=NO;
        iamCoupleBtnClicked=NO;
        iamFemaleBtnCLicked=NO;
    }
    
    [txtEmail resignFirstResponder];
    [txtConfirmEmail resignFirstResponder];
    btnMinAge.hidden = NO;
    btnMaxAge.hidden =  NO;
    minAgeLabel.hidden = NO;
    maxAgeLabel.hidden = NO;
  
    tempScrollView.scrollEnabled=YES;
    
}


- (IBAction)lookingForBtnsClicked:(UIButton *)button
{
    uiPickerView.hidden = YES;
    uiPickerDayView.hidden = YES;
    uiPickerMonthView.hidden = YES;
    uiMaxAgePickerView.hidden = YES;
    uiMinAgePickerView.hidden = YES;
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    
    monthPickerView.hidden = YES;
    dayPickerView.hidden = YES;
    yearPickerView.hidden = YES;
        
    if (button.tag==2 && lfMaleBtnClicked)
    {        
        [button setImage:imgMale forState:normal];
        lfMaleBtnClicked=NO;
    }
    else if (button.tag==2 && !lfMaleBtnClicked)
    {        
        [button setImage:imgMaleClicked forState:normal];
        lfMaleBtnClicked=YES;
    }
    else if (button.tag==1 && lfFemaleBtnCLicked) 
    {        
        [button setImage:imgFemale forState:normal];
        lfFemaleBtnCLicked=NO;
    }
    else if (button.tag==1 && !lfFemaleBtnCLicked) 
    {        
        [button setImage:imgFemaleClicked forState:normal];
        lfFemaleBtnCLicked=YES;
    }
    else if (button.tag==4 && lfCoupleBtnClicked)
    {        
        [button setImage:imgCouple forState:normal];
        lfCoupleBtnClicked=NO;
    }
    else if (button.tag==4 && !lfCoupleBtnClicked) 
    {        
        [button setImage:imgCoupleClicked forState:normal];
        lfCoupleBtnClicked=YES;
    }
    else if (button.tag==8 && lfGroupBtnClicked)
    {        
        [button setImage:imgGroup forState:normal];
        lfGroupBtnClicked=NO;
    }
    else if (button.tag==8 && !lfGroupBtnClicked) 
    {        
        [button setImage:imgGroupClicked forState:normal];
        lfGroupBtnClicked=YES;
    }
    
    [txtEmail resignFirstResponder];
    [txtConfirmEmail resignFirstResponder];
    btnMinAge.hidden = NO;
    btnMaxAge.hidden =  NO;
    minAgeLabel.hidden = NO;
    maxAgeLabel.hidden = NO;
 
    tempScrollView.scrollEnabled=YES;
    
}


- (IBAction)iamAdultChkBox:(UIButton *)button
{        
    [txtEmail resignFirstResponder];
    [txtConfirmEmail resignFirstResponder];
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    uiPickerView.hidden = YES;
    uiPickerDayView.hidden = YES;
    uiPickerMonthView.hidden = YES;
    selectedCountryLbl.hidden=NO;
    
    if (iamAdult) 
    {
        [button setImage:imgUnChecked forState:normal];
        iamAdult=NO;
    }
    else 
    {
        [button setImage:imgChecked forState:normal];
        iamAdult=YES;
    }
    tempScrollView.scrollEnabled=YES;
}


- (IBAction)termsOfUseChkBox:(UIButton *)button
{    
    [txtEmail resignFirstResponder];
    [txtConfirmEmail resignFirstResponder];
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    uiPickerView.hidden = YES;
    uiPickerDayView.hidden = YES;
    uiPickerMonthView.hidden = YES;
    selectedCountryLbl.hidden=NO;
    if (termsOfUSe) 
    {
        [button setImage:imgUnChecked forState:normal];
        termsOfUSe=NO;
    }
    else 
    {
        [button setImage:imgChecked forState:normal];
        termsOfUSe=YES;
    }
    tempScrollView.scrollEnabled=YES;
}


- (IBAction)clickedTermsOfUseButton:(UIButton *)button
{
        
    [txtEmail resignFirstResponder];
    [txtConfirmEmail resignFirstResponder];
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    uiPickerView.hidden = YES;
    uiPickerDayView.hidden = YES;
    uiPickerMonthView.hidden = YES;
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setBool:termsOfUSe forKey:@"touAgreed"];
    
    TermsOfUse *objTermsOfUse=[[TermsOfUse alloc]initWithNibName:@"TermsOfUse" bundle:nil];
    [self.navigationController pushViewController:objTermsOfUse animated:YES];
    [objTermsOfUse release];
    
}


- (IBAction)clickedBackButton:(UIButton *)button
{    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	[prefs setBool:NO forKey:@"touAgreed"];
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (IBAction)countryPickerDone:(id)sender
{    
    tempScrollView.scrollEnabled=YES;
    lablDate.enabled=YES;
    lablMonth.enabled=YES;
    lablYear.enabled=YES;
    txtEmail.enabled=YES;
    txtCity.enabled=YES;
    txtRegion.enabled=YES;
    txtCountry.enabled=YES;
    txtConfirmEmail.enabled=YES;
    btnMaxAge.enabled=YES;
    btnMinAge.enabled=YES;
    
    selectedRegionId=@"";
    strCityCodeStore=@"";
    
    tempScrollView.scrollEnabled=YES;
         
    if ([selectedCountryId isEqualToString: @""])
    {
        selectedCountryLbl.text=@"Please Select";
        isStateCountZero=YES;
        [self orientationForIpad];
    }
    else
    {
        urlReqRegion=[NSString stringWithFormat:@"%@/mobile/getState/?id=%@",domain,selectedCountryId];

        NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:urlReqRegion, @"url", @"GetRegionURLConnection", @"meta", nil];
        [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
        [self performSelectorOnMainThread:@selector(WebRequest:) withObject:params waitUntilDone:NO];
        self.view.userInteractionEnabled=NO;                        
    }
    CGPoint bottomOffset = CGPointMake(0,self.tempScrollView.contentSize.height - self.tempScrollView.bounds.size.height);
    [tempScrollView setContentOffset:bottomOffset animated:YES];
    
    uiCountryPickerView.hidden=YES;
    
}

- (IBAction)statePickerDone:(id)sender 
{        
    tempScrollView.scrollEnabled=YES;
    lablDate.enabled=YES;
    lablMonth.enabled=YES;
    lablYear.enabled=YES;
    txtEmail.enabled=YES;
    txtCity.enabled=YES;
    txtRegion.enabled=YES;
    txtCountry.enabled=YES;
    txtConfirmEmail.enabled=YES;
    btnMaxAge.enabled=YES;
    btnMinAge.enabled=YES;
    
    strCityCodeStore=@"";
    
    tempScrollView.scrollEnabled=YES;
       
    if ([selectedRegionId isEqualToString: @""])
    {   
        selectedRegionLbl.text=@"Please Select";
        isCityCountZero=YES;
        [self orientationForIpad];
    }
    else
    {           
        urlReqRegion=[NSString stringWithFormat:@"%@/mobile/getCity/?id=%@",domain,selectedRegionId];

        NSDictionary* params = [NSDictionary dictionaryWithObjectsAndKeys:urlReqRegion, @"url", @"GetcityURLConnection", @"meta", nil];
        [JSWaiter ShowWaiter:self title:@"Loading..." type:0];
        [self performSelectorOnMainThread:@selector(WebRequest:) withObject:params waitUntilDone:NO];
        self.view.userInteractionEnabled=NO;
        
    }
    
    CGPoint bottomOffset = CGPointMake(0,self.tempScrollView.contentSize.height - self.tempScrollView.bounds.size.height);
    [tempScrollView setContentOffset:bottomOffset animated:YES];
    
    uiStatePickerView.hidden=YES;
}

- (IBAction)cityPickerDone:(id)sender
{        
    tempScrollView.scrollEnabled=YES;
    uiCityPickerView.hidden=YES;
    lablDate.enabled=YES;
    lablMonth.enabled=YES;
    lablYear.enabled=YES;
    txtEmail.enabled=YES;
    txtCity.enabled=YES;
    txtRegion.enabled=YES;
    txtCountry.enabled=YES;
    txtConfirmEmail.enabled=YES;
    btnMaxAge.enabled=YES;
    btnMinAge.enabled=YES;
             
    if ([strCityCodeStore isEqualToString:@""])
    {    
        selectedCityLbl.text=@"Please Select";
    }
    else
    {  
        if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) 
        {
            [imgBGCountry setFrame:(CGRectMake(5, 688, 308, 183))];
            imgBGCountry.image=[UIImage imageNamed:@"location_field3.png"];
            [btnSignUp setFrame:(CGRectMake(22, 885, 275, 45))];
            tempScrollView.contentSize=CGSizeMake(320,998);
        }
           
    }
   
        CGPoint bottomOffset = CGPointMake(0,self.tempScrollView.contentSize.height - self.tempScrollView.bounds.size.height);
        [tempScrollView setContentOffset:bottomOffset animated:YES];
}


- (IBAction)clickedCountrySegCntrl:(id)sender
{    
    int selectedsegment=segmentControlCountry.selectedSegmentIndex;
    
    if (selectedsegment==0) 
    {
        if (indexCountry!=0)
        {
            indexCountry--;
            [self pickerView:countryPicker didSelectRow:indexCountry inComponent:1];
            [countryPicker selectRow:indexCountry inComponent:0 animated:YES];
            [countryPicker reloadComponent:0];
        }
    }
    if (selectedsegment==1)
    {
        if (indexCountry<([countrynamesArray count]-1)) 
        {
            indexCountry++;
            [self pickerView:countryPicker didSelectRow:indexCountry inComponent:1];
            [countryPicker selectRow:indexCountry inComponent:0 animated:YES];
            [countryPicker reloadComponent:0];
        }
    }
    
}

- (IBAction)clickedStateSegCntrl:(id)sender
{
    
    int selectedsegment=segmentControlState.selectedSegmentIndex;
    
    if (selectedsegment==0) 
    {
        if (indexState!=0) {
            indexState--;
            [self pickerView:statePicker didSelectRow:indexState inComponent:1];
            [statePicker selectRow:indexState inComponent:0 animated:YES];
            [statePicker reloadComponent:0];
        }
    }
    if (selectedsegment==1)
    {
        if (indexState<([stateNamesArray count]-1)) 
        {
            indexState++;
            [self pickerView:statePicker didSelectRow:indexState inComponent:1];
            [statePicker selectRow:indexState inComponent:0 animated:YES];
            [statePicker reloadComponent:0];
        }
    }
}

- (IBAction)clickedCitySegCntrl:(id)sender
{
    
    int selectedsegment=segmentControlCity.selectedSegmentIndex;
    
    if (selectedsegment==0) 
    {
        if (indexCity!=0) 
        {
            indexCity--;
            [self pickerView:cityPicker didSelectRow:indexCity inComponent:1];
            [cityPicker selectRow:indexCity inComponent:0 animated:YES];
            [cityPicker reloadComponent:0];
        }
    }
    if (selectedsegment==1)
    {
        if (indexCity<([cityNamesArray count]-1)) 
        {
            indexCity++;
            [self pickerView:cityPicker didSelectRow:indexCity inComponent:1];
            [cityPicker selectRow:indexCity inComponent:0 animated:YES];
            [cityPicker reloadComponent:0];
        }
    }
}


- (IBAction)countryAutofill:(id)sender 
{
    
    tempScrollView.scrollEnabled=YES;
    NSString *chosenAge = [countrynamesArray objectAtIndex:0];
    selectedCountryId=[countryCodeArray objectAtIndex:0];
    selectedCountryLbl.text = chosenAge;
    indexCountry = 0;
    [self countryPickerDone:sender];
}


- (IBAction)stateAutofill:(id)sender
{    
    tempScrollView.scrollEnabled=YES;
    NSString *chosenAge = [stateNamesArray objectAtIndex:0];
    selectedRegionId=[stateCodeArray objectAtIndex:0];
    selectedRegionLbl.text = chosenAge;
    indexState = 0;
    [self statePickerDone:sender];
}


- (IBAction)cityAutofill:(id)sender 
{
    
    tempScrollView.scrollEnabled=YES;
    NSString *chosenAge = [cityNamesArray objectAtIndex:0];
    strCityCodeStore=[cityCodeArray objectAtIndex:0];
    selectedCityLbl.text=chosenAge;
    indexCity = 0;
    [self cityPickerDone:sender];
}

#pragma mark Custom Methods For Touch Recognization

- (void)handleTapPicker:(UIGestureRecognizer *)gestureRecognizer 
{
 
}

- (void)handleSingleTap:(UIGestureRecognizer *)gestureRecognizer 
{    
    // single tap handling
    if (flag == 1) 
    {
        uiMinAgePickerView.hidden = YES;
        uiMaxAgePickerView.hidden = YES;
        uiPickerView.hidden = YES;
        uiPickerDayView.hidden = YES;
        uiPickerMonthView.hidden = YES;
        uiCountryPickerView.hidden=YES;
        uiStatePickerView.hidden=YES;
        uiCityPickerView.hidden=YES;
        btnMinAge.hidden = NO;
        btnMaxAge.hidden =  NO;
        minAgeLabel.hidden = NO;
        maxAgeLabel.hidden = NO;
    
    }
    
    [txtEmail resignFirstResponder];
    [txtConfirmEmail resignFirstResponder];

         
}


#pragma mark Swipe Recognization

- (void)handleSwipeFrom:(UITapGestureRecognizer*)recognizer
{       
  
    txtCity.userInteractionEnabled=YES;
    uiPickerDayView.hidden = YES;
    uiPickerMonthView.hidden = YES;
    uiPickerView.hidden = YES;
    uiMaxAgePickerView.hidden = YES;
    uiMinAgePickerView.hidden = YES;
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    uiCountryPickerView.hidden=YES;
    uiStatePickerView.hidden=YES;
    uiCityPickerView.hidden=YES;
    monthPickerView.hidden = YES;
    dayPickerView.hidden = YES;
    yearPickerView.hidden = YES;
    
    tempScrollView.scrollEnabled=YES;
        
    lablDate.enabled=YES;
    lablMonth.enabled=YES;
    lablYear.enabled=YES;
    txtEmail.enabled=YES;
    txtCity.enabled=YES;
    txtRegion.enabled=YES;
    txtCountry.enabled=YES;
    txtConfirmEmail.enabled=YES;
    btnMaxAge.enabled=YES;
    btnMinAge.enabled=YES;
    
    if (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    {
        CGPoint bottomOffset = CGPointMake(0,self.tempScrollView.contentSize.height - self.tempScrollView.bounds.size.height);
        [tempScrollView setContentOffset:bottomOffset animated:YES];
    }
        
}

#pragma mark Picker View Delegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{    
    return 1;
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView == minAgePicker)
	{
        NSString *chosenAge = [minAgeArray objectAtIndex:row];
        minAgeLabel.text = chosenAge;
        btnMinAge.placeholder = @"";
        indexMinAge = row;
    }
    else if(pickerView == maxAgePicker)
    {
        NSString *chosenAge = [maxAgeArray objectAtIndex:row];
        maxAgeLabel.text = chosenAge;
        btnMaxAge.placeholder = @"";
        indexMaxAge = row;
    }
    else if(pickerView == monthPickerView)
    {
        NSString *chosenMonth = [monthArrayNo objectAtIndex:row];
        monthLabel.text = chosenMonth;
        lablMonth.placeholder = @"";
        indexMonthRange = row;
         month = [NSString stringWithFormat:@"%d",row+1];
         [month retain];
    }
    else if(pickerView == dayPickerView)
    {
        NSString *chosenDate = [dateArrayNo objectAtIndex:row];
        dayLabel.text = chosenDate;
        lablDate.placeholder = @"";
        indexDayRange = row;
    }
    else if(pickerView == yearPickerView)
    {
        NSString *chosenYear = [yearArrayNo objectAtIndex:row];
        yearLabel.text = chosenYear;
        lablYear.placeholder = @"";
        indexYearRange = row;
        leapYear = [yearLabel.text integerValue];
    }
    else if(pickerView == countryPicker)
    {        
        selectedCountryId=[countryCodeArray objectAtIndex:row];
        NSString *chosenAge = [countrynamesArray objectAtIndex:row];
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {            
            if ([chosenAge length]>37)
            {                
                NSString *pp= [chosenAge substringToIndex:37];
                chosenAge=pp;
            }
        }
        else
        {      
            if ([chosenAge length]>24) 
            {                
                NSString *pp= [chosenAge substringToIndex:24];
                chosenAge=pp;
                
            }
        }
        
        selectedCountryLbl.text = chosenAge;
        indexCountry = row;
        uiStatePickerView.hidden=YES;
        uiCityPickerView.hidden=YES;
    }
    else if(pickerView == statePicker)
    {      
        
        NSString *chosenAge = [stateNamesArray objectAtIndex:row];
        
        selectedRegionId=[stateCodeArray objectAtIndex:row];
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {            
            if ([chosenAge length]>37)
            {                
                NSString *pp= [chosenAge substringToIndex:37];
                chosenAge=pp;
                
            }
        }
        else
        {                 
            if ([chosenAge length]>24) 
            {                
                NSString *pp= [chosenAge substringToIndex:24];
                chosenAge=pp;
                
            }
                
        }
        
        selectedRegionLbl.text = chosenAge;
        indexState = row;
        uiCountryPickerView.hidden=YES;
        uiCityPickerView.hidden=YES;
    }
    else if(pickerView == cityPicker)
    {        
        strCityCodeStore=[cityCodeArray objectAtIndex:row];
     
        NSString *chosenAge = [cityNamesArray objectAtIndex:row];
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            if ([chosenAge length]>37)
            {                
                NSString *pp= [chosenAge substringToIndex:37];
                chosenAge=pp;
            }
        }
        else
        {      
            if ([chosenAge length]>24) 
            {                
                NSString *pp= [chosenAge substringToIndex:24];
                chosenAge=pp;
                
            }
            
        }
        
        selectedCityLbl.text=chosenAge;
        indexCity = row;
        uiCountryPickerView.hidden=YES;
        uiStatePickerView.hidden=YES;
        
    }

}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{      
    
    if(pickerView == countryPicker)
    {
        return [countrynamesArray count];
        
        // return number of components in first picker  
    } 
    else if(pickerView == statePicker)
    {        
        // return number of components in first picker  
        
        return [stateNamesArray count];
    }
    else if(pickerView == cityPicker) 
    {        
        // return number of components in first picker  
        
        return [cityNamesArray count];
    } 
    else if(pickerView == minAgePicker)
    {        
        // return number of components in first picker  
        return [minAgeArray count];
        
    } 
    else if(pickerView == maxAgePicker) 
    {            
        // return number of components in second picker    
        return [maxAgeArray count];
        
    }
    else if(pickerView == monthPickerView)
    {         
        return [monthArrayNo count];
        
    }
    else if(pickerView == dayPickerView)
    {         
        return [dateArrayNo count];
        
    }
    else if(pickerView == yearPickerView)
    {         
        return [yearArrayNo count];
        
    }
    else
        return 0;
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{    
    
    if (pickerView == countryPicker)	
        return [countrynamesArray objectAtIndex:row];
    
    else if (pickerView == statePicker)	
        return [stateNamesArray objectAtIndex:row];
    
    else if (pickerView == cityPicker)	
        return [cityNamesArray objectAtIndex:row];
    
    else if (pickerView == minAgePicker)	
        return [minAgeArray objectAtIndex:row];
    
    else if(pickerView == maxAgePicker)
        return [maxAgeArray objectAtIndex:row];

    else if(pickerView == monthPickerView)
        return [monthArrayNo objectAtIndex:row];
    
    else if(pickerView == dayPickerView)
        return [dateArrayNo objectAtIndex:row];
    
    else if(pickerView == yearPickerView)
        return [yearArrayNo objectAtIndex:row];
    
    else
        return NULL;
}


#pragma mark Validation Methods

- (BOOL)validateZIPWithString:(NSString*)ZIPstr
{
    NSString *zipRegex = @"^((([A-PR-UWYZ][0-9])|([A-PR-UWYZ][0-9][0-9])|([A-PR-UWYZ][A-HK-Y][0-9])|([A-PR-UWYZ][A-HK-Y][0-9][0-9])|([A-PR-UWYZ][0-9][A-HJKSTUW])|([A-PR-UWYZ][A-HK-Y][0-9][ABEHMNPRVWXY])))"; 
    NSPredicate *ZipTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",zipRegex]; 
    return [ZipTest evaluateWithObject:ZIPstr];
}

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    return [emailTest evaluateWithObject:email];
}


#pragma mark Managing API Calls

-(void)WebRequest:(NSDictionary*)params
{
	NSString* url = [params valueForKey:@"url"];
    NSString* meta = [params valueForKey:@"meta"];
    
    JSWebManager* webMgr = [[[JSWebManager alloc] initWithAsyncOption:NO] autorelease];
    NSDictionary* ret = [webMgr GetDataFromUrl:url];
    NSError* error = [ret objectForKey:@"error"];
    
    if (error)
    {
        self.view.userInteractionEnabled=YES;
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[@"Connection failed...Please launch the application again." description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        [alertView release];
    }
    else
    {
        self.view.userInteractionEnabled=YES;
        NSDictionary *parsedData = (NSDictionary *)[ret objectForKey:@"data"];
        NSString* responseString = [ret objectForKey:@"text"];
        respSignIn.profileId = (NSString*)[parsedData objectForKey:@"Profile_Id"];
        respSignIn.skey=(NSString*)[parsedData objectForKey:@"skey"];
        NSString *MessageStr= (NSString*)[parsedData objectForKey:@"Message"];
        
        if ([meta isEqualToString:@"forGettingIp"])
        {
            self.strIpStorage=[NSString stringWithFormat:@"%@",responseString];
        }
        
        if(!parsedData)
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to retrieve data from the site. Kindly re-enter login credentials." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            [alertView release];            
        }
        else
        {
            if([MessageStr isEqualToString:@"Site suspended"])
            {
                UIAlertView *sessionAlertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:[@"Site suspended. Please try after sometime." description] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",nil];
                sessionAlertView.tag=1;
                [sessionAlertView show];
                [sessionAlertView release];
                [JSWaiter HideWaiter];
            }
            
            if ([meta isEqualToString:@"GetRegionURLConnection"])
            {
                NSString * count=(NSString *) [parsedData valueForKey:@"count"];
                
                NSArray *sn = [parsedData valueForKeyPath:@"result.Name"];
                stateNamesArray=[[NSMutableArray alloc] initWithArray:sn copyItems:YES];
                
                NSArray *scodes = [parsedData valueForKeyPath:@"result.Code"];
                stateCodeArray=[[NSMutableArray alloc] initWithArray:scodes copyItems:YES];
                
                int c=[stateNamesArray count];   // for handling none value
                
                if(c>0)
                {
                    if ([stateNamesArray objectAtIndex:c-1]==(id)[NSNull null]||[stateNamesArray objectAtIndex:c-1]==NULL)
                    {
                        
                        [stateNamesArray removeObjectAtIndex:c-1];
                        [stateCodeArray removeObjectAtIndex:c-1];
                    }
                    else
                    {
                        if ([[stateNamesArray objectAtIndex:c-1] length]>0)
                        {
                            if ([[stateNamesArray objectAtIndex:c-1] isEqualToString:@"(none)"])
                            {
                                [stateNamesArray removeLastObject];
                                [stateCodeArray removeLastObject];
                            }
                        }
                    }
                }
                
                
                txtCity.userInteractionEnabled=YES;
                selectedRegionLbl.text=@"Please Select";
                selectedRegionLbl.textColor=[UIColor darkGrayColor];
                isSignUP=NO;
                
                if ([count intValue]==0)
                {
                    isStateCountZero=YES;
                    selectedRegionLbl.text=@"";
                    txtCity.text=@"";
                    selectedRegionLbl.hidden=YES;
                    lblCity.hidden=YES;
                    txtCity.hidden=YES;
                    lblRegion.hidden=YES;
                    txtRegion.hidden=YES;
                    sta=NO;
                    cit=NO;
                    [self orientationForIpad];
                    
                }
                else
                {
                    isStateCountZero=NO;
                    txtCity.text=@"";
                    selectedRegionLbl.hidden=NO;
                    lblRegion.hidden=NO;
                    txtRegion.hidden=NO;
                    sta=YES;
                    cit=NO;
                    
                    [self orientationForIpad];
                    [statePicker reloadAllComponents];
                }
                
            }
            else if([meta isEqualToString:@"GetcityURLConnection"])
            {
                NSString * count=(NSString *) [parsedData valueForKey:@"count"];
                
                if ([count intValue]==0)
                {
                    isCityCountZero=YES;
                    txtCity.userInteractionEnabled=YES;
                    uiCityPickerView.hidden=YES;
                    selectedCityLbl.hidden=YES;
                    cit=NO;
                    sta=YES;
                    txtCity.text=@"";
                    lblCity.hidden=YES;
                    txtCity.hidden=YES;
                    [self orientationForIpad];
                    
                }
                else
                {
                    isCityCountZero=NO;
                    lblCity.hidden=NO;
                    txtCity.hidden=NO;
                    NSArray *cnames = [parsedData valueForKeyPath:@"result.Name"];
                    cityNamesArray=[[NSMutableArray alloc] initWithArray:cnames copyItems:YES];
                    
                    NSArray *ccodes = [parsedData valueForKeyPath:@"result.Code"];
                    cityCodeArray=[[NSMutableArray alloc] initWithArray:ccodes copyItems:YES];
                    
                    int c=[cityNamesArray count];   // for handling none value
                    
                    if(c>0)
                    {
                        if ([cityNamesArray objectAtIndex:c-1]==(id)[NSNull null]||[cityNamesArray objectAtIndex:c-1]==NULL)
                        {
                        }
                        else
                        {
                            if ([[cityNamesArray objectAtIndex:c-1] length]>0)
                            {
                                if ([[cityNamesArray objectAtIndex:c-1] isEqualToString:@"(none)"])
                                {
                                    [cityNamesArray removeLastObject];
                                    [cityCodeArray removeLastObject];
                                }
                            }
                        }
                    }
                    
                    selectedCityLbl.hidden=NO;
                    isSignUP=NO;
                    txtCity.userInteractionEnabled=YES;
                    
                    txtCity.userInteractionEnabled=YES;
                    selectedCityLbl.text=@"Please Select";
                    cityPicker.userInteractionEnabled=YES;
                    sta=NO;
                    cit=YES;
                    
                    [self orientationForIpad];
                    [cityPicker reloadAllComponents];
                }
                
            }
            else if([meta isEqualToString:@"SignUpCon"])
            {
                if ((respSignIn.profileId== (id)[NSNull null])||(respSignIn.profileId==NULL))
                {
                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sorry" message:@"Email address already exists. Please enter a different email address." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [alertView show];
                    [alertView release];
                    
                }
                else
                {
                    respSignIn.profilePicURL = (NSString*)[parsedData objectForKey:@"Profile_Pic"];
                    respSignIn.notifications = (NSNumber*)[parsedData objectForKey:@"Notifications"];
                    respSignIn.gender = (NSString*)[parsedData objectForKey:@"sex"];
                    respSignIn.TimeZone=(NSString*)[parsedData objectForKey:@"Time"];
                    
                    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfileID=respSignIn.profileId;
                    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedSessionID=respSignIn.skey;
                    
                    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedProfilePic=respSignIn.profilePicURL;
                    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedNotifications=0;
                    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).genderValue=respSignIn.gender;
                    ((SkadateAppDelegate *) [UIApplication sharedApplication].delegate).loggedTimeZone=respSignIn.TimeZone;
                    
                    HomeView *objHomeView=[[HomeView alloc]initWithNibName:@"HomeView" bundle:nil];
                    objHomeView.profileID=respSignIn.profileId;
                    objHomeView.profilePic=respSignIn.profilePicURL;
                    objHomeView.notifications=respSignIn.notifications;
                    [self.navigationController pushViewController:objHomeView animated:YES];
                    [objHomeView release];
                }
                
            }
        }
    }
    [JSWaiter HideWaiter];
}

#pragma mark AlertView Delegate

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex 
{        
    if (actionSheet.tag==1&&buttonIndex==0)
    {        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark Text Field Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{    
          
    if ((textField==txtEmail) ||(textField==txtConfirmEmail)) 
    {  
        if([string isEqualToString:@" "])
        {  
            return NO;
        }
        else
        {
            return YES;
        }
    }
    else
    {
        return YES;
    }
}

- (IBAction)textFieldDidBeginEditing:(UITextField *)textField
{   
        
    uiPickerView.hidden = YES;
    uiPickerDayView.hidden = YES;
    uiPickerMonthView.hidden = YES;
    uiMaxAgePickerView.hidden = YES;
    uiMinAgePickerView.hidden = YES;
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
    
    monthPickerView.hidden = YES;
    dayPickerView.hidden = YES;
    yearPickerView.hidden = YES;
    
    btnMinAge.hidden = NO;
    btnMaxAge.hidden =  NO;
    minAgeLabel.hidden = NO;
    maxAgeLabel.hidden = NO;
  
          
    if (textField==txtCountry)
    {
        [txtCountry resignFirstResponder];
        uiCountryPickerView.hidden=NO;
        uiStatePickerView.hidden=YES;
        uiCityPickerView.hidden=YES;
        txtCity.hidden=YES;
        selectedCityLbl.hidden=YES;
        lblCity.hidden=YES;
        tempScrollView.scrollEnabled=NO;
        
        lablDate.enabled=NO;
        lablMonth.enabled=NO;
        lablYear.enabled=NO;
        txtEmail.enabled=NO;
        txtCity.enabled=NO;
        txtRegion.enabled=NO;
        txtCountry.enabled=NO;
        txtConfirmEmail.enabled=NO;
        btnMaxAge.enabled=NO;
        btnMinAge.enabled=NO;
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {            
            if (self.interfaceOrientation==UIInterfaceOrientationPortrait || self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
            {              
                int movementDistance=0;
                                
                if (tempScrollView.bounds.origin.y==0) 
                {
                    movementDistance=166;
                }
                else
                    movementDistance=166-tempScrollView.bounds.origin.y;
                const float movementDuration = 0.3f;
                
                // tweak as needed
                
                int movement = movementDistance ;
                
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                int mov=tempScrollView.bounds.origin.y + movement;
                [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
                [UIView commitAnimations];
            
            }
            else if (self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation==UIInterfaceOrientationLandscapeRight) 
            {
                            
                int movementDistance = 0;
                            
                if (tempScrollView.bounds.origin.y==0) 
                {
                    movementDistance=420;
                }
                else
                    movementDistance=420-tempScrollView.bounds.origin.y;
                
                const float movementDuration = 0.3f;
                // tweak as needed
                
                int movement = movementDistance ;
            
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                int mov=tempScrollView.bounds.origin.y + movement;
                [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
                [UIView commitAnimations];
            }
        }
        else if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            int movementDistance = 0;
                    
            if (tempScrollView.bounds.origin.y==0)
            {
                movementDistance=617;
            }
            else
                movementDistance=617-tempScrollView.bounds.origin.y;
            
            const float movementDuration = 0.3f;
            // tweak as needed
        
            int movement = movementDistance ;
        
            [UIView beginAnimations: @"anim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: movementDuration];
            int mov=tempScrollView.bounds.origin.y + movement;
            [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
            [UIView commitAnimations];
        }
        
    }
    
    if (textField==txtRegion)
    {        
        [txtRegion resignFirstResponder];
        uiStatePickerView.hidden=NO;
        uiCountryPickerView.hidden=YES;
        
        lablDate.enabled=NO;
        lablMonth.enabled=NO;
        lablYear.enabled=NO;
        txtEmail.enabled=NO;
        txtCity.enabled=NO;
        txtRegion.enabled=NO;
        txtCountry.enabled=NO;
        txtConfirmEmail.enabled=NO;
        btnMaxAge.enabled=NO;
        btnMinAge.enabled=NO;
        
        uiCityPickerView.hidden=YES;
        tempScrollView.scrollEnabled=NO;
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {            
            if (self.interfaceOrientation==UIInterfaceOrientationPortrait || self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown) 
            {             
                int movementDistance = 0;
                               
                if (tempScrollView.bounds.origin.y==0)
                {
                    movementDistance=214;
                }
                else
                    movementDistance=214-tempScrollView.bounds.origin.y;
                
                const float movementDuration = 0.3f;
                // tweak as needed
                
                int movement = movementDistance ;
                
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                int mov=tempScrollView.bounds.origin.y + movement;
                [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
                [UIView commitAnimations];
                
            }
            else if (self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation==UIInterfaceOrientationLandscapeRight) 
            {
                           
                int movementDistance = 0;
                                
                if (tempScrollView.bounds.origin.y==0) 
                {
                    movementDistance=470;
                }
                else
                    movementDistance=470-tempScrollView.bounds.origin.y;
                
                const float movementDuration = 0.3f;
                // tweak as needed
                
                int movement = movementDistance ;
                
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                int mov=tempScrollView.bounds.origin.y + movement;
                [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
                [UIView commitAnimations];
            }
        }
        else if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            int movementDistance = 0;
                       
            if (tempScrollView.bounds.origin.y==0) 
            {
                movementDistance=656;
            }
            else
                movementDistance=656-tempScrollView.bounds.origin.y;
            
            const float movementDuration = 0.3f;
            // tweak as needed
            
            int movement = movementDistance ;
            
            [UIView beginAnimations: @"anim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: movementDuration];
            int mov=tempScrollView.bounds.origin.y + movement;
            [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
            [UIView commitAnimations];
        }
    }
    
    if (textField==txtCity)
    {
        tempScrollView.scrollEnabled=NO;
        [txtCity resignFirstResponder];        
        txtCity.userInteractionEnabled=NO;
        uiCityPickerView.hidden=NO;
               
        lablDate.enabled=NO;
        lablMonth.enabled=NO;
        lablYear.enabled=NO;
        txtEmail.enabled=NO;
        txtCity.enabled=NO;
        txtRegion.enabled=NO;
        txtCountry.enabled=NO;
        txtConfirmEmail.enabled=NO;
        btnMaxAge.enabled=NO;
        btnMinAge.enabled=NO;
        
        if ([cityNamesArray count]==0)
        {
            txtCity.text=@"Not Found";
                       
        }
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            
            if (self.interfaceOrientation==UIInterfaceOrientationPortrait || self.interfaceOrientation==UIInterfaceOrientationPortraitUpsideDown)
            {
              
                int movementDistance = 0;
                               
                if (tempScrollView.bounds.origin.y==0)
                {
                    movementDistance=260;
                }
                else
                    movementDistance=260-tempScrollView.bounds.origin.y;
                
                const float movementDuration = 0.3f;
                // tweak as needed
                
                int movement = movementDistance ;
                
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                int mov=tempScrollView.bounds.origin.y + movement;
                [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
                [UIView commitAnimations];
                
            }
            else if (self.interfaceOrientation==UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation==UIInterfaceOrientationLandscapeRight) 
            {
                
                int movementDistance = 0;
                                
                if (tempScrollView.bounds.origin.y==0)
                {
                    movementDistance=520;
                }
                else
                    movementDistance=520-tempScrollView.bounds.origin.y;
                
                const float movementDuration = 0.3f;
                // tweak as needed
                
                int movement = movementDistance ;
                
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                int mov=tempScrollView.bounds.origin.y + movement;
                [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
                [UIView commitAnimations];
            }
        }
        else if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        {
            int movementDistance = 0;
                    
            if (tempScrollView.bounds.origin.y==0) 
            {
                movementDistance=700;
            }
            else
                movementDistance=700-tempScrollView.bounds.origin.y;
            
            const float movementDuration = 0.3f;
            // tweak as needed
        
            int movement = movementDistance ;
            
            [UIView beginAnimations: @"anim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: movementDuration];
            int mov=tempScrollView.bounds.origin.y + movement;
            [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
            [UIView commitAnimations];
        }
        
    }
    else if (textField==lablMonth)
    {
        
        [lablMonth resignFirstResponder];
        tempScrollView.scrollEnabled=NO;
                   
        lablDate.enabled=NO;
        lablMonth.enabled=NO;
        lablYear.enabled=NO;
        txtEmail.enabled=NO;
        txtCity.enabled=NO;
        txtRegion.enabled=NO;
        txtCountry.enabled=NO;
        txtConfirmEmail.enabled=NO;
        btnMaxAge.enabled=NO;
        btnMinAge.enabled=NO;
             
        [txtEmail resignFirstResponder];
        [txtConfirmEmail resignFirstResponder];
        flag = 1;
        uiPickerView.hidden = NO;
        uiPickerDayView.hidden = YES;
        uiPickerMonthView.hidden = YES;
        
        dayPickerView.hidden = YES;
        yearPickerView.hidden = YES;
        
        monthPickerView.hidden = NO;
        monthPickerView.opaque = YES;
        
        btnMinAge.hidden = NO;
        btnMaxAge.hidden =  NO;
        
        uiMaxAgePickerView.hidden = YES;
        uiMinAgePickerView.hidden = YES;
        minAgeLabel.hidden = YES;
        maxAgeLabel.hidden = YES;
        lblCountry.hidden=YES;
        lblMatchAge.hidden=YES;
                          
        int movementDistance = 0;
        
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
            
            if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft)
            {
                [uiPickerView setFrame:CGRectMake(0, 655, 1024, 400)];
                int movementDistance = 0;
                
                if (tempScrollView.bounds.origin.y==0)
                {
                    movementDistance=210;
                }
                else
                    movementDistance=210-tempScrollView.bounds.origin.y;
                
                const float movementDuration = 0.3f;
                // tweak as needed
                
                int movement = movementDistance ;
                
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                int mov=tempScrollView.bounds.origin.y + movement;
                [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
                [UIView commitAnimations];
            
            }
            else 
            {                
                [uiPickerView setFrame:CGRectMake(0, 915, 768, 450)];
                
                int movementDistance = 0;
                
                if (tempScrollView.bounds.origin.y==0)
                {
                    movementDistance=210;
                }
                else
                    movementDistance=210-tempScrollView.bounds.origin.y;
                
                const float movementDuration = 0.3f;
                // tweak as needed
                
                int movement = movementDistance ;
                
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                int mov=tempScrollView.bounds.origin.y + movement;
                [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
                [UIView commitAnimations];
            }
            
            return;
        }
                
        if (tempScrollView.bounds.origin.y==0)
        {
            movementDistance=300;
        }
        else
            movementDistance=300-tempScrollView.bounds.origin.y;
        
        const float movementDuration = 0.3f; // tweak as needed
        
        int movement = movementDistance ;
        
        [UIView beginAnimations: @"anim" context: nil];
        [UIView setAnimationBeginsFromCurrentState: YES];
        [UIView setAnimationDuration: movementDuration];
        int mov=tempScrollView.bounds.origin.y + movement;
        [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
        [UIView commitAnimations];
    }
    else if (textField==lablDate) 
    {
     
       [lablDate resignFirstResponder];
       tempScrollView.scrollEnabled=NO;
           
       lablDate.enabled=NO;
       lablMonth.enabled=NO;
       lablYear.enabled=NO;
       txtEmail.enabled=NO;
       txtCity.enabled=NO;
       txtRegion.enabled=NO;
       txtCountry.enabled=NO;
       txtConfirmEmail.enabled=NO;
       btnMaxAge.enabled=NO;
       btnMinAge.enabled=NO;
           
       [txtEmail resignFirstResponder];
       [txtConfirmEmail resignFirstResponder];
       flag = 1;
       uiPickerView.hidden = YES;
       uiPickerDayView.hidden = NO;
       uiPickerMonthView.hidden = YES;
       
       monthPickerView.hidden = YES;
       yearPickerView.hidden = YES;
       
       dayPickerView.hidden = NO;
       dayPickerView.opaque = YES;
       
       btnMinAge.hidden = NO;
       btnMaxAge.hidden =  NO;
       
       uiMaxAgePickerView.hidden = YES;
       uiMinAgePickerView.hidden = YES;
       minAgeLabel.hidden = YES;
       maxAgeLabel.hidden = YES;
       lblCountry.hidden=YES;
       lblMatchAge.hidden=YES;
          
       if([monthLabel.text isEqualToString:@"February"])
       {            
           [dateArrayNo removeAllObjects];
           for (int j = 1; j <= 29; j ++)
           {   
               NSString *myDateString = [NSString stringWithFormat:@"%d", j];
               [dateArrayNo addObject:myDateString]; 
               [dayPickerView reloadAllComponents];
           }
           
       }
       else if([monthLabel.text isEqualToString:@"April"] || [monthLabel.text isEqualToString:@"June"] || [monthLabel.text isEqualToString:@"September"] || [monthLabel.text isEqualToString:@"November"])
       {          
             
           [dateArrayNo removeAllObjects];
           for (int j = 1; j <= 30; j ++) 
           {   
               NSString *myDateString = [NSString stringWithFormat:@"%d", j];
               [dateArrayNo addObject:myDateString]; 
               [dayPickerView reloadAllComponents];
           }
           
       }
       else
       {           
           [dateArrayNo removeAllObjects];
           for (int j = 1; j <= 31; j ++) 
           {   
               NSString *myDateString = [NSString stringWithFormat:@"%d", j];
               [dateArrayNo addObject:myDateString];
               [dayPickerView reloadAllComponents];
           }
       }
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
        {
           
            if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft)
            {
                [uiPickerDayView setFrame:CGRectMake(0, 655, 1024, 400)];
                int movementDistance = 0;
                
                if (tempScrollView.bounds.origin.y==0)
                {
                    movementDistance=210;
                }
                else
                    movementDistance=210-tempScrollView.bounds.origin.y;
                
                const float movementDuration = 0.3f;
                // tweak as needed
                
                int movement = movementDistance ;
                
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                int mov=tempScrollView.bounds.origin.y + movement;
                [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
                [UIView commitAnimations];
                
            }
            else 
            {                
                [uiPickerDayView setFrame:CGRectMake(0, 916, 768, 450)];                
                int movementDistance = 0;
                
                if (tempScrollView.bounds.origin.y==0)
                {
                    movementDistance=210;
                }
                else
                    movementDistance=210-tempScrollView.bounds.origin.y;
                
                const float movementDuration = 0.3f;
                // tweak as needed
                
                int movement = movementDistance ;
                
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                int mov=tempScrollView.bounds.origin.y + movement;
                [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
                [UIView commitAnimations];
            }

           
           return;
       }
       
       int movementDistance = 0;
      
       if (tempScrollView.bounds.origin.y==0)
       {
           movementDistance=300;
       }
       else
           movementDistance=300-tempScrollView.bounds.origin.y;
        
       const float movementDuration = 0.3f; // tweak as needed
       
       int movement = movementDistance ;
       
       [UIView beginAnimations: @"anim" context: nil];
       [UIView setAnimationBeginsFromCurrentState: YES];
       [UIView setAnimationDuration: movementDuration];
       int mov=tempScrollView.bounds.origin.y + movement;
       [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
       [UIView commitAnimations];

       
    }
    else if (textField==lablYear) 
    {
       
       [lablYear resignFirstResponder];
       tempScrollView.scrollEnabled=NO;
                  
       lablDate.enabled=NO;
       lablMonth.enabled=NO;
       lablYear.enabled=NO;
       txtEmail.enabled=NO;
       txtCity.enabled=NO;
       txtRegion.enabled=NO;
       txtCountry.enabled=NO;
       txtConfirmEmail.enabled=NO;
       btnMaxAge.enabled=NO;
       btnMinAge.enabled=NO;
                  
       [txtEmail resignFirstResponder];
       [txtConfirmEmail resignFirstResponder];
       flag = 1;
       uiPickerView.hidden = YES;
       uiPickerDayView.hidden = YES;
       uiPickerMonthView.hidden = NO;
       
       monthPickerView.hidden = YES;
       dayPickerView.hidden = YES;
       
       yearPickerView.hidden = NO;
       yearPickerView.opaque = YES;
       
       btnMinAge.hidden = NO;
       btnMaxAge.hidden =  NO;
       
       uiMaxAgePickerView.hidden = YES;
       uiMinAgePickerView.hidden = YES;
       minAgeLabel.hidden = YES;
       maxAgeLabel.hidden = YES;
       lblCountry.hidden=YES;
       lblMatchAge.hidden=YES;
                 
       if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
       {           

           if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft)
           {
               [uiPickerMonthView setFrame:CGRectMake(0, 655, 1024, 400)];
               int movementDistance = 0;
               
               if (tempScrollView.bounds.origin.y==0)
               {
                   movementDistance=210;
               }
               else
                   movementDistance=210-tempScrollView.bounds.origin.y;
               
               const float movementDuration = 0.3f;
               // tweak as needed
               
               int movement = movementDistance ;
               
               [UIView beginAnimations: @"anim" context: nil];
               [UIView setAnimationBeginsFromCurrentState: YES];
               [UIView setAnimationDuration: movementDuration];
               int mov=tempScrollView.bounds.origin.y + movement;
               [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
               [UIView commitAnimations];
               
           }
           else 
           {                
               [uiPickerMonthView setFrame:CGRectMake(0, 913, 768, 450)];
               int movementDistance = 0;
               
               if (tempScrollView.bounds.origin.y==0)
               {
                   movementDistance=210;
               }
               else
                   movementDistance=210-tempScrollView.bounds.origin.y;
               
               const float movementDuration = 0.3f;
               // tweak as needed
               
               int movement = movementDistance ;
               
               [UIView beginAnimations: @"anim" context: nil];
               [UIView setAnimationBeginsFromCurrentState: YES];
               [UIView setAnimationDuration: movementDuration];
               int mov=tempScrollView.bounds.origin.y + movement;
               [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
               [UIView commitAnimations];
           }

           
           return;
       }
       
       int movementDistance = 0;
              
       if (tempScrollView.bounds.origin.y==0) 
       {
           movementDistance=300;
       }
       else
           movementDistance=300-tempScrollView.bounds.origin.y;
        
       const float movementDuration = 0.3f; // tweak as needed
       
       int movement = movementDistance ;
       
       [UIView beginAnimations: @"anim" context: nil];
       [UIView setAnimationBeginsFromCurrentState: YES];
       [UIView setAnimationDuration: movementDuration];
       int mov=tempScrollView.bounds.origin.y + movement;
       [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
       [UIView commitAnimations];
       
   }
   else if(textField==btnMinAge)
   {       
       [btnMinAge resignFirstResponder];
       tempScrollView.scrollEnabled=NO;
           
       lablDate.enabled=NO;
       lablMonth.enabled=NO;
       lablYear.enabled=NO;
       txtEmail.enabled=NO;
       txtCity.enabled=NO;
       txtRegion.enabled=NO;
       txtCountry.enabled=NO;
       txtConfirmEmail.enabled=NO;
       btnMaxAge.enabled=NO;
       btnMinAge.enabled=NO;
               
       [txtEmail resignFirstResponder];
       [txtConfirmEmail resignFirstResponder];
       indexMinAge = 0;
       flag = 1;
       uiPickerView.hidden = YES;
       uiPickerDayView.hidden = YES;
       uiPickerMonthView.hidden = YES;
           
       uiMaxAgePickerView.hidden = YES;
       uiMinAgePickerView.hidden = NO;
       minAgePicker.hidden = NO;
  
       lblCountry.hidden=NO;
       
       [minAgeArray removeAllObjects];
       
       int maxAge;
       if([maxAgeLabel.text intValue] == 0)
       {
           maxAge = 103;
       }
       else
       {
           maxAge = [maxAgeLabel.text intValue];
       }
              
      
       for (int i = 20; i <= maxAge; i++)
       {
           NSString *myString = [NSString stringWithFormat:@"%d", i];
           [minAgeArray addObject:myString]; 
           [minAgePicker reloadAllComponents];
       }
       
       [minAgePicker reloadAllComponents];
       [minAgePicker selectRow:0 inComponent:0 animated:NO];
       minAgePicker.showsSelectionIndicator = YES;
       
       [txtEmail resignFirstResponder];
       [txtConfirmEmail resignFirstResponder];
       tempScrollView.scrollEnabled=NO;
       
       if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
       {           
           if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft) 
           {
               [uiMinAgePickerView setFrame:CGRectMake(0, 700, 1024, 270)];
               
               int movementDistance = 0;
               if (tempScrollView.bounds.origin.y==0)
               {
                   movementDistance=250;
               }
               else
                   movementDistance=250-tempScrollView.bounds.origin.y;
               
               const float movementDuration = 0.3f; // tweak as needed
               
               int movement = movementDistance ;
               
               [UIView beginAnimations: @"anim" context: nil];
               [UIView setAnimationBeginsFromCurrentState: YES];
               [UIView setAnimationDuration: movementDuration];
               int mov=tempScrollView.bounds.origin.y + movement;
               [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
               [UIView commitAnimations];
           }
           else 
           {               
               [uiMinAgePickerView setFrame:CGRectMake(0, 703, 768, 270)];
           }
           
       }
       else
       {           
           int movementDistance = 0;
                   
           if (tempScrollView.bounds.origin.y==0)
           {
               movementDistance=400;
           }
           else
               movementDistance=413-tempScrollView.bounds.origin.y;
           const float movementDuration = 0.3f; // tweak as needed
           
           int movement = movementDistance ;
           
           [UIView beginAnimations: @"anim" context: nil];
           [UIView setAnimationBeginsFromCurrentState: YES];
           [UIView setAnimationDuration: movementDuration];
           int mov=tempScrollView.bounds.origin.y + movement;
           [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
           [UIView commitAnimations];
           
       }
   }
    
   else if(textField==btnMaxAge)
   {
       
       [btnMaxAge resignFirstResponder];
       tempScrollView.scrollEnabled=NO;
           
       lablDate.enabled=NO;
       lablMonth.enabled=NO;
       lablYear.enabled=NO;
       txtEmail.enabled=NO;
       txtCity.enabled=NO;
       txtRegion.enabled=NO;
       txtCountry.enabled=NO;
       txtConfirmEmail.enabled=NO;
       btnMaxAge.enabled=NO;
       btnMinAge.enabled=NO;
          
       [txtEmail resignFirstResponder];
       [txtConfirmEmail resignFirstResponder];
       indexMaxAge = 0;
       flag = 1;
       uiPickerView.hidden = YES;
       uiPickerDayView.hidden = YES;
       uiPickerMonthView.hidden = YES;
       uiMinAgePickerView.hidden = YES;
       uiMaxAgePickerView.hidden = NO;
       maxAgePicker.hidden = NO;
 
       lblCountry.hidden=NO;
       
       [maxAgeArray removeAllObjects];
       int minAge; 
       if([minAgeLabel.text intValue] == 0)
       {
          
           minAge = 20;
       }
       else
       {
           minAge = [minAgeLabel.text intValue];
       }
      
       for (int i = 103; i >= minAge; i --)
       {   
           NSString *myString = [NSString stringWithFormat:@"%d", i];
           [maxAgeArray addObject:myString]; 
           [maxAgePicker reloadAllComponents];
       }
       
       [maxAgePicker reloadAllComponents];
       [maxAgePicker selectRow:0 inComponent:0 animated:NO];
       maxAgePicker.showsSelectionIndicator = YES;
       
       [txtEmail resignFirstResponder];
       [txtConfirmEmail resignFirstResponder];
       tempScrollView.scrollEnabled=NO;
       
       if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
       {           
           if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft) 
           {
               [uiMaxAgePickerView setFrame:CGRectMake(0, 700, 1024, 270)];
               
               int movementDistance = 0;
               if (tempScrollView.bounds.origin.y==0) 
               {
                   movementDistance=250;
               }
               else
                   movementDistance=250-tempScrollView.bounds.origin.y;
               const float movementDuration = 0.3f; // tweak as needed
               
               int movement = movementDistance ;
               
               [UIView beginAnimations: @"anim" context: nil];
               [UIView setAnimationBeginsFromCurrentState: YES];
               [UIView setAnimationDuration: movementDuration];
               int mov=tempScrollView.bounds.origin.y + movement;
               [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
               [UIView commitAnimations];
           }
           else
           {               
               [uiMaxAgePickerView setFrame:CGRectMake(0, 703, 768, 270)];
           }
           
       }
       else
       {           
           int movementDistance = 0;
                      
           if (tempScrollView.bounds.origin.y==0) 
           {
               movementDistance=400;
           }
           else
               movementDistance=413-tempScrollView.bounds.origin.y;
           const float movementDuration = 0.3f; // tweak as needed
           
           int movement = movementDistance ;
           
           [UIView beginAnimations: @"anim" context: nil];
           [UIView setAnimationBeginsFromCurrentState: YES];
           [UIView setAnimationDuration: movementDuration];
           int mov=tempScrollView.bounds.origin.y + movement;
           [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
           [UIView commitAnimations];
       }
   }
   else if(textField==txtConfirmEmail)
   {
       lablDate.enabled=NO;
       lablMonth.enabled=NO;
       lablYear.enabled=NO;
       txtEmail.enabled=NO;
       txtCity.enabled=NO;
       txtRegion.enabled=NO;
       txtCountry.enabled=NO;
       
       btnMaxAge.enabled=NO;
       btnMinAge.enabled=NO;
        
   }
   else if(textField==txtEmail)
   {
       
       lablDate.enabled=NO;
       lablMonth.enabled=NO;
       lablYear.enabled=NO;
       
       txtCity.enabled=NO;
       txtRegion.enabled=NO;
       txtCountry.enabled=NO;
       txtConfirmEmail.enabled=NO;
       btnMaxAge.enabled=NO;
       btnMinAge.enabled=NO;
       
   }
           
   [self animateTextField: textField up: YES];
    
}


- (IBAction)textFieldDidEndEditing:(UITextField *)textField
{
    tempScrollView.scrollEnabled=YES;
    lablDate.enabled=YES;
    lablMonth.enabled=YES;
    lablYear.enabled=YES;
    txtEmail.enabled=YES;
    txtCity.enabled=YES;
    txtRegion.enabled=YES;
    txtCountry.enabled=YES;
    txtConfirmEmail.enabled=YES;
    btnMaxAge.enabled=YES;
    btnMinAge.enabled=YES;
    
}

- (void) animateTextField: (UITextField*) textField up: (BOOL) up
{    
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
    { 
        
        if (self.interfaceOrientation==UIDeviceOrientationLandscapeRight || self.interfaceOrientation==UIDeviceOrientationLandscapeLeft) 
        {
            
            if ((textField==txtEmail)||(textField==txtConfirmEmail)) 
            {
                
                if (tempScrollView.bounds.origin.y>700) 
                {                    
                    return;
                }
                int movementDistance = 0;
                if (tempScrollView.bounds.origin.y==0)
                {                    
                    movementDistance=200;
                }
                else
                {
                    movementDistance=200-tempScrollView.bounds.origin.y;
                    
                }
                const float movementDuration = 0.3f; // tweak as needed
                
                int movement = movementDistance ;
                
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                int mov=tempScrollView.bounds.origin.y + movement;
                [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
                [UIView commitAnimations];
                
            }
            else if (textField==txtRegion) 
            {
                        int movementDistance = 0;
                        
                        if (tempScrollView.bounds.origin.y==0) 
                        {
                            movementDistance=470;
                        }
                        else
                            movementDistance=470-tempScrollView.bounds.origin.y;
                        
                        const float movementDuration = 0.3f;
                        // tweak as needed
                        
                        int movement = movementDistance ;
                        
                        [UIView beginAnimations: @"anim" context: nil];
                        [UIView setAnimationBeginsFromCurrentState: YES];
                        [UIView setAnimationDuration: movementDuration];
                        int mov=tempScrollView.bounds.origin.y + movement;
                        [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
                        [UIView commitAnimations];
                    
                
        }
            else
            {
                if (tempScrollView.bounds.origin.y>700)
                {
                    return;
                }
                int movementDistance = 0;
                
                if (tempScrollView.bounds.origin.y==0)
                {                    
                    movementDistance=250;
                }
                else
                {
                    movementDistance=250-tempScrollView.bounds.origin.y;
                }
                
                const float movementDuration = 0.3f; // tweak as needed
                int movement = movementDistance ;
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                int mov=tempScrollView.bounds.origin.y + movement;
                [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
                [UIView commitAnimations];
                
                return;
                
            }
        }
        else
        {  
            if ((textField==txtEmail)||(textField==txtConfirmEmail)) 
            {
                
            }
            else if (textField==txtCountry) 
            {
                if (tempScrollView.bounds.origin.y>700)
                {                    
                    return;
                }
                
                int movementDistance = 0;
                if (tempScrollView.bounds.origin.y==0)
                {
                    movementDistance=0;
                    
                }
                else
                {
                    movementDistance=160-tempScrollView.bounds.origin.y;
                }
                const float movementDuration = 0.3f; // tweak as needed
                int movement = movementDistance ;
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                int mov=tempScrollView.bounds.origin.y + movement;
                [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
                [UIView commitAnimations];
                
                return;
                
                
                
            }
            else if(textField==txtRegion)
            {
                            
                    int movementDistance = 0;
                    
                    if (tempScrollView.bounds.origin.y==0)
                    {
                        movementDistance=210;
                    }
                    else
                        movementDistance=210-tempScrollView.bounds.origin.y;
                    
                    const float movementDuration = 0.3f;
                    // tweak as needed
                    
                    int movement = movementDistance ;
                    
                    [UIView beginAnimations: @"anim" context: nil];
                    [UIView setAnimationBeginsFromCurrentState: YES];
                    [UIView setAnimationDuration: movementDuration];
                    int mov=tempScrollView.bounds.origin.y + movement;
                    [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
                    [UIView commitAnimations];              
 
            }
            else
            {
                if (tempScrollView.bounds.origin.y>700)
                {                    
                    return;
                }
                
                int movementDistance = 0;
                if (tempScrollView.bounds.origin.y==0)
                {
                    movementDistance=0;
                    
                }
                else
                {
                    movementDistance=0-tempScrollView.bounds.origin.y;
                }
                const float movementDuration = 0.3f; // tweak as needed
                int movement = movementDistance ;
                [UIView beginAnimations: @"anim" context: nil];
                [UIView setAnimationBeginsFromCurrentState: YES];
                [UIView setAnimationDuration: movementDuration];
                int mov=tempScrollView.bounds.origin.y + movement;
                [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
                [UIView commitAnimations];
                return;
                
            }
        }
    } 
    else
    {  
        if (textField==txtCity) 
        {            
            if (tempScrollView.bounds.origin.y>700)
            {
                return;
            }
            
            int movementDistance = 0;
            if (tempScrollView.bounds.origin.y==0) 
            {
                movementDistance=775;
            }
            else
                movementDistance=775-tempScrollView.bounds.origin.y;
            const float movementDuration = 0.3f; // tweak as needed
            
            int movement = (up ? movementDistance : -movementDistance);
            
            [UIView beginAnimations: @"anim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: movementDuration];
            int mov=tempScrollView.bounds.origin.y + movement;
            [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
            [UIView commitAnimations];
        }
        else
        {
            if (tempScrollView.bounds.origin.y>150) 
            {
                return;
            }
            
            int movementDistance = 0;
            if (tempScrollView.bounds.origin.y==0) 
            {
                movementDistance=170;
            }
            else
                movementDistance=170-tempScrollView.bounds.origin.y;
            
            const float movementDuration = 0.3f; // tweak as needed
            int movement = (up ? movementDistance : -movementDistance);
            
            [UIView beginAnimations: @"anim" context: nil];
            [UIView setAnimationBeginsFromCurrentState: YES];
            [UIView setAnimationDuration: movementDuration];
            int mov=tempScrollView.bounds.origin.y + movement;
            [tempScrollView setContentOffset:CGPointMake(0,mov) animated:YES];
            [UIView commitAnimations];
        }
    }
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField
{      
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{           
    uiPickerView.hidden = YES;
    uiPickerDayView.hidden = YES;
    uiPickerMonthView.hidden = YES;
    uiMaxAgePickerView.hidden = YES;
    uiMinAgePickerView.hidden = YES;
    minAgePicker.hidden = YES;
    maxAgePicker.hidden = YES;
      
    monthPickerView.hidden = YES;
    dayPickerView.hidden = YES;
    yearPickerView.hidden = YES;
    
    btnMinAge.hidden = NO;
    btnMaxAge.hidden =  NO;
    minAgeLabel.hidden = NO;
    maxAgeLabel.hidden = NO;
    tempScrollView.scrollEnabled=YES;
        
    return YES;
}


@end
