
class BarChart
{
  private BackButton backButton; 
  float[] array = new float[8];
  String[] tickers = new String[8];
  DataPoint[] dataArray;
  String data;
  String date; 
  float largestValue;
  float multiplier;
  float store = 0;//this stores the largest value currently held by the eight values
  //constructor for the barchart takes a dataPoint array, a dataType like opening price and closing price etc, then it takes a date in the form of a day, month or year.
  BarChart(DataPoint[] dataArray, String dataType, String date)
  {
    backButton = new BackButton(SCREEN_BARCHART);
    this.dataArray = dataArray; 
    data = dataType;
    this.date = date;
    for(int i = 0; i < 8; i++)
    {
      tickers[i] = dataArray[i].ticker;
    }
    if (dataType == "Opening Price") 
    {

      for (int i = 0; i < 8; i++)
      {
        DataPoint thisOne = new DataPoint();
        thisOne = dataArray[i];
        
        array[i] = thisOne.openPrice;
        println(array[i]);
      }
    }
    else if(dataType == "Closing Price")
    {
      for(int i = 0; i < 8; i++)
      {
        DataPoint thisOne = new DataPoint();
        thisOne = dataArray[i];
        
        array[i] = thisOne.closingPrice;
      }
    }
    else if(dataType == "Adjusted closing price")
    {
      for(int i = 0; i < 8; i++)
      {
        DataPoint thisOne = new DataPoint();
        thisOne = dataArray[i];
        
        array[i] = thisOne.adjustedClose;
      }
    }
    else if(dataType == "Volume")
    {
      for(int i = 0; i < 8; i++)
      {
        DataPoint thisOne = new DataPoint();
        thisOne = dataArray[i];
        
        array[i] = thisOne.volume;
      }
    }
    else if (dataType == "Volatility") 
    {

      for (int i = 0; i < 8; i++)
      {
        DataPoint thisOne = new DataPoint();
        thisOne = dataArray[i];
        array[i] = (float) thisOne.volatility;
        println(array[i]);
      }
    }
    //this finds the largest number passed in and then forms a multiplier from it.
    for (int i = 0; i < 8; i++)
    {
      if (array[i] > store)
      {
        store = array[i];
      }
    }
    multiplier = 750 / store;
  }
  void draw()
  {
    //the rectangles needed to visualise the data are all in set locations if the datapoints are empty then the rectangle formed is 0
    fill(pink);
    rect(975, 900 - (array[0] * multiplier), 75, array[0] * multiplier );
    fill(pink);
    rect(875, 900 - (array[1] * multiplier), 75, array[1] * multiplier);fill(red);
    rect(775, 900 - (array[2] * multiplier), 75, array[2] * multiplier);fill(green);
    rect(675, 900 - (array[3] * multiplier), 75, array[3] * multiplier);fill(pink);
    rect(575, 900 - (array[4] * multiplier), 75, array[4] * multiplier);fill(red);
    rect(475, 900 - (array[5] * multiplier), 75, array[5] * multiplier);fill(green);
    rect(375, 900 - (array[6] * multiplier), 75, array[6] * multiplier);fill(pink);
    rect(275, 900 - (array[7] * multiplier), 75, array[7] * multiplier);fill(255);

    rect(125, 100, 5, 1000);
    rect(5, 100, 100, 750); //Box on the left
    rect(0, 900, 1500, 5);
    fill(0);
    textSize(22); 
    for(int i = 0; i < 8; i++)
    {
      text(tickers[i].toUpperCase(), 10, (200+(40*i)));
    }
    text(data + " for "+ date, 500, 100);
    String holding;
    for(int i = 7; i >= 0; i--)
    {
      if(array[i] < 1000 && array[i] > 100){
      textSize(25); 
      holding = String.format("%.2f", array[i]);
      } else if (array[i] >= 1000){
      textSize(15); 
      holding = String.format("%.0f", array[i]);
      }
      else if (array[i] == 0){
        holding = ""; 
      } else{
        textSize(28); 
        holding = String.format("%.3f", array[i]);
      }
      text(holding,((1000-25) - (i * 100)),900- (array[i] * multiplier));
      text(tickers[i],((1000 - 25) - (i* 100)), 950);
    }
    backButton.draw();
  }
}
