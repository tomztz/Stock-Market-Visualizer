class Queries
{
  float storeHighestOpening = 0;
  float holdingCumulative = 0;
  float average;
  float monopoly;
  float volatility;
  float cashFlow;
  Queries(ArrayList<DataPoint> companies)
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
  Queries(DataPoint company)
  {
    float low = company.low;
    float high = company.high;
    volatility = low/ high;
    
    float averagePrice = (low + high) / 2;
    cashFlow = averagePrice * company.volume;
  }
}
