//
//  SignUPSecondView.h
//  Chk
//
//  Created by SODTechnologies on 29/08/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Structures.h"
#import <QuartzCore/QuartzCore.h>
#import "JSWaiter.h"
#import "JSWebManager.h"

@class HomeView;
@class SignUPFirstView;
@class TermsOfUse;

 
@interface SignUPSecondView : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate,NSXMLParserDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate> 
{
                   
    NSInteger indexMinAge;
    NSInteger indexMaxAge;
    NSInteger flag;
    
    NSInteger indexMonthRange;
    NSInteger indexDayRange;
    NSInteger indexYearRange;
    NSXMLParser *rssParser;
    NSString *strIpStorage;
    NSString *countryCodeSelected;
    NSString *username;
    NSString *password;
    NSString *encryptedPass;
    NSString *month;
    //NSString *siteSALT;
    NSString *domain;
    NSString *strPswStore;
    NSString *selectedCountryId;
    NSString *selectedRegionId;
    NSString *selectedCityId;
    NSString *strCityCodeStore;
    NSString *strSelectedZipStore;   
    NSString *urlReqRegion;
    NSString *countryId;
    NSString *countryName;
    
    NSInteger currentYear;
    NSInteger indexCountry;
    NSInteger indexState;
    NSInteger indexCity;
    NSUInteger leapYear;
    
    NSMutableArray *countrynamesArray;
    NSMutableArray *countryCodeArray;
    NSMutableArray *monthArrayNo;
    NSMutableArray *dateArrayNo;
    NSMutableArray *yearArrayNo;
    NSMutableArray *stateNamesArray;
    NSMutableArray *stateCodeArray;
    NSMutableArray *cityNamesArray;
    NSMutableArray *cityCodeArray;
    NSMutableArray *zipNamesArray;
    NSMutableArray *zipCodeArray;
    NSMutableArray *minAgeArray;
	NSMutableArray *maxAgeArray;

    BOOL countryCodeFound;
    BOOL countryNameFound;
    BOOL boolUs;
    BOOL countrySelected;
    BOOL regionSelected;
    BOOL citySelected;
    BOOL displayKeyboard;
    BOOL iamMaleBtnClicked;
    BOOL iamFemaleBtnCLicked;
    BOOL iamCoupleBtnClicked;
    BOOL iamGroupBtnClicked;
    BOOL lfMaleBtnClicked;
    BOOL lfFemaleBtnCLicked;
    BOOL lfCoupleBtnClicked;
    BOOL lfGroupBtnClicked;
    BOOL iamAdult;
    BOOL termsOfUSe;
    BOOL isSignUP;
    BOOL tablestate;
    BOOL sta,cit;
    BOOL isStateCountZero;
    BOOL isCityCountZero;
    
    CGPoint  offset;
    
    IBOutlet UILabel *selectedCountryLbl;
    IBOutlet UILabel *selectedRegionLbl;
    IBOutlet UILabel *selectedCityLbl;
  
    IBOutlet UILabel *lblCountry;
    IBOutlet UILabel *lblRegion;
    IBOutlet UILabel *lblCity;
  
    IBOutlet UITextField *txtCity;
    IBOutlet UITextField *txtEmail;
    IBOutlet UITextField *txtConfirmEmail;
 
    IBOutlet UIPickerView *minAgePicker;
    IBOutlet UIPickerView *maxAgePicker;
    IBOutlet UIPickerView *monthPickerView;
    IBOutlet UIPickerView *dayPickerView;
    IBOutlet UIPickerView *yearPickerView;
    IBOutlet UILabel *yearLabel;
    IBOutlet UILabel *monthLabel;
    IBOutlet UILabel *dayLabel;
    IBOutlet UILabel *minAgeLabel;
    IBOutlet UILabel *maxAgeLabel;
 
    IBOutlet UIView *uiPickerView;
    IBOutlet UIView *uiPickerDayView;
    IBOutlet UIView *uiPickerMonthView;
    IBOutlet UIView *uiMinAgePickerView;
    IBOutlet UIView *uiMaxAgePickerView;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UILabel *signuplab;
    IBOutlet UILabel *yourvalidlab;
    IBOutlet UILabel *conformmaillab;
    IBOutlet UILabel *lblFrom;
    IBOutlet UILabel *lblTo;
    IBOutlet UILabel *lblYearsOld;
    IBOutlet UILabel *lblAdult;
    IBOutlet UILabel *lblAgreeTerms;

    IBOutlet UIImageView *imgBGIam;
    IBOutlet UIImageView *imgBGLookingFor;
    IBOutlet UIImageView *imgBGEmail;
    IBOutlet UIImageView *imgBGDOB;
    IBOutlet UIImageView *imgBGMatchAge;
    IBOutlet UIImageView *imgBGCountry;
    IBOutlet UIImageView *imgBGCheckboxes;
 
    IBOutlet UIScrollView *tempScrollView;
    IBOutlet UIButton *btnTOU;
    IBOutlet UIButton *btnMale;
    IBOutlet UIButton *btnFemale;
    IBOutlet UIButton *btnCouple;
    IBOutlet UIButton *btnGroup;
    IBOutlet UIButton *btnLFMale;
    IBOutlet UIButton *btnLFFemale;
    IBOutlet UIButton *btnLFCouple;
    IBOutlet UIButton *btnLFGroup;
    IBOutlet UIButton *btnTerms;
    IBOutlet UIButton *btnback;
    IBOutlet UIButton *btnIamAdult;
    IBOutlet UIButton *btnSignUp;

    SignUPFirstView *signUpView;
    HomeView *homeScreenView;
    TermsOfUse *touView;
    SignInResp respSignIn;
    
    UIImage *imgMale;
    UIImage *imgMaleClicked;
    UIImage *imgFemale;
    UIImage *imgFemaleClicked;
    UIImage *imgCouple;
    UIImage *imgCoupleClicked;
    UIImage *imgGroup;
    UIImage *imgGroupClicked;
    UIImage *imgChecked;
    UIImage *imgUnChecked;
            
    UILabel *lblIam;
    UILabel *lblLookingFor;
    UILabel *lblDateOfBirth;
    UILabel *lblMatchAge;
       
    float NewXval;
      
}

@property (retain, nonatomic) IBOutlet UIView *uiCountryPickerView;
@property (retain, nonatomic) IBOutlet UIView *uiStatePickerView;
@property (retain, nonatomic) IBOutlet UIView *uiCityPickerView;
@property (retain, nonatomic) IBOutlet UIPickerView *countryPicker;
@property (retain, nonatomic) IBOutlet UIPickerView *statePicker;
@property (retain, nonatomic) IBOutlet UIPickerView *cityPicker;
@property (retain, nonatomic) IBOutlet UISegmentedControl *segmentControlCountry;
@property (retain, nonatomic) IBOutlet UISegmentedControl *segmentControlState;
@property (retain, nonatomic) IBOutlet UISegmentedControl *segmentControlCity;
@property (retain, nonatomic) IBOutlet UITextField *txtRegion;
@property (retain, nonatomic) IBOutlet UITextField *txtCountry;
@property (nonatomic, retain) IBOutlet UITextField *txtCity;
@property (nonatomic, retain) IBOutlet UILabel *selectedCountryLbl;

@property (nonatomic, retain) IBOutlet UILabel *selectedCityLbl;
@property (nonatomic, retain) IBOutlet UILabel *selectedRegionLbl;
@property (nonatomic, retain) IBOutlet UILabel *lblCountry;
@property (nonatomic, retain) IBOutlet UILabel *lblRegion;
@property (nonatomic, retain) IBOutlet UILabel *lblCity;

@property (nonatomic, retain) IBOutlet UIButton *btnTOU;
@property (nonatomic, retain) IBOutlet UIScrollView *tempScrollView;
@property (nonatomic, retain) IBOutlet UIPickerView *minAgePicker;
@property (nonatomic, retain) IBOutlet UIPickerView *maxAgePicker;
@property (nonatomic, retain) IBOutlet UIPickerView *monthPickerView;
@property (nonatomic, retain) IBOutlet UIPickerView *dayPickerView;
@property (nonatomic, retain) IBOutlet UIPickerView *yearPickerView;
@property (retain, nonatomic) IBOutlet UITextField *lablMonth;
@property (retain, nonatomic) IBOutlet UITextField *lablDate;
@property (retain, nonatomic) IBOutlet UITextField *lablYear;
@property (retain, nonatomic) IBOutlet UITextField *btnMinAge;
@property (retain, nonatomic) IBOutlet UITextField *btnMaxAge;
@property (nonatomic, retain) IBOutlet UIView *uiPickerView;
@property (nonatomic, retain) IBOutlet UIView *uiPickerDayView;
@property (nonatomic, retain) IBOutlet UIView *uiPickerMonthView;
@property (nonatomic, retain) IBOutlet UILabel *yearLabel;
@property (nonatomic, retain) IBOutlet UILabel *monthLabel;
@property (nonatomic, retain) IBOutlet UILabel *dayLabel;
@property (nonatomic, retain) IBOutlet UILabel *minAgeLabel;
@property (nonatomic, retain) IBOutlet UILabel *maxAgeLabel;
@property (nonatomic, retain) IBOutlet UILabel *lblFrom;
@property (nonatomic, retain) IBOutlet UILabel *lblTo;
@property (nonatomic, retain) IBOutlet UILabel *lblYearsOld;
@property (nonatomic, retain) IBOutlet UIView *uiMinAgePickerView;
@property (nonatomic, retain) IBOutlet UIView *uiMaxAgePickerView;
@property (nonatomic, retain) IBOutlet UILabel *lblAdult;
@property (nonatomic, retain) IBOutlet UILabel *lblAgreeTerms;
@property (nonatomic, retain) IBOutlet UIButton *btnTerms;
@property (nonatomic, retain) IBOutlet UIImageView *imgBGIam;
@property (nonatomic, retain) IBOutlet UIImageView *imgBGLookingFor;
@property (nonatomic, retain) IBOutlet UIImageView *imgBGEmail;
@property (nonatomic, retain) IBOutlet UIImageView *imgBGDOB;
@property (nonatomic, retain) IBOutlet UIImageView *imgBGMatchAge;
@property (nonatomic, retain) IBOutlet UIImageView *imgBGCountry;
@property (nonatomic, retain) IBOutlet UIImageView *imgBGCheckboxes;
@property (retain, nonatomic) IBOutlet UIButton *btnback;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentCtrlMonth;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentCtrlDate;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentCtrlYear;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentCtrlMinAge;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentCtrlMaxAge;
@property (nonatomic, retain) IBOutlet UIButton *btnIamAdult;
@property (nonatomic, retain) IBOutlet UIButton *btnSignUp;



@property (nonatomic, retain) NSString *strIpStorage;
@property (nonatomic, retain) NSString *strSelectedZipStore;
@property (nonatomic, retain) NSString *strCityCodeStore;
@property (nonatomic, retain) NSString *strPswStore;
@property (nonatomic, retain) NSString *countryId;
@property (nonatomic, retain) NSString *countryName;
@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *password;
@property (nonatomic, retain) NSString *encryptedPass;
@property (nonatomic, retain) NSString *month;
//@property (nonatomic, retain) NSString *siteSALT;
@property (nonatomic, retain) NSString *domain;

@property (nonatomic, retain) NSMutableArray *zipNamesArray;
@property (nonatomic, retain) NSMutableArray *minAgeArray;
@property (nonatomic, retain) NSMutableArray *maxAgeArray;
@property (nonatomic, retain) NSMutableArray *zipCodeArray;
@property (nonatomic, assign) NSMutableArray *cityNamesArray;
@property (nonatomic, retain) NSMutableArray *countrynamesArray;
@property (nonatomic, retain) NSMutableArray *countryCodeArray;


@property (nonatomic, retain) UILabel *lblIam;
@property (nonatomic, retain) UILabel *lblLookingFor;
@property (nonatomic, retain) UILabel *lblDateOfBirth;
@property (nonatomic, retain) UILabel *lblMatchAge;
@property (nonatomic, retain) UITextField *txtEmail;
@property (nonatomic, retain) UITextField *txtConfirmEmail;

@property (nonatomic, assign) BOOL isSignUP;

@property (nonatomic, retain) SignUPFirstView *signUpView; 
@property (nonatomic, retain) HomeView *homeScreenView;
@property (nonatomic, retain) TermsOfUse *touView;

@property (nonatomic,assign)float NewXval;


- (IBAction)clickedCountrySegCntrl:(id)sender;
- (IBAction)countryAutofill:(id)sender;
- (IBAction)countryPickerDone:(id)sender;
- (IBAction)clickedCitySegCntrl:(id)sender;
- (IBAction)cityAutofill:(id)sender;
- (IBAction)cityPickerDone:(id)sender;
- (IBAction)clickedStateSegCntrl:(id)sender;
- (IBAction)stateAutofill:(id)sender;
- (IBAction)statePickerDone:(id)sender;
- (IBAction)clickedSignUpButton:(id)sender;
- (IBAction)textFieldDidBeginEditing:(UITextField *)textField;
- (IBAction)textFieldDidEndEditing:(UITextField *)textField;
- (IBAction)clickedSegCtrlDOB:(id)sender;
- (IBAction)clickedSegCtrlDay:(id)sender;
- (IBAction)clickedSegCtrlMonth:(id)sender;
- (IBAction)datePickerDone:(id)sender;
- (IBAction)minAgePickerDone:(id)sender;
- (IBAction)maxAgePickerDone:(id)sender;

- (IBAction)clickedSegCtrlMinAge;
- (IBAction)clickedSegCtrlMaxAge;


- (IBAction)monthAutoFill:(id)sender;
- (IBAction)dayAutoFill:(id)sender;
- (IBAction)yearAutoFill:(id)sender;

- (IBAction)yearPickerDoneButton:(id)sender;


- (IBAction)minAgeAutoFill:(id)sender;
- (IBAction)maxAgeAutoFill:(id)sender;
- (IBAction)iamBtnsClicked:(UIButton *)button;
- (IBAction)lookingForBtnsClicked:(UIButton *)button;
- (IBAction)iamAdultChkBox:(UIButton *)button;
- (IBAction)termsOfUseChkBox:(UIButton *)button;
- (IBAction)clickedTermsOfUseButton:(UIButton *)button;
- (IBAction)clickedBackButton:(UIButton *)button;
- (BOOL) validateEmailWithString:(NSString*)email;


-(void)orientationForIpad;
- (void) animateTextField:(UITextField*) textField up: (BOOL) up;
- (NSString *)stringToSha1:(NSString *)str;

@end
