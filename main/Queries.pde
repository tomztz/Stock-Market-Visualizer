
class Queries
{
  float storeHighestOpening = 0;
  float holdingCumulative = 0;
  float average;
  float monopoly;
  float volatility;
  float cashFlow;
  //Cian Doyle
  //calculates whether there is a monopoly present in the sector
  void calculateMonopoly(ArrayList<DataPoint> companies)
  {
    for(int i = 0; i < companies.size(); i++)
    {
      DataPoint currentDataPoint = companies.get(i);
      float holding = currentDataPoint.openPrice;
      if(holding > storeHighestOpening)
      {
        storeHighestOpening = holding;
      }
    }
    for(int i = 0; i < companies.size(); i++)
    {
      DataPoint currentDataPoint = companies.get(i);
      holdingCumulative += currentDataPoint.openPrice;
    }
    average = holdingCumulative/companies.size();
    monopoly =storeHighestOpening / average;
  }
  void setCashFlow(DataPoint company)
  {
    float low = company.low;
    float high = company.high;
    volatility = low/ high;
    
    float averagePrice = (low + high) / 2;
    cashFlow = averagePrice * company.volume;
  }
//Created by Theo SK. 
//Calculates the average opening prices/closing prices/adjusted closing prices for a given DataPoint ArrayList. 
//Returns a DataPoint object that contains the averages in its attributes. If the list only contains 1 DataPoint, it returns 
//that DataPoint.
//Avg data points may also contain other statistics about the given data - i.e such as the volatility, increase/decrease, all time high price, etc. 
  DataPoint avgDataPoint(ArrayList<DataPoint> theData){ //<>//
    float avgOpen = 0; float avgClosing = 0; float avgVolume = 0; float avgAdjusted = 0;  //<>//
    DataPoint returned = new DataPoint();  //<>//
    for(int i = 0; i < theData.size(); i++){ //<>//
      avgOpen += theData.get(i).openPrice;  //<>//
      avgClosing += theData.get(i).closingPrice;
      avgAdjusted += theData.get(i).adjustedClose;
      avgVolume += theData.get(i).volume; 
    }
    if(theData.size() > 1){ //If the data given is not just 1 ticker (i.e a very specific date for the bar chart). 
       avgOpen = avgOpen/theData.size();
       avgClosing = avgClosing/theData.size();
       avgAdjusted = avgAdjusted/theData.size();
       avgVolume = avgVolume/theData.size();
       returned.volatility = calculateVolatility(theData, avgClosing); 
       returned.highestPrice = calculateAllTimeHighPrice(theData); 
       returned.priceRange = getRange(theData); 
       returned.avgPercGrowth = calculateAveragePercGrowth(theData); 
    } //<>//
    if(theData.size() > 0){
      returned.ticker = theData.get(0).ticker; 
    }
    returned.openPrice = avgOpen; 
    returned.closingPrice = avgClosing;
    returned.adjustedClose = avgAdjusted; 
    returned.volume = avgVolume; 
    return returned; 
  }
  //Theo SK
  //Function calculates the annualised volatility of a trading stock for a time period. 
  //Please see online for further details of the calculations being executed. 
   double calculateVolatility(ArrayList<DataPoint> data, float mean){
     double volatility = 0;
     double deviation; 
     for(int i = 0; i < data.size(); i++){//Calculating deviation from mean for each point. 
       deviation = mean - data.get(i).closingPrice;
       deviation *= deviation; 
       volatility += deviation;
     }
     volatility /= data.size(); 
     volatility = Math.sqrt(volatility); 
     volatility *= Math.sqrt(252); //252 is the number of trading days in a year. 
     return volatility; 
   }
  //Calculates the all time highest price for a company (using the data points high):
  float calculateAllTimeHighPrice(ArrayList<DataPoint> data){
    float highestPrice = 0; 
    for(int i = 0; i < data.size(); i++){
      if(data.get(i).high > highestPrice){
        highestPrice = data.get(i).high; 
      }
    }
    return highestPrice;
  }
  float calculateAllTimeLowPrice(ArrayList<DataPoint> data){
    float lowestPrice = data.get(0).low; 
    for(int i = 0; i < data.size(); i++){
      if(data.get(i).low < lowestPrice){
        lowestPrice = data.get(i).low; 
      }
    }
    return lowestPrice;
  }
  float calculateAveragePercGrowth(ArrayList<DataPoint> data){
    float returnPerc = 0; //percentage change overall. 
    float percDay = 0; //percentage change in a day. 
    for(int i = 0; i < data.size()-1; i++){
      percDay = ((data.get(i+1).closingPrice - data.get(i).closingPrice)/data.get(i).closingPrice)*100; 
      if(percDay > 0){
        returnPerc += percDay; 
      }
    }
    returnPerc /= data.size(); 
    return returnPerc; 
  }
  String getRange(ArrayList<DataPoint> data){
    float lowestPrice = calculateAllTimeLowPrice(data); 
    float highestPrice = calculateAllTimeHighPrice(data); 
    return "$"+String.format("%.2f", lowestPrice) + " - $" + String.format("%.2f", highestPrice); 
  }
}
