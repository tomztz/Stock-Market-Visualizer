
//SingleStock is the equivalent of a DataPoint for the Stocks class.
//SingleStock takes in a string from the stocks.csv file and separates out a line 
//and creates a singleStock object fot it.
//Then sets the SingleStock's ticker, name, exchange, sector etc. for comparsion in the program. 
//Also sets the real versions for the variables, which is purely used for displaying to the user (as they are unedited). 
class SingleStock implements Comparable<SingleStock>{
  private String stockString; 
  private String realTicker;       //Theo SK (06/04/2020) - Added 'real' versions of the variables.
  private String ticker;           //This is so when wanting to draw the stocks variables (such as in the company scroller)
  private String realExchange;     //you can use .getTicker() etc to draw the proper, un-manipulated versions of the variables
  private String exchange;         //rather than versions that are used for comparsion by the program's functions (i.e name, ticker, etc variables). 
  private String realName;
  private String name;
  private String realSector; 
  private String sector;
  private String realIndustry; 
  private String industry; 
  SingleStock(){
    this.stockString = "";
    this.ticker ="";
    this.name = "";
    this.sector = "";
    this.industry = "";
  }
  //Constructor
  //Sets the stock's entire string from the stock file. 
  //Calls the splitString functions for the real variables (ForDraw) and comparsion variables (ForComparsion). 
  SingleStock(String stockString){
    this.stockString = stockString; 
    splitStringForDraw(this.stockString); 
    splitStringForComparsion(this.stockString); 
  }
  //Sets the real variables for drawing.
  private void splitStringForDraw(String thisStock){
   String[] splitString = split(thisStock, ',');
   if(splitString.length > 5){
     //Please account for google's entry of having a comma in the 'industry' tab. 
     splitString[2] += ", " + splitString[3];
     splitString[2] = splitString[2].replaceAll("\"", "");
      realTicker = splitString[0];
      realExchange = splitString[1]; 
      realName = splitString[2]; 
      realSector = splitString[4];
      realIndustry = splitString[5]; 
     
   }else{
    //Setting each attribute of the stock 
    realTicker = splitString[0];
    realExchange = splitString[1]; 
    realName = splitString[2]; 
    realSector = splitString[3];
    realIndustry = splitString[4]; 
   }
  }
  private void splitStringForComparsion(String thisStock){
   thisStock = thisStock.replaceAll(" ", "");
   String[] splitString = split(thisStock, ',');
   if(splitString.length > 5){
     //Please account for google's entry of having a comma in the 'industry' tab. 
     splitString[2] += ',' + splitString[3];
     splitString[2] = splitString[2].replaceAll("\"", "");
      ticker = splitString[0].toLowerCase();
      exchange = splitString[1].toLowerCase(); 
      name = splitString[2].toLowerCase(); 
      sector = splitString[4].toLowerCase();
      industry = splitString[5].toLowerCase(); 
     
   }else{
    //Setting each attribute of the stock 
    ticker = splitString[0].toLowerCase();
    exchange = splitString[1].toLowerCase(); 
    name = splitString[2].toLowerCase(); 
    sector = splitString[3].toLowerCase();
    industry = splitString[4]; 
   }
   //Getters and setters. 
  }
  String getStockString(){
    return stockString; 
  }
  String getTicker(){
    return ticker; 
  }
  String getExchange(){
    return exchange;
  }
  String getCompanyName(){
    return name;
  }
  String getSector(){
    return sector;
  }
  String getIndustry(){
    return industry; 
  }
  //-------Real returns-----------------
  String getRealName(){
    return realName;
  }
  String getRealTicker(){
    return realTicker;
  }
  String getRealSector(){
    return realSector; 
  }
  String getRealExchange(){
    return realExchange; 
  }
  String getRealIndustry(){
    return realIndustry; 
  }
  void setName(String name){
    this.name = name;
  }
  //Comparator SingleStock.
  //Compares the names and sorts in alphabetical order. 
  @Override 
  int compareTo(SingleStock theStock){
    return (this.getCompanyName().compareTo(theStock.getCompanyName()) < 0? -1:
    this.getCompanyName().compareTo(theStock.getCompanyName()) == 0? 0:
    +1);
  }
}
