//
//  SearchMembersView.h
//
//
//  Created by SODTechnologies on 12/09/11.
//  Copyright 2011 Solutions On Demand Australasia Pty Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Structures.h"
#import <QuartzCore/QuartzCore.h>
#define tableRowHeight 30.0
#define tableViewHeight 180.0

@interface SearchMembersView : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate,NSXMLParserDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate>
{
         
    IBOutlet UILabel *lblCity;
    IBOutlet UITextField *txtCity;
    IBOutlet UILabel *selectedCountryLbl;
    IBOutlet UILabel *selectedRegionLbl;
    IBOutlet UILabel *selectedCityLbl;
    IBOutlet UIScrollView *scrollsearchedMembers;
    IBOutlet UIPickerView *minAgePicker;
    IBOutlet UIPickerView *maxAgePicker;
    IBOutlet UIView *uiMinAgePickerView;
    IBOutlet UIView *uiMaxAgePickerView;
    IBOutlet UILabel *minAgeLabel;
    IBOutlet UILabel *maxAgeLabel;
    IBOutlet UITextField *milesFrom;
    IBOutlet UITextField *zipCode;
    IBOutlet UIButton *btnSearch;
    IBOutlet UIButton *btnHome;
    IBOutlet UIButton *btnMale;
    IBOutlet UIButton *btnFemale;
    IBOutlet UIButton *btnCouple;
    IBOutlet UIButton *btnGroup;
    IBOutlet UIButton *btnLFMale;
    IBOutlet UIButton *btnLFFemale;
    IBOutlet UIButton *btnLFCouple;
    IBOutlet UIButton *btnLFGroup;
    IBOutlet UILabel *lblOnlineOnly;
    IBOutlet UILabel *lblWithPhotoOnly;
    IBOutlet UIButton *btnOnlineOnly;
    IBOutlet UIButton *btnWithPhotoOnly;
    IBOutlet UISegmentedControl *control;
    IBOutlet UINavigationBar *navBar;
    IBOutlet UILabel *searchmemberlab;
    IBOutlet UIImageView *imgBGIam;
    IBOutlet UIImageView *imgBGLookingFor;
    IBOutlet UIImageView *imgBGAge;
    IBOutlet UIImageView *imgBGCheckboxes;
    IBOutlet UILabel *lblFrom;
    IBOutlet UILabel *lblTo;
    IBOutlet UILabel *lblYearsOld;
    IBOutlet UILabel *lblMilesFrom;
    IBOutlet UILabel *lblZip;

    
    BOOL countryCodeFound;
    BOOL countryNameFound;
    BOOL boolUs;
    BOOL sta,cit;
    
    NSXMLParser *rssParser;
    NSInteger indexMinAge;
    NSInteger indexMaxAge;
    NSInteger indexCountry;
    NSInteger indexState;
    NSInteger indexCity;
    NSInteger index;
    NSInteger flag;
    NSString *domain;
    NSString *urlReqRegion;
    NSString *countryId;
    NSString *countryName;
    NSString *selectedCountryId;
    NSString *selectedRegionId;
    NSString *selectedCityId;
    NSString *strCityCodeStore;
    NSString *strSelectedZipStore;
    
    NSMutableArray *countrynamesArray;
    NSMutableArray *countryCodeArray;
    NSMutableArray *stateNamesArray;
    NSMutableArray *stateCodeArray;
    NSMutableArray *cityNamesArray;
    NSMutableArray *cityCodeArray;
    NSMutableArray *zipNamesArray;
    NSMutableArray *zipCodeArray;
    NSMutableArray *minAgeArray;
	NSMutableArray *maxAgeArray;
            
	CGPoint  offset;
      
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
    BOOL onlineOnly;
    BOOL withPhotoOnly; 
    
    BOOL isStateCountZero;
    BOOL isCityCountZero;
           
    int fromView;
    float NewXval;
}

@property (nonatomic, retain) IBOutlet UITextField *milesFrom;
@property (nonatomic, retain) IBOutlet UITextField *zipCode;
@property (retain, nonatomic) IBOutlet UIImageView *countryback;
@property (nonatomic, retain) IBOutlet UISegmentedControl *control;
@property (nonatomic, retain) IBOutlet UIView *uiMinAgePickerView;
@property (nonatomic, retain) IBOutlet UIView *uiMaxAgePickerView;
@property (retain, nonatomic) IBOutlet UIView *uiCountryPickerView;
@property (retain, nonatomic) IBOutlet UIView *uiStatePickerView;
@property (retain, nonatomic) IBOutlet UIView *uiCityPickerView;
@property (retain, nonatomic) IBOutlet UIPickerView *countryPicker;
@property (retain, nonatomic) IBOutlet UIPickerView *statePicker;
@property (retain, nonatomic) IBOutlet UIPickerView *cityPicker;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentCtrlMinAge;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentCtrlMaxAge;
@property (nonatomic, retain) IBOutlet UIImageView *imgBGIam;
@property (nonatomic, retain) IBOutlet UIImageView *imgBGLookingFor;
@property (nonatomic, retain) IBOutlet UIImageView *imgBGAge;
@property (nonatomic, retain) IBOutlet UIImageView *imgBGCheckboxes;
@property (nonatomic, retain) IBOutlet UILabel *lblFrom;
@property (nonatomic, retain) IBOutlet UILabel *lblTo;
@property (nonatomic, retain) IBOutlet UILabel *lblYearsOld;
@property (nonatomic, retain) IBOutlet UILabel *lblMilesFrom;
@property (nonatomic, retain) IBOutlet UILabel *lblZip;
@property (nonatomic, retain) IBOutlet UILabel *lblOnlineOnly;
@property (retain, nonatomic) IBOutlet UITextField *btnMinAge;
@property (retain, nonatomic) IBOutlet UITextField *btnMaxAge;
@property (retain, nonatomic) IBOutlet UILabel *lblcontry;
@property (retain, nonatomic) IBOutlet UISegmentedControl *segmentControlCountry;
@property (retain, nonatomic) IBOutlet UISegmentedControl *segmentControlState;
@property (retain, nonatomic) IBOutlet UISegmentedControl *segmentControlCity;
@property (nonatomic, retain) IBOutlet UILabel *selectedCountryLbl;
@property (nonatomic, retain) IBOutlet UILabel *selectedCityLbl;
@property (nonatomic, retain) IBOutlet UILabel *selectedRegionLbl;
@property (retain, nonatomic) IBOutlet UITextField *stateTxtField;
@property (nonatomic, retain) IBOutlet UILabel *lblCity;
@property (nonatomic, retain) IBOutlet UIButton *btnHome;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollsearchedMembers;
@property (nonatomic, retain) IBOutlet UIButton *btnSearch;
@property (nonatomic, retain) IBOutlet UIPickerView *minAgePicker;
@property (nonatomic, retain) IBOutlet UIPickerView *maxAgePicker;
@property (nonatomic, retain) IBOutlet UILabel *minAgeLabel;
@property (nonatomic, retain) IBOutlet UILabel *maxAgeLabel;
@property (retain, nonatomic) IBOutlet UITextField *countryTxtField;
@property (retain, nonatomic) IBOutlet UILabel *lblsta;
@property (nonatomic, retain) IBOutlet UITextField *txtCity;

@property (nonatomic) int fromView;

@property (nonatomic, retain) NSString *strSelectedZipStore;
@property (nonatomic, retain) NSString *strCityCodeStore;
@property (nonatomic, retain) NSString *strPswStore;
@property (nonatomic, retain) NSString *countryId;
@property (nonatomic, retain) NSString *countryName;
@property(nonatomic,  retain) NSString *domain;

@property (nonatomic, retain) NSMutableArray *minAgeArray;
@property (nonatomic, retain) NSMutableArray *maxAgeArray;
@property (nonatomic, retain) NSMutableArray *countrynamesArray;
@property (nonatomic, retain) NSMutableArray *countryCodeArray;
@property (nonatomic, assign) NSMutableArray *cityNamesArray;

@property (nonatomic,assign)float NewXval;

- (IBAction)countryTextEdited:(id)sender;
- (IBAction)countryPickerDone:(id)sender;
- (IBAction)statePickerDone:(id)sender;
- (IBAction)cityPickerDone:(id)sender;
- (IBAction)clickedHomeButton:(id) sender;
- (IBAction)clickedIamButton:(UIButton *)button;
- (IBAction)clickedLookingForButton:(UIButton *)button;
- (IBAction)textFieldDidBeginEditing:(UITextField *)textField;
- (IBAction)textFieldDidEndEditing:(UITextField *)textField;
- (IBAction)clickedOnlineOnly:(UIButton *)button;
- (IBAction)clickedWithPhotoOnly:(UIButton *)button;
- (IBAction)clickedSegmentContol; 
- (IBAction)clickedSegCtrlMinAge;
- (IBAction)clickedSegCtrlMaxAge;
- (IBAction)minAgePickerDone:(id)sender;
- (IBAction)maxAgePickerDone:(id)sender;
- (IBAction)minAgeAutoFill:(id)sender;
- (IBAction)maxAgeAutoFill:(id)sender;
- (IBAction)countryAutoFill:(id)sender;
- (IBAction)stateAutofill:(id)sender;
- (IBAction)cityAutoFill:(id)sender;
- (IBAction)clickedSegCtrlCountry:(id)sender;
- (IBAction)clickedSegCtrlState:(id)sender;
- (IBAction)clickedSegCtrlCity:(id)sender;

-(void) animateTextField:(UITextField*) textField up: (BOOL) up;

-(void) orientationForIpad;

@end
