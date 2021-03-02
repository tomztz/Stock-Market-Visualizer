//Stocks Project by Theo Stephens Kehoe, Cian Doyle and Tianze Zhang. 
//Main tab shows all global variables (below), the mouse interactions, main draw method and
//some general functions. 
//The main parts of the program are separated into different tabs - intialisation, mouse_iteractions and screen. 
//--------------------------------------------------
//Tabs explanation: 
//Intialisation: contains all intialisation functions - these functions simply create the widgets for the various screens and some input such as the bar chart.
//Mouse_Iteractions: contains all the mousePressed() iteractions with the buttons - uses switch statements for the widget events. These functions are called in the mousePressed() function below. 
//Classes: 
//Buttons - Contains all button classes and their functionalities. 
//TextWidget - Contains all the text widget classes and their functionalities. 
//-
//Data - This class contains the main data array list containing all the DataPoint objects representing the data sheet. It also contains search functions and extraction functions. 
//DataPoint - The class representing a stock's values at a certain date. 
//Stocks - This class contains the main stocks array list, which contains all the SingleStock objects representing the stocks.csv file. It also contains search functions and extraction functions. 
//SingleStock - Similar to the DataPoint class, this class represents a 'single' stock's details (i.e its name, sector, industry, exchange etc). 
//Screen - This class represents a given screen displayed to the user. It is has button widgets and text widgets, amoung other attributes. 
//CompanyScroller - This class is the scrolling text box seen in the bar chart and screen chart, containing the stock details of the companies present in the data sheet. 
//CompanyViewer - This class is the company buttons page seen on the right side of the Company Viewer page. It contains a button array list and a SingleStocks array list. 
//CompanyPage - This class takes in a company's name and displays a bunch of statistics on that company, if it is present in the data sheet. It is seen in the left hand side of the Company Viewer Page and is connected 
//to the CompanyViewer class. 
//Queries - This class contains a multitude of functions that perform calculations on the DataPoint array lists that are passed through it. 
//BarChart - This class represents a drawn bar chart. It takes in a DataPoint array list, a date, and the specified data to be shown.
//LineChart - This class represents a drawn line chart. It takes in a DataPoint array list, a start & end date, and the specified data to be shown. 
//--------------------------------------------------
import java.util.*;  
//Loading string arrays (for loading in the files).
String[] loadData; 
String[] loadStocksData; 
//Button/Text Events 
final int EVENT_BARCHART=1;
final int EVENT_LINECHART=2; 
final int EVENT_TEXT=5;
final int EVENT_BUTTON=6;
final int EVENT_NULL=0;
//Company viewer events
final int EVENT_HEALTHCARE = 61; 
final int EVENT_TECHNOLOGY = 62; 
final int EVENT_FINANCE = 63; 
final int EVENT_ENERGY = 64; 
final int EVENT_CONSUMERSERVICES = 65; 
final int EVENT_TRANSPORTATION = 66; 
final int EVENT_CAPITALGOODS = 67;
final int EVENT_BASICINDUSTRIES = 68; 
final int EVENT_NOSECTOR = 69; 
final int EVENT_ALL = 70; 
final int EVENT_SHEET = 71;
//Screen Events
int currentScreen;
final int SCREEN_MAIN1 = 100; 
final int SCREEN_BARCHART=101; 
final int SCREEN_BARCHARTDRAW=102;
final int SCREEN_COMPANYVIEWER=103; 
final int SCREEN_LINECHART=104; 
final int SCREEN_LINECHARTDRAW = 105;
//Amount of ticker entries allowed (just for bar chart screen). 
int textEntriesAllowed = 9;
//companyViewerCompanyCoordinates
ArrayList<Float> xPositions = new ArrayList();
ArrayList<Float> yPositions = new ArrayList();
ArrayList<Float> xPositionsOfSectors = new ArrayList();
ArrayList<Float> yPositionsOfSectors = new ArrayList();
ArrayList<SingleStock> drawDataPoints = new ArrayList();
ArrayList<String> sectors = new ArrayList();
int companyViewerCounter = 0;
boolean ending = true;
//Color values (for general purpose). 
color backgroundColor = #B5D3E7; 
color pink = #FF8BE6; //PINK
color lightPink = #F2B7E6;
color green = #4DFF78; //GREEN
color red = #FF3B3B;   //RED
//Button Events:
final int OPENING_PRICE = 50;
final int CLOSING_PRICE = 51;
final int VOLUME = 52; 
final int ADJUSTED_CLOSE = 53; 
final int LOW = 54;
final int HIGH = 55;
final int VOLATILITY = 56; 
//Fonts used
PFont defaultFont;
PFont titleFont; 
//Image Loading 
PImage backImage;
PImage mainIcon; 
PImage barChartIcon;
PImage lineChartIcon; 
//System Messages
String globalMsg = "";
// 
Data       theData;       //This is where our entire data set is being loaded into. 
Stocks      theStocks;    //This is where our stocks data are being loaded into. 
DataPoint[] dataToDisplay; //A DataPoint array that stores the DataPoints that are going to display [barchart]. 
Screen     barChartScreen;  //Screens + charts below
Screen     lineChartScreen; 
Screen     mainScreen;
Screen     companyScreen;
BarChart     barChart;
CompanyViewer theCompanyViewer;
CompanyPage   theCompanyPage; 
LineChart   lineChart; 
//Focus text widgets & buttons.
TextWidget focusText;    
Widget     focusButton; 
CompanyScroller focusScroller;
Queries   queries;        //Query class (contains all queries usable by user).
DateIteration dateIterator;
Date date; 
//Array List containing the stocks present in the data sheet being loaded into. 
//(Used for error handling and the company scroller).
ArrayList<SingleStock> stocksInDataSheet; 
//Sectors ArrayLists (for filtering). ------- NOTE: Every sector has a 'Sheet' counterpart - these arraylists contain the companies in the data sheet
ArrayList<SingleStock> healthCare;               // that are apart of the sector, oppose to containing all companies in the sector. 
ArrayList<SingleStock> technology; 
ArrayList<SingleStock> finance; 
ArrayList<SingleStock> consumerServices; 
ArrayList<SingleStock> energy; 
ArrayList<SingleStock> transportation; 
ArrayList<SingleStock> capitalGoods; 
ArrayList<SingleStock> basicIndustries; 
//------------------------------------------------------------------------------
//Sets up all main objects/classes. 
void setup()
{
  //Screen intialisation. 
  mainScreen = new Screen(backgroundColor, SCREEN_MAIN1, null, 0);
  barChartScreen= new Screen(backgroundColor, SCREEN_BARCHART, new BackButton(SCREEN_MAIN1), 8); 
  lineChartScreen = new Screen(backgroundColor, SCREEN_LINECHART, new BackButton(SCREEN_MAIN1), 3); 
  companyScreen = new Screen(backgroundColor, SCREEN_COMPANYVIEWER, new BackButton(SCREEN_MAIN1), 1);
  currentScreen = SCREEN_MAIN1; 
  //Screen sizeing & colouring
  size(1500, 1000);
  background(#B5D3E7); 
  //Data Loading. 
  loadData = loadStrings("daily_prices100k-Janis.csv"); 
  loadStocksData = loadStrings("stocks.csv");
  theStocks = new Stocks(loadStocksData); 
  theData = new Data(loadData);
  //CompanyViewerLoading Cian Doyle
  fillSectorArrayList();
  stocksInDataSheet = theStocks.getStocksInDataSheet(theData.dataArray);
  theCompanyPage = new CompanyPage(); 
  theCompanyViewer = new CompanyViewer(stocksInDataSheet); 
  //Sector loading 
  healthCare = theStocks.extractCompaniesFromSector("HEALTH CARE");
  technology = theStocks.extractCompaniesFromSector("TECHNOLOGY"); 
  finance = theStocks.extractCompaniesFromSector("FINANCE"); 
  consumerServices = theStocks.extractCompaniesFromSector("CONSUMER SERVICES");
  energy = theStocks.extractCompaniesFromSector("ENERGY");
  transportation = theStocks.extractCompaniesFromSector("TRANSPORTATION"); 
  capitalGoods = theStocks.extractCompaniesFromSector("CAPITAL GOODS"); 
  basicIndustries = theStocks.extractCompaniesFromSector("BASIC INDUSTRIES"); 
  //Font loading
  defaultFont = loadFont("ArialMT-30.vlw");
  titleFont = loadFont("SansSerif.bolditalic-52.vlw");
  //Data Iterator
  dateIterator = new DateIteration(); //Create new date iterator. 
  //imageLoading
  backImage = loadImage("backButton.png");
  mainIcon = loadImage("Main-icon.png"); 
  barChartIcon = loadImage("barChartIcon.png"); 
  lineChartIcon = loadImage("LineChartIcon.png"); 
  //widget loading
  intialiseBarChartWidgets();
  intialiseMainMenuWidgets();
  intialiseLineChartWidgets();
  intialiseCompanyViewerWidgets();
  focusScroller = barChartScreen.companyScroller;
  queries = new Queries(); 
  //
}
//------------------------------------------------------------------------------
//Theo SK: Switches between draw methods in screen objects based upon what screen is being displayed (currentScreen variable). 
//The draw methods can be found in the screen class draw() method. 
void draw()  
{ 
  switch(currentScreen) {
  case SCREEN_MAIN1:
    mainScreen.draw();
    break;
  case SCREEN_BARCHART:
    background(backgroundColor);
    barChartScreen.draw();
    break;
  case SCREEN_BARCHARTDRAW:
    background(backgroundColor);
    barChart.draw(); 
    break;
  case SCREEN_LINECHART:
    background(backgroundColor); 
    lineChartScreen.draw(); 
    break;
  case SCREEN_LINECHARTDRAW:
    background(backgroundColor); 
    lineChart.draw();
    break;
  case SCREEN_COMPANYVIEWER:
    background(backgroundColor);
    companyScreen.draw();
    break;
  }
}
//mouseWheel scrolls up and down any scrollers that the user has clicked on. 
void mouseWheel(MouseEvent event)
{
  if(currentScreen == SCREEN_COMPANYVIEWER){
    theCompanyViewer.scroll -=event.getCount()*2; 
  } else {
    focusScroller.scroll -= event.getCount()*10;
  }
}
//Theo SK: Deals with the textbuttons/buttons being pressed. This can focus on both a text widget and button widget at the
//the same time. To see individual mouse interactions based on the screen, go to the Mouse_Interactions tab. 
void mousePressed() {  
  switch(currentScreen) {
  case SCREEN_BARCHART:  
    mouseBarChart(); 
    break;
  case SCREEN_MAIN1:
    mouseMainScreen(); 
    break; 
  case SCREEN_BARCHARTDRAW:
    barChart.backButton.pressed(mouseX, mouseY); 
    break;
  case SCREEN_LINECHART:
    mouseLineChart();
    break;
  case SCREEN_LINECHARTDRAW:
    lineChart.backButton.pressed(mouseX, mouseY);
    break; 
  case SCREEN_COMPANYVIEWER:
    mouseCompanyViewer();
    companyScreen.backButton.pressed(mouseX, mouseY);
  }
}
//Theo SK: Calls append() when a text widget is clicked. The text widget replaces its label with chars entered. 
void keyPressed() { 
  if (focusText != null) {
    focusText.append(key);
  }
}
//Theo SK: Checks the widgets for entry on a given screen, for instance the bar chart.
//If they are all correct/intialised, returns true.
//Goes by the variable entriesAllowed for a screen. 
boolean checkWidgetsForEntry(Screen screen) {  
  int correctEntry = 0; 
  int emptyEntry = 0;
  for (int i = 0; i < screen.entriesAllowed-1; i++) { 
    if (screen.textWidgets.get(i).getEntry() == "") {
      correctEntry++;
      emptyEntry++;
    } else if (screen.textWidgets.get(i).getEntry() != "!error!") {
      correctEntry++;
    }
  }
  if (correctEntry == screen.entriesAllowed-1 && emptyEntry < screen.entriesAllowed-1) { //if the count of entered ones doesnt equal the amount of text widgets, or they are all empty, returns false. 
    return true;
  } else {
    return false;
  }
}
//Theo SK: Checks if an array of datapoints is empty or not. (19/03/2020)
//returns true if empty. 
boolean isArrayEmpty(DataPoint[] array) {
  int c = 0;
  for (int i = 0; i < array.length; i++) {
    if (array[i].dataString.equals("null")) {
      c++;
    }
  }
  if (c == array.length) {
    return true;
  } else return false;
}
//setFocusButton is used to set the new clicked button. It resets the colour of the old button
//and sets the new button.
void setFocusButton(Widget newButton){
  if(focusButton != null){
    focusButton.resetColor(); 
    focusButton.draw(); 
    focusButton = newButton; 
    focusButton.widgetPressed(); 
  } else {
    focusButton = newButton; 
    focusButton.widgetPressed();  
  }
}

void fillSectorArrayList()//CianDoyle
{    
  for (int i = 0; i < theStocks.stocksArray.size(); i++)
  {
    SingleStock holding = theStocks.stocksArray.get(i);
    for (int j = 0; j < sectors.size(); j++)
    {
      String holSector = holding.getRealSector();
      if (holSector.equals(sectors.get(j)) == false)
      {
        companyViewerCounter++;
      }
    }
    if (companyViewerCounter == sectors.size())
    {
      sectors.add(holding.getRealSector());
      ending = false;
    }
    companyViewerCounter = 0;
  }
  println(sectors.size());
}
