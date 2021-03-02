
class DateIteration
{ 
  String date;
  String endDate;
  int month;
  int year;
  int days;
  int totaldays;
  int[]splitDate;
  int[]splitEndDate;
  int endYear;
  int endMonth;
  int endDays;
  int dayPassed;
  int totalDays;
  String ticker;
  String newDateString;
  DataPoint dataPoint;
  Date dateClass = new Date();
  ArrayList<DataPoint> getData(String date,String endDate,String ticker){
    ArrayList<DataPoint> returnedData = new ArrayList<DataPoint>(0); 
      splitDate=int(split(date,'/'));
      year=splitDate[2];
      month=splitDate[1];
      days=splitDate[0];
      
      splitDate=int(split(endDate,'/'));
      endYear=splitDate[2];
      endMonth=splitDate[1];
      endDays=splitDate[0];
      
      if(endYear>year){
       for(int i=year;i<endYear;i++){
         if(dateClass.isLeapYear(year)){
           dayPassed=dayPassed+366;
           }
        else{
           dayPassed=dayPassed+365;
          }
       }
      }
      if(endMonth>month){
        dayPassed=dayPassed+((endMonth-month)*12);
      }
      else{
         dayPassed=dayPassed-((month-endMonth)*12);
      }
       if(endDays>days){
          dayPassed=dayPassed+(endDays-days);
       }
      else{
        dayPassed=dayPassed-(days-endDays);
      }
      
    for(int i=0;i<dayPassed;i++){
        days=days+1;
        totalDays=dateClass.daysInMonth(month,year);
        if(days>totalDays){      
           month=month+1;
           days=days-totalDays;
        }
       else if(month>12){
           month=month-12;
           year=year+1;
         } 
       try{
       dateClass.date(days,month,year);
       newDateString=dateClass.getString();
       } 
       catch (Exception e){        
       }
     dataPoint = theData.extractTickerByDate(ticker, newDateString);
     if(!dataPoint.ticker.equals("")) returnedData.add(dataPoint); 
    }
    return returnedData; 
  }  
}
