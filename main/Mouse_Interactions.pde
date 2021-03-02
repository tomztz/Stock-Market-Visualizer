
//MAIN SCREEN MOUSE INTERACTIONS
void mouseMainScreen() {
  int event;
  for (int i=0; i<mainScreen.buttonWidgets.size(); i++) {
    Widget widget = mainScreen.buttonWidgets.get(i);
    event = widget.getEvent(mouseX, mouseY);
    switch(event) {
    case SCREEN_BARCHART:
      currentScreen = SCREEN_BARCHART;
      break;
    case SCREEN_LINECHART:
      currentScreen = SCREEN_LINECHART;
      break;
    case SCREEN_COMPANYVIEWER:
      currentScreen = SCREEN_COMPANYVIEWER;
      break;
    }
  }
}

//BARCHART USER SCREEN MOUSE INTERACTIONS
//Created & commented by TSK. 
boolean selectedChart = false;
String selectedShow = "";
void mouseBarChart() {
  int event; 
  for (int i=0; i<barChartScreen.buttonWidgets.size(); i++) { //Going through each of the widgets checking if they have been clicked. 
    Widget widget = barChartScreen.buttonWidgets.get(i);
    event = widget.getEvent(mouseX, mouseY); 
    switch(event) {
    case EVENT_BARCHART:  //User has clicked the bar chart. 
      println("Barchart button pressed. " + selectedChart); //(Just for checking code)
      if (checkWidgetsForEntry(barChartScreen) == true) {
        DataPoint[] dataArray = intialiseDataPointsFromStocks();
        barChart = new BarChart(dataArray, selectedShow, barChartScreen.textWidgets.get(8).returnedEntry); //making the barchart
        currentScreen = SCREEN_BARCHARTDRAW; //Switching the screen to the bar chart.
      } else {
        barChartScreen.buttonWidgets.get(0).widgetError();
        println("here");
        text("Not all valid tickers have been entered!", 50, 50);
      }  
      break;
    case OPENING_PRICE: //If they click the opening price button.
      setFocusButton(widget);
      selectedShow = "Opening Price";
      selectedChart = true; 
      println(selectedChart);
      break;
    case CLOSING_PRICE: //If they click the closing price button.
      setFocusButton(widget);
      selectedShow = "Closing Price";
      selectedChart = true; 
      break; 
    case ADJUSTED_CLOSE:
      setFocusButton(widget);
      selectedShow = "Adjusted closing price";
      selectedChart = true; 
      break;
    case VOLUME:
      setFocusButton(widget);
      selectedShow = "Volume";
      selectedChart = true; 
      break;
    case VOLATILITY:
      setFocusButton(widget);
      selectedShow = "Volatility";
      selectedChart = true; 
      break;
    default:
      focusButton = null;
    }
  }

  for (int i=0; i<barChartScreen.textWidgets.size(); i++) {//Checking the text widgets if any have been pressed. 
    TextWidget textWidget = barChartScreen.textWidgets.get(i);
    event = textWidget.getEvent(mouseX, mouseY); 
    switch(event) 
    {
    case EVENT_TEXT:
      println("Text button clicked.");
      focusText = textWidget;
      return;
    default:
      focusText = null; 
      break;
    }
  }
  //BackButton and company scroller checking for mouse interactions. 
  barChartScreen.backButton.pressed(mouseX, mouseY); 
  barChartScreen.companyScroller.pressed(mouseX, mouseY);
}
//MOUSE LINE CHART USER SCREEN INTERACTIONS 
//Created & commented by TSK. 
void mouseLineChart() {
  int event;
  for (int i = 0; i < lineChartScreen.buttonWidgets.size(); i++) { //TSK: Checking all button widgets in the screen to see if they have been pressed. 
    Widget widget = lineChartScreen.buttonWidgets.get(i);
    event = widget.getEvent(mouseX, mouseY);
    switch(event) {
    case EVENT_LINECHART: //If they clicked the line chart button.
      if (checkWidgetsForEntry(lineChartScreen)==true) {//Check if all entries have been filled. 
        SingleStock s1 = theStocks.extractStockFromName(lineChartScreen.textWidgets.get(2).returnedEntry);//Get the stock from the first entry. 
        SingleStock s2 = theStocks.extractStockFromName(lineChartScreen.textWidgets.get(3).returnedEntry);//Get the stock from the second entry. 
        SingleStock s3 = theStocks.extractStockFromName(lineChartScreen.textWidgets.get(4).returnedEntry);//Get the stock from the third entry. 
        ArrayList<DataPoint> entryPoints1 = dateIterator.getData(lineChartScreen.textWidgets.get(0).returnedEntry, lineChartScreen.textWidgets.get(1).returnedEntry, s1.ticker); //Get all of the points involved in the given date period for company 1.
        ArrayList<DataPoint> entryPoints2 = dateIterator.getData(lineChartScreen.textWidgets.get(0).returnedEntry, lineChartScreen.textWidgets.get(1).returnedEntry, s2.ticker); //Get all of the points involved in the given date period for company 2. 
        ArrayList<DataPoint> entryPoints3 = dateIterator.getData(lineChartScreen.textWidgets.get(0).returnedEntry, lineChartScreen.textWidgets.get(1).returnedEntry, s3.ticker); //Get all of the points involved in the given date period for company 3. 
        lineChart = new LineChart(entryPoints1, entryPoints2, entryPoints3, selectedShow, lineChartScreen.textWidgets.get(0).returnedEntry, lineChartScreen.textWidgets.get(1).returnedEntry);
        currentScreen = SCREEN_LINECHARTDRAW;
      } 
      break;
      //If they click any of the other price buttons. 
    case OPENING_PRICE:
      widget.widgetPressed();
      selectedShow = "Opening Price";
      selectedChart = true; 
      break;
    case CLOSING_PRICE:
      widget.widgetPressed();
      selectedShow = "Closing Price";
      selectedChart = true; 
      break;
    case ADJUSTED_CLOSE:
      widget.widgetPressed();
      selectedShow = "Adjusted closing price";
      selectedChart = true; 
      break;
    case VOLUME:
      widget.widgetPressed();
      selectedShow = "Volume";
      selectedChart = true; 
      break;
    }
  }
  //Checking for text widgets. 
  for (int i = 0; i < lineChartScreen.textWidgets.size(); i++) {
    TextWidget textWidget = lineChartScreen.textWidgets.get(i);
    event = textWidget.getEvent(mouseX, mouseY); 
    switch(event) {
    case EVENT_TEXT:
      println("Text button clicked.");
      focusText = textWidget;
      return;
    default:
      focusText = null; 
      break;
    }
  }
  //Back button and company scroller mouse interactions checking. 
  lineChartScreen.companyScroller.pressed(mouseX, mouseY); 
  lineChartScreen.backButton.pressed(mouseX, mouseY);
}

int allOrScreen = EVENT_ALL; //By default, the page will display only the companies in the data sheet given
void mouseCompanyViewer()
{
  int event; 
  //Checking for text widgets. 
  for (int i = 0; i < companyScreen.textWidgets.size(); i++) {
    TextWidget textWidget = companyScreen.textWidgets.get(i);
    event = textWidget.getEvent(mouseX, mouseY); 
    switch(event) {
    case EVENT_TEXT:
      println("Text button clicked.");
      focusText = textWidget;
      return;
    default:
      focusText = null; 
      break;
    }
  }
  //Checking sector buttons:
  ArrayList<SingleStock> stocksToShow; 
  for (int i = 0; i < companyScreen.buttonWidgets.size(); i++) {
    Widget buttonWidget = companyScreen.buttonWidgets.get(i);
    event = buttonWidget.getEvent(mouseX, mouseY); 
    switch(event) {
    case EVENT_HEALTHCARE:
      setFocusButton(buttonWidget); 
      stocksToShow = (allOrScreen == EVENT_ALL? healthCare : theStocks.sectorStocksInDataSheet("HEALTH CARE")); 
      theCompanyViewer.set(stocksToShow, "HEALTH CARE"); 
      return;
    case EVENT_TECHNOLOGY:
      println(event + " sector clicked."); 
      stocksToShow = (allOrScreen == EVENT_ALL? technology : theStocks.sectorStocksInDataSheet("TECHNOLOGY")); 
      theCompanyViewer.set(stocksToShow, "TECHNOLOGY"); 
      setFocusButton(buttonWidget); 
      return;
    case EVENT_FINANCE:
      stocksToShow = (allOrScreen == EVENT_ALL? finance : theStocks.sectorStocksInDataSheet("FINANCE")); 
      theCompanyViewer.set(stocksToShow, "FINANCE"); 
      setFocusButton(buttonWidget); 
      return;
    case EVENT_ENERGY:
     stocksToShow = (allOrScreen == EVENT_ALL? energy : theStocks.sectorStocksInDataSheet("ENERGY")); 
      theCompanyViewer.set(stocksToShow, "ENERGY"); 
      setFocusButton(buttonWidget); 
      return;
    case EVENT_CONSUMERSERVICES:
      stocksToShow = (allOrScreen == EVENT_ALL? consumerServices : theStocks.sectorStocksInDataSheet("CONSUMER SERVICES")); 
      theCompanyViewer.set(stocksToShow, "CONSUMER SERVICES"); 
      setFocusButton(buttonWidget); 
      return;
    case EVENT_TRANSPORTATION:
      stocksToShow = (allOrScreen == EVENT_ALL? transportation : theStocks.sectorStocksInDataSheet("TRANSPORTATION")); 
      theCompanyViewer.set(stocksToShow, "TRANSPORTATION"); 
      setFocusButton(buttonWidget);
      return;
    case EVENT_CAPITALGOODS:
      println(event + " sector clicked."); 
      setFocusButton(buttonWidget); 
      stocksToShow = (allOrScreen == EVENT_ALL? capitalGoods : theStocks.sectorStocksInDataSheet("CAPITALGOODS")); 
      theCompanyViewer.set(stocksToShow, "CAPITALGOODS"); 
      return;
    case EVENT_BASICINDUSTRIES:
      setFocusButton(buttonWidget); 
      stocksToShow = (allOrScreen == EVENT_ALL? transportation : theStocks.sectorStocksInDataSheet("BASIC INDUSTRIES")); 
      theCompanyViewer.set(stocksToShow, "BASIC INDUSTRIES"); 
    break; 
    case EVENT_NOSECTOR:
      setFocusButton(buttonWidget); 
      stocksToShow = (allOrScreen == EVENT_ALL? theStocks.stocksArray : stocksInDataSheet); 
      theCompanyViewer.set(stocksToShow, "NO SECTOR"); 
    break;
    case EVENT_SHEET:
      setFocusButton(buttonWidget); 
      allOrScreen = EVENT_SHEET; 
    break; 
    case EVENT_ALL:
      setFocusButton(buttonWidget); 
      allOrScreen = EVENT_ALL;
    break; 
    default:
      focusButton = null; 
      break;
    }
  }
   theCompanyViewer.buttonsClicked(); //This is the equivalent of checking the buttons presses for the line chart/bar chart - it has been moved
                         // so it is clearer what functions are being used and what is being drawn, as it is primarily focussed on the company buttons. 
}
 
