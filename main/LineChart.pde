
class LineChart
{  //<>//
  private BackButton backButton; 
  String startDate;
  String endDate;
  String dataType; 
  String company1Name = lineChartScreen.textWidgets.get(2).returnedEntry.toUpperCase();
  String company2Name = lineChartScreen.textWidgets.get(3).returnedEntry.toUpperCase();
  String company3Name = lineChartScreen.textWidgets.get(4).returnedEntry.toUpperCase(); 
  String company1Ticker = "";
  String company2Ticker = ""; 
  String company3Ticker = ""; 
  DataPoint avgCompany1 = new DataPoint(); 
  DataPoint avgCompany2 = new DataPoint();
  DataPoint avgCompany3 = new DataPoint(); 
  ArrayList<String> dates = new ArrayList();
  ArrayList<DataPoint> company1 = new ArrayList<DataPoint>(1); 
  ArrayList<DataPoint> company2 = new ArrayList<DataPoint>(1); 
  ArrayList<DataPoint> company3 = new ArrayList<DataPoint>(1); 
  ArrayList<Float> data = new ArrayList<Float>(1);
  ArrayList<Float> xpos1 = new ArrayList<Float>(1);
  ArrayList<Float> ypos1 = new ArrayList<Float>(1);
  ArrayList<Float> xpos2 = new ArrayList<Float>(1);
  ArrayList<Float> ypos2 = new ArrayList<Float>(1);
  ArrayList<Float> xpos3 = new ArrayList<Float>(1);
  ArrayList<Float> ypos3 = new ArrayList<Float>(1);
  float multiplier;
  float multiplier2;
  float price;
  float store;
  ArrayList<Float> storeNumber1 = new ArrayList();
  ArrayList<Float> storeNumber2 = new ArrayList();
  ArrayList<Float> storeNumber3 = new ArrayList(); 
  //Cian Doyle
  //construsctor takes in up tothree companies collection of datapoints, a datatype, a startDate and endDate to specify what the timeFrame for forming the chart is.
  LineChart(ArrayList<DataPoint> company1, ArrayList<DataPoint> company2, ArrayList<DataPoint> company3, String dataType,
    String startDate, String endDate)
  {
    backButton = new BackButton(SCREEN_LINECHART);
    this.dataType = dataType;
    this.startDate = startDate; 
    this.endDate = endDate; 
    if(company1.size() != 0) { 
      this.company1 = company1; this.company1Ticker = company1.get(0).getTicker(); 
      avgCompany1 = queries.avgDataPoint(company1); 
    }
    if(company2.size() != 0) { 
    this.company2 = company2; this.company2Ticker = company2.get(0).getTicker(); 
    avgCompany2 = queries.avgDataPoint(company2); 
    }
    if(company3.size() != 0) { 
    this.company3 = company3; this.company3Ticker = company3.get(0).getTicker();
    avgCompany3 = queries.avgDataPoint(company3); 
    }
    if (dataType == "Opening Price") 
    {//OPENING PRICES-----------------------------------------------------------------------
      for (int i = 0; i < company1.size(); i++)
      {
        price = company1.get(i).openPrice;
        storeNumber1.add(i, price);
        if (price > store)
        {
          store = price;
        }
      }
      for (int i = 0; i < company2.size(); i++)
      {
        price = company2.get(i).openPrice;
        storeNumber2.add(i, price);
        if (price > store)
        {
          store = price;
        }
      }
      for (int i = 0; i < company3.size(); i++)
      {
        price = company3.get(i).openPrice;
        storeNumber3.add(i, price);
        if (price > store)
        {
          store = price;
        }
      }
      multiplier = 900/store;
      multiplier2 = 1350/company1.size();
    }
    if (dataType == "Closing Price")
    {//CLOSING PRICES---------------------------------------------------------------------------
      for (int i = 0; i < company1.size(); i++)
      {
        price = company1.get(i).closingPrice;
        storeNumber1.add(i, price);
        if (price > store)
        {
          store = price;
        }
      }
       for (int i = 0; i < company2.size(); i++)
      {
        price = company2.get(i).closingPrice;
        storeNumber2.add(i, price);
        if (price > store)
        {
          store = price;
        }
      }
      for (int i = 0; i < company3.size(); i++)
      {
        price = company3.get(i).closingPrice;
        storeNumber3.add(i, price);
        if (price > store)
        {
          store = price;
        }
      }
      multiplier = 900/store;
      multiplier2 = 1350/company1.size();
    }
    if (dataType == "Adjusted closing price")
    {//ADJUSTED CLOSING PRICES---------------------------------------------------------------------
      for (int i = 0; i < company1.size(); i++)
      {
        price = company1.get(i).adjustedClose;
        storeNumber1.add(i, price);
        if (price > store)
        {
          store = price;
        }
      }
      for (int i = 0; i < company2.size(); i++)
      {
        price = company2.get(i).adjustedClose;
        storeNumber2.add(i, price);
        if (price > store)
        {
          store = price;
        }
      }
      for (int i = 0; i < company3.size(); i++)
      {
        price = company3.get(i).adjustedClose;
        storeNumber3.add(i, price);
        if (price > store)
        {
          store = price;
        }
      }
      multiplier = 900/store;
      multiplier2 = 1350/company1.size();
    }
     if (dataType == "Volume")
    {//ADJUSTED CLOSING PRICES---------------------------------------------------------------------
      for (int i = 0; i < company1.size(); i++)
      {
        price = company1.get(i).volume*0.1;
        storeNumber1.add(i, price);
        if (price > store)
        {
          store = price;
        }
      }
      for (int i = 0; i < company2.size(); i++)
      {
        price = company2.get(i).volume*0.1;
        storeNumber2.add(i, price);
        if (price > store)
        {
          store = price;
        }
      }
      for (int i = 0; i < company3.size(); i++)
      {
        price = company3.get(i).volume;
        storeNumber3.add(i, price);
        if (price > store)
        {
          store = price;
        }
      }
      multiplier = 780000/store;
      multiplier2 = 1350/company1.size();
    } //<>//
  }
//Draw method---------------------------------------------------
  void draw()
  {
    drawPoints();        //Drawing the points.
    fill(255);
    rect(125, 70, 5, 1000);
    textSize(32); 
    text("Showing "+ dataType + " between "+ startDate +" to "+endDate, 450, 75);
    fill(0);
    text("Date",800,935);
    for(int i=1;i<=10;i++){
      float y=83;
      stroke(150);
      line(125,i*y,2000,i*y);
      
   
    }
      stroke(0);
      fill(0);
      text(dataType,125,75);
     float total=830;
     float base=0;
      for(int j=1;j<=10;j++){
        switch(dataType){
          case "Opening Price":
          base=1.87;
         break;
         case "Closing Price":
          base=3.05;
          break;
          case "Adjusted closing price":
          base=2.33;
          break;
          case "Volume":
          base=0;
          break;
       }
          base= base*j;
        text(base,5,total);
       total=total-83;
      }
    fill(255);
    rect(1360, 100, 100, 400); //Box on the left
    textSize(22); 
    fill(0);
    text(company1Ticker, 1370, 150);fill(pink); rect(1430, 138, 10, 10); fill(0);
    text(company2Ticker, 1370, 180); fill(green); rect(1430, 168, 10, 10); fill(0);
    text(company3Ticker, 1370, 210); fill(red); rect(1430, 198, 10, 10); fill(0); 
    displayStats(); 
    fill(255); 
    rect(0, 900, 1500, 5);
    fill(0);
    dynamicValuesBoxHover(); 
    backButton.draw(); 
  }
//---------------------------------------------------------------
  void drawPoints(){
    //Company 1 draw-------------------------------------------------------
     fill(pink);
    for (int i = 0; i < storeNumber1.size(); i++)
    {
      float x = 150 + (i * multiplier2);
      float y = 1200 - (multiplier * storeNumber1.get(i));
      rect(x, y, 6, 6);
      xpos1.add(x);
      ypos1.add(y);
    }
    for (int i = 1; i < storeNumber1.size(); i++)
    {
      line(xpos1.get(i - 1), ypos1.get(i - 1), xpos1.get(i), ypos1.get(i));
    }
    //Company 2 draw--------------------------------------------------------
    fill(green);
    for (int i = 0; i < storeNumber2.size(); i++)
    {
      float x = 150 + (i * multiplier2);
      float y = 1200 - (multiplier * storeNumber2.get(i));
      rect(x, y, 6, 6);
      xpos2.add(x);
      ypos2.add(y);
    }
    for (int i = 1; i < storeNumber2.size(); i++)
    {
      line(xpos2.get(i - 1), ypos2.get(i - 1), xpos2.get(i), ypos2.get(i));
    }
    //Company 3 draw-------------------------------------------------------
    fill(red);
    for (int i = 0; i < storeNumber3.size(); i++)
    {
      float x = 150 + (i * multiplier2);
      float y = 1200 - (multiplier * storeNumber3.get(i));
      rect(x, y, 6, 6);
      xpos3.add(x);
      ypos3.add(y);
    }
    for (int i = 1; i < storeNumber3.size(); i++)
    {
      line(xpos3.get(i - 1), ypos3.get(i - 1), xpos3.get(i), ypos3.get(i));
    }
  }
  //Created by Theo SK -
  //This is a dynamic box that appears when a user hovers over one of the points - it displays the information of the data point.  
  void dynamicValuesBoxHover(){
    for(int i = 0; i < company1.size(); i++){
      if(mouseX > xpos1.get(i) && mouseX < xpos1.get(i)+6 && mouseY > ypos1.get(i) && mouseY < ypos1.get(i)+6){
        dynamicValuesBox(company1, pink, i);  
      }
    }
    for(int i = 0; i < company2.size(); i++){
      if(mouseX > xpos2.get(i) && mouseX < xpos2.get(i)+6 && mouseY > ypos2.get(i) && mouseY < ypos2.get(i)+6){
        dynamicValuesBox(company2, green, i); 
      }
    }
    for(int i = 0; i < company3.size(); i++){
      if(mouseX > xpos3.get(i) && mouseX < xpos3.get(i)+6 && mouseY > ypos3.get(i) && mouseY < ypos3.get(i)+6){
         dynamicValuesBox(company3, red, i); 
      }
    }
  }
  void dynamicValuesBox(ArrayList<DataPoint> points, color boxColor, int i){
      float vBWidth = 140; 
      float vBLength = 150; 
      String displayValues = "";
      displayValues = points.get(i).ticker+"\n"+dataType+": "+
       (dataType == "Opening Price"? points.get(i).openPrice : dataType == "Closing Price"? points.get(i).closingPrice :
          dataType == "Adjusted closing price"? points.get(i).adjustedClose : "")
           +"\nDate: "+ points.get(i).date
           +"\nLow: "+points.get(i).low + "\nHigh: "+ points.get(i).high +"\nVolume: "+points.get(i).volume; 
      fill(boxColor);
      if(dataType == "Adjusted closing price") vBWidth += 40; 
      rect(mouseX, mouseY, vBWidth, vBLength); 
      textSize(11);
      fill(0); text(displayValues, mouseX+15, mouseY+15); 
  }
  color buttonC = pink;
  void displayStats(){
    int x = 1365; int y = 250; 
    int buttonW=80; int buttonY=30; 
    textSize(25); 
    fill(buttonC); 
    rect(x,y, buttonW, buttonY); fill(0); 
    text("Stats", x+2, y+buttonY-5); 
    if(mouseX > x && mouseX < x+buttonW && mouseY > y && mouseY < y+buttonY){
        buttonC = green; 
        textSize(11); fill(green); 
        rect(mouseX, mouseY, -500, 280); fill(0); 
        text(company1Ticker+"\nStats: "+"\nAvg Open price: $"+ String.format("%.2f", avgCompany1.openPrice)+"\nVolatility for period: "+String.format("%.2f", avgCompany1.volatility)
        +"\n\n"+company2Ticker+"\nStats: "+"\nAvg Open price: $"+ String.format("%.2f", avgCompany2.openPrice)+"\nVolatility for period: "+String.format("%.2f", avgCompany2.volatility)
        +"\n\n"+company3Ticker+"\nStats: "+"\nAvg Open price: $"+ String.format("%.2f", avgCompany3.openPrice)+"\nVolatility for period: "+String.format("%.2f", avgCompany3.volatility)
        ,mouseX-485, mouseY+15); 
      }
      else{
        buttonC = pink;
      }
  }
} 
