
//This is the entire company page that is viewed when a company is clicked in the company viewer.
//When the button is pressed, the button calls CompanyPage.set(company, user's date) and changes all variables for the CompanyPage object to 
//the company's data (i.e its sector, industry, exchange, opening price, adjusted close etc.). 
class CompanyPage{
  private String companyFocus; 
  private String date = "";
  private String name = "";
  private String sectorName = ""; 
  private String industry = ""; 
  private String exchange = ""; 
  SingleStock companyStock;
  ArrayList<DataPoint>  companyData = new ArrayList<DataPoint>(0);
  DataPoint avgData; 
  DataPoint timePoint; 
  ArrayList<SingleStock> sector;
  
  void set(String company){
    companyFocus = company;  
    setCompanyStock(); 
  }
  void draw(){
    if(companyStock != null){
      fill(lightPink); 
      rect(0, 0, 750, 1500); 
      textSize(25); fill(255); 
        text("Company: "+name, 50,50); 
        text("Sector: "+sectorName, 50, 100); 
        text("Exchange: "+exchange, 450, 100); 
        text("Industry: "+industry, 50, 150); 
        text("Showing data: "+date+":", 50, 200);
      textSize(13);
      drawData(); 
    }
  }
  void drawData(){
    if(avgData.priceRange != null){
      //Averages: 
      text("Average opening price: $"+String.format("%.2f", avgData.openPrice), 50, 300); 
      text("Average adjusted closing price: $"+String.format("%.2f", avgData.adjustedClose), 50, 350);
      text("Average volume (in units): "+String.format("%.0f", avgData.volume), 50, 400);
      text("Average volatility: "+String.format("%.2f", avgData.volatility) +"% per day", 50, 450);
      //
      text("All time highest price: $"+String.format("%.2f", avgData.highestPrice), 400, 300); 
      text("Range: "+avgData.priceRange, 400, 350);
      text("Average % growth (day-by-day): "+String.format("%.5f", avgData.avgPercGrowth)+"%", 400, 400);
    } else {
       textSize(22);
       text("No data present.", 50, 300);
       textSize(13); 
    }
  }
  void setCompanyStock(){
    companyStock = theStocks.extractStockFromName(companyFocus); 
    name = companyStock.getRealName(); 
    sectorName = companyStock.getRealSector(); 
    industry = companyStock.getRealIndustry(); 
    exchange = companyStock.getRealExchange(); 
    setCompanyData(); 
  }
  void setCompanyData(){
    companyData = theData.extractTickers(companyStock.ticker); 
    avgData = queries.avgDataPoint(companyData); 
  }
}
