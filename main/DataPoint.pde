
//DataPoint class: contains the opening prices/closing prices/adjusted close/etc for a given company's ticker 
//at a specific date. 
//Is also a comparable object - ordered by it's ticker in alphabetical order.
class DataPoint implements Comparable<DataPoint>{
  String[] splitData = new String[8]; 
  String dataString;
  String ticker;
  float openPrice;
  float closingPrice;
  float adjustedClose;
  float low;
  float high; 
  float volume; 
  //Statistics for the data (if its an average datapoint). 
  double volatility; 
  float highestPrice;
  String priceRange;
  float  avgPercGrowth; 
  //
  String date; 
  String sector; 
  String name; 
  String industry; 
  DataPoint(){ //Null DataPoint - Replacement for a null datapoint.
  //This is useful for displaying nothing when a user enters in nothing into one of the widgets.
    this.dataString = "null";
    this.ticker = "";
    this.openPrice = 0;
    this.closingPrice = 0;
    this.adjustedClose = 0;
    this.low = 0;
    this.high = 0;
    this.volume = 0;
    this.date = "";
  } 
  //Theo SK: sets the data string of the point and the splits it into its parts and sets the variables.
  void setDataString(String inputData){
    dataString = inputData; 
    splitData();
  }
  //Draw options (if necessary). 
  void draw(String selectedData, int xpos, int ypos){
    switch (selectedData){
      case "ticker":
        text(ticker, xpos, ypos); 
        break;
      case "openPrice":
        text(openPrice, xpos, ypos); 
        break;
      case "closingPrice":
        text(closingPrice, xpos, ypos); 
        break;
      case "adjustedClose":
        text(adjustedClose, xpos, ypos); 
        break;
      case "low":
        text(low, xpos, ypos); 
        break;
      case "high":
        text(high, xpos, ypos); 
        break;
      case "volume":
        text(volume, xpos, ypos); 
        break;
      case "date":
        text(date, xpos, ypos); 
        break;
    }
  }
  //Splits the Data string into its parts and sets the variables.
  private void splitData(){
    splitData = split(dataString, ','); 
    //setting each data 
    ticker = splitData[0].toLowerCase();
    openPrice = Float.parseFloat(splitData[1]);
    closingPrice = Float.parseFloat(splitData[2]);
    adjustedClose = Float.parseFloat(splitData[3]);
    low = Float.parseFloat(splitData[4]);
    high = Float.parseFloat(splitData[5]);
    volume = Float.parseFloat(splitData[6]); 
    date = splitData[7].toLowerCase(); 
  }
  //get functions
  String getTicker(){
    return ticker; 
  }
  void setTicker(String ticker){
    this.ticker = ticker;
  }
  float getOpenPrice(){
    return openPrice;
  }
  float getClosingPrice(){
    return closingPrice;
  }
  float getAdjustedClose(){
    return adjustedClose;
  }
  float getLow(){
    return low; 
  }
  float getHigh(){
    return high; 
  }
  float getVolume(){
    return volume; 
  }
  String getDate(){
    return date; 
  }
  //Sets the name, sector and industry of a datapoint if it is being used/displayed.
  //This makes their stock details easily accessible rather than searching for the ticker in the stocks.csv file. 
  void setStockDetails(SingleStock theStock){
    this.name = theStock.getCompanyName();
    this.sector = theStock.getSector(); 
    this.industry = theStock.getIndustry(); 
  }
  //Comparator methods. 
  @Override 
  int compareTo(DataPoint theData){
    return (this.getTicker().compareTo(theData.ticker) < 0? -1 :
     this.getTicker().compareTo(theData.ticker) == 0? 0 :
     +1); 
  }
}

 
