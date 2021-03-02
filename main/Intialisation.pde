//Intialisation functions (IGNORE UNLESS WANTING TO CHANGE)-----------------------------------------------------------------------------------------------------------------
//Theo SK: this function is purely used purely for intialising the bar chart. 
//It gets the user inputted stocks from the Stocks array and gets their respective DataPoints using 
//extractTickerByDate (or an average for the year or month). 
DataPoint[] intialiseDataPointsFromStocks() {
  DataPoint[] theDataArray = new DataPoint[8]; 
  //Loading format:
  SingleStock s1 = theStocks.extractStockFromName(barChartScreen.textWidgets.get(0).returnedEntry);
  DataPoint t1 =  theData.extractTickerByDate(s1.getTicker(), barChartScreen.textWidgets.get(8).returnedEntry); 
  t1.setStockDetails(s1); 
  theDataArray[0] = t1; 
  //
  SingleStock s2 = theStocks.extractStockFromName(barChartScreen.textWidgets.get(1).returnedEntry);
  DataPoint t2 =  theData.extractTickerByDate(s2.getTicker(), barChartScreen.textWidgets.get(8).returnedEntry); 
  t2.setStockDetails(s2); 
  theDataArray[1] = t2;
  SingleStock s3 = theStocks.extractStockFromName(barChartScreen.textWidgets.get(2).returnedEntry);
  DataPoint t3 =  theData.extractTickerByDate(s3.getTicker(), barChartScreen.textWidgets.get(8).returnedEntry); 
  t3.setStockDetails(s3); 
  theDataArray[2] = t3;
  SingleStock s4 = theStocks.extractStockFromName(barChartScreen.textWidgets.get(3).returnedEntry);
  DataPoint t4 =  theData.extractTickerByDate(s4.getTicker(), barChartScreen.textWidgets.get(8).returnedEntry); 
  t4.setStockDetails(s4); 
  theDataArray[3] = t4;
  SingleStock s5 = theStocks.extractStockFromName(barChartScreen.textWidgets.get(4).returnedEntry);
  DataPoint t5 =  theData.extractTickerByDate(s5.getTicker(), barChartScreen.textWidgets.get(8).returnedEntry);
  t5.setStockDetails(s5); 
  theDataArray[4] = t5;
  SingleStock s6 = theStocks.extractStockFromName(barChartScreen.textWidgets.get(5).returnedEntry);
  DataPoint t6 =  theData.extractTickerByDate(s6.getTicker(), barChartScreen.textWidgets.get(8).returnedEntry);
  t6.setStockDetails(s6); 
  theDataArray[5] = t6;
  SingleStock s7 = theStocks.extractStockFromName(barChartScreen.textWidgets.get(6).returnedEntry);
  DataPoint t7 =  theData.extractTickerByDate(s7.getTicker(), barChartScreen.textWidgets.get(8).returnedEntry); 
  t7.setStockDetails(s7); 
  theDataArray[6] = t7;
  SingleStock s8 = theStocks.extractStockFromName(barChartScreen.textWidgets.get(7).returnedEntry);
  DataPoint t8 =  theData.extractTickerByDate(s8.getTicker(), barChartScreen.textWidgets.get(8).returnedEntry);
  t8.setStockDetails(s8); 
  theDataArray[7] = t8;
  return theDataArray;
}
//Function just creates & intialises the Main Menu widgets. 
void intialiseMainMenuWidgets() {
  int bY = 70; 
  int bW = 750; 
  int bL = 266; 
  Widget barChart1Button = new Widget("Bar Charts", null, -1, bY, bW, bL, pink, 0, titleFont, SCREEN_BARCHART);
  barChart1Button.setHoverMessage("Displays a barchart for user entered companies at a certain date.", "right");
  Widget lineChartButton = new Widget("Line Charts", null, -1, bY+bL+20, bW, bL, pink, 0, titleFont, SCREEN_LINECHART);
  lineChartButton.setHoverMessage("Displays a linechart for user entered companies for a given time period.", "right"); 
  Widget companyViewButton = new Widget("Company Viewer", null, -1, bY+2*(bL+20), bW, bL, pink, 0, titleFont, SCREEN_COMPANYVIEWER);
  companyViewButton.setHoverMessage("A list of all companies available in a data sheet.\nShows as well details & statistics for the companies!", "right"); 
  mainScreen.addButton(barChart1Button); 
  mainScreen.addButton(lineChartButton); 
  mainScreen.addButton(companyViewButton);
}
//Widget placement
int textWHeight = 65;
int textWWidth  = 350;
int textWidgetsX = -1;
int textWidgetsY = 250;
//Function just creates & intialises the Bar Chart widgets. 
void intialiseBarChartWidgets() {
  //Entry widgets
  TextWidget entryCompany1 = new TextWidget(textWidgetsX, textWidgetsY, textWWidth, textWHeight, "Please enter the company's name. ", "Company 1:", pink, 0, defaultFont, 50);
  TextWidget entryCompany2 = new TextWidget(textWidgetsX+textWWidth+50, textWidgetsY, textWWidth, textWHeight, "Please enter the company's name. ", "Company 2:", pink, 0, defaultFont, 50);
  TextWidget entryCompany3 = new TextWidget(textWidgetsX, textWidgetsY+textWHeight+30, textWWidth, textWHeight, "Please enter the company's name. ", "Company 3:", pink, 0, defaultFont, 50);
  TextWidget entryCompany4 = new TextWidget(textWidgetsX+textWWidth+50, textWidgetsY+textWHeight+30, textWWidth, textWHeight, "Please enter the company's name. ", "Company 4:", pink, 0, defaultFont, 50);
  TextWidget entryCompany5 = new TextWidget(textWidgetsX, textWidgetsY+2*(textWHeight+30), textWWidth, textWHeight, "Please enter the company's name. ", "Company 5:", pink, 0, defaultFont, 50);
  TextWidget entryCompany6 = new TextWidget(textWidgetsX+textWWidth+50, textWidgetsY+2*(textWHeight+30), textWWidth, textWHeight, "Please enter the company's name. ", "Company 6:", pink, 0, defaultFont, 50);
  TextWidget entryCompany7 = new TextWidget(textWidgetsX, textWidgetsY+3*(textWHeight+30), textWWidth, textWHeight, "Please enter the company's name. ", "Company 7:", pink, 0, defaultFont, 50);
  TextWidget entryCompany8 = new TextWidget(textWidgetsX+textWWidth+50, textWidgetsY+3*(textWHeight+30), textWWidth, textWHeight, "Please enter the company's name. ", "Company 8:", pink, 0, defaultFont, 50); 
  DateWidget entryStartDate = new DateWidget(-1, 120, 750, 65, "dd/mm/yyyy", "Enter a date.", pink, 0, defaultFont, 32, "BARCHART");
  //Barchart button
  Widget barChartButton = new Widget("Show Chart.", null, -1, 800, 750, 200, pink, 0, defaultFont, EVENT_BARCHART); 
  //Queries buttons
  Widget openingPriceButton = new Widget("Opening Price", null, -1, textWidgetsY+4*(textWHeight+30)+20, textWWidth, 30, pink, 0, defaultFont, OPENING_PRICE);   
  barChartScreen.addButton(openingPriceButton); 
  Widget closingPriceButton = new Widget("Closing Price", null, textWidgetsX+textWWidth+49, textWidgetsY+4*(textWHeight+30)+20, textWWidth, 30, pink, 0, defaultFont, CLOSING_PRICE);   
  barChartScreen.addButton(closingPriceButton); 
  Widget adjustedCloseButton = new Widget("Adjusted Closing Price", null, -1, textWidgetsY+4*(textWHeight+30)+60, textWWidth, 30, pink, 0, defaultFont, ADJUSTED_CLOSE);   
  barChartScreen.addButton(adjustedCloseButton);
  Widget volumeButton = new Widget("Volume", null, textWidgetsX+textWWidth+49, textWidgetsY+4*(textWHeight+30)+60, textWWidth, 30, pink, 0, defaultFont, VOLUME);   
  barChartScreen.addButton(volumeButton);
  Widget volatilityButton = new Widget("Volatility", null, textWidgetsX, textWidgetsY+4*(textWHeight+30)+100, textWWidth, 30, pink, 0, defaultFont, VOLATILITY); 
  barChartScreen.addButton(volatilityButton); 
  //Scroller
  CompanyScroller companies = new CompanyScroller(753, 20); 
  companies.setHoverMessage("This box displays the company details of the stocks present in the datasheet!\nYou can scroll down the list using the scroll wheel."); 
  barChartScreen.companyScroller = companies; 
  barChartScreen.addtextWidget(entryCompany1);
  barChartScreen.addtextWidget(entryCompany2);
  barChartScreen.addtextWidget(entryCompany3);
  barChartScreen.addtextWidget(entryCompany4);
  barChartScreen.addtextWidget(entryCompany5);
  barChartScreen.addtextWidget(entryCompany6);
  barChartScreen.addtextWidget(entryCompany7);
  barChartScreen.addtextWidget(entryCompany8);
  barChartScreen.addtextWidget(entryStartDate); 
  barChartScreen.addtextWidget(barChartScreen.companyScroller.searchBox); 
  barChartScreen.addButton(barChartButton);
}
//Function just creates & intialises the Line chart widgets
void intialiseLineChartWidgets()
{
  TextWidget entry1 = new TextWidget(textWidgetsX, textWidgetsY+40, 750, textWHeight, "Please enter the company's name. ", "Company:", pink, 0, defaultFont, 50);
  TextWidget entry2 = new TextWidget(textWidgetsX, textWidgetsY+textWHeight+80, 750, textWHeight, "Please enter the company's name. ", "Company 2:", pink, 0, defaultFont, 50);
  TextWidget entry3 = new TextWidget(textWidgetsX, textWidgetsY+2*(textWHeight)+120, 750, textWHeight, "Please enter the company's name. ", "Company 3:", pink, 0, defaultFont, 50);
  DateWidget entryStartDate = new DateWidget(-1, 85, 750, 50, "dd/mm/yyyy", "Enter a start date.", pink, 0, defaultFont, 32, "LINECHART");
  DateWidget entryEndDate = new DateWidget(-1, 170, 750, 50, "dd/mm/yyyy", "Enter an end date.", pink, 0, defaultFont, 32, "LINECHART");
  Widget lineChartButton = new Widget("Show Chart.", null, -1, 800, 750, 200, pink, 0, defaultFont, EVENT_LINECHART); 
  lineChartScreen.addButton(lineChartButton);
  Widget openingPriceButton = new Widget("Opening Price", null, -1, textWidgetsY+4*(textWHeight+30)+20, textWWidth, 30, pink, 0, defaultFont, OPENING_PRICE);   
  lineChartScreen.addButton(openingPriceButton); 
  Widget closingPriceButton = new Widget("Closing Price", null, textWidgetsX+textWWidth+49, textWidgetsY+4*(textWHeight+30)+20, textWWidth, 30, pink, 0, defaultFont, CLOSING_PRICE);   
  lineChartScreen.addButton(closingPriceButton); 
  Widget adjustedCloseButton = new Widget("Adjusted Closing Price", null, -1, textWidgetsY+4*(textWHeight+30)+60, textWWidth, 30, pink, 0, defaultFont, ADJUSTED_CLOSE);   
  lineChartScreen.addButton(adjustedCloseButton);
  Widget volumeButton = new Widget("Volume", null, textWidgetsX+textWWidth+49, textWidgetsY+4*(textWHeight+30)+60, textWWidth, 30, pink, 0, defaultFont, VOLUME);   
  lineChartScreen.addButton(volumeButton);
  lineChartScreen.addtextWidget(entryStartDate);
  lineChartScreen.addtextWidget(entryEndDate);
  lineChartScreen.addtextWidget(entry1);
  lineChartScreen.addtextWidget(entry2);
  lineChartScreen.addtextWidget(entry3); 
  CompanyScroller companyScroller = new CompanyScroller(754, 20); 
  lineChartScreen.companyScroller = companyScroller;
}

void intialiseCompanyViewerWidgets()
{
  int width = 188; int length = 20; 
  //The date widget
   SearchWidget searchWidget = new SearchWidget(theCompanyViewer.xPos+450,theCompanyViewer.yPos, 300, 40, "Search", pink, 
    defaultFont, 32); 
    companyScreen.addtextWidget(searchWidget); 
  //The Sector widgets
  Widget healthCareWidget = new Widget("Healthcare", "", 750, 60, width, length, pink, 0,
    defaultFont, EVENT_HEALTHCARE);
    companyScreen.addButton(healthCareWidget); 
  Widget financeWidget = new Widget("Finance", "", 750+width, 60, width, length, pink, 0,
    defaultFont, EVENT_FINANCE);
    companyScreen.addButton(financeWidget); 
  Widget energyWidget = new Widget("Energy", "", 750+2*width, 60, width, length, pink, 0,
    defaultFont, EVENT_ENERGY);
    companyScreen.addButton(energyWidget);
  Widget consumerWidget = new Widget("Consumer Services", "", 750+3*width, 60, width, length, pink, 0,
    defaultFont, EVENT_CONSUMERSERVICES);
    companyScreen.addButton(consumerWidget); 
  Widget technologyWidget = new Widget("Technology", "", 750, 60+length, width, length, pink, 0,
    defaultFont, EVENT_TECHNOLOGY);
    companyScreen.addButton(technologyWidget); 
  Widget transportationWidget = new Widget("Transportation", "", 750+width, 60+length, width, length, pink, 0,
    defaultFont, EVENT_TRANSPORTATION);
    companyScreen.addButton(transportationWidget); 
   Widget basicIndustriesWidget = new Widget("Basic Industries", "", 750+2*width, 60+length, width, length, pink, 0,
    defaultFont, EVENT_BASICINDUSTRIES);
    companyScreen.addButton(basicIndustriesWidget); 
  Widget noSectorWidget = new Widget("All", "", 750+3*width, 60+length, width, length, pink, 0,
    defaultFont, EVENT_NOSECTOR);
    companyScreen.addButton(noSectorWidget);
  Widget allWidget = new Widget("All Companies", "", 750, 80+2*length, 375, 20, pink, 0,
    defaultFont, EVENT_ALL);
    companyScreen.addButton(allWidget);
   Widget sheetWidget = new Widget("Companies in data sheet.", "", 1125, 80+2*length, 375, 20, pink, 0,
    defaultFont, EVENT_SHEET);
    companyScreen.addButton(sheetWidget);
}
