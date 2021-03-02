
//Data class contains an ArrayList of DataPoints - it firstly creates all DataPoints from a loaded string array & puts them
//into an ArrayList and sorts them using Collections. It is also contains multiple search & extract functions for accessing the DataPoints. 
//(using binary search). 
import java.util.Stack;
class Data{
  Stack<Integer> indexStack = new Stack<Integer>();   //Using a stack to temporarily store the indexs of items found in the searchFor function, so need to search again.
  ArrayList <DataPoint> dataArray = new ArrayList<DataPoint>(0); //This is the array list that contains the whole Data sheet. 
  String[] dataFile;
//Contrustor: 
  Data(String[] dataFile){
    this.dataFile = dataFile;
    separateData(this.dataFile); 
    sortData();
  }
//
//Theo SK:
//Separates each line and creates a DataPoint object for the line. Adds them to the DataPoint ArrayList dataArray. 
  private void separateData(String[] data){
  for(int i=0; i < data.length; i++){
     DataPoint theData = new DataPoint(); 
     theData.setDataString(data[i]); 
     dataArray.add(theData); 
    }
  }
  
//Search functions-------------------------------------------------------------------------------
  boolean searchForTicker(String identifier){    //This only searches for tickers, and returns true if it is there or false if not.
    boolean isPresent = false;                   //Also passes the index (if found) back to the indexStack (if it is being used).
    DataPoint c = new DataPoint();
    c.setTicker(identifier); 
    int indx = Collections.binarySearch(dataArray, c); //Using binary search to find the indx of the ticker given. 
    println(indx);
    if (indx < 0){
      isPresent = false;
    } else if (indx > 0){
      boolean outOfBounds = false;
      for(int i = indx; outOfBounds == false && dataArray.get(i-1).ticker.equals(identifier); i--){//As binary search seems to find the ticker but not the first, 
        indx--;                                                //this loop reduces the index until it is back to the first DataPoint of the ticker block. 
        if(i == 1) outOfBounds=true; 
      }
      isPresent=true;
      indexStack.push(indx);
    }
    return isPresent;
  }
//Theo SK. 
//Searches for a ticker and a date. If it is not a specificed date (i.e dd//mm/yyyy) it will return a DataPoint containing the averages for that time period. 
//Returns an empty DataPoint if not found at the date. 
DataPoint extractTickerByDate(String ticker, String date){ 
    ArrayList<DataPoint> avgData = new ArrayList<DataPoint>(0); 
    println(ticker+" "+date); 
    String inDate = date; 
    boolean isPresent = searchForTicker(ticker);
    println(isPresent); 
    boolean found = false;
    DataPoint returnPoint = new DataPoint();
    if (isPresent == true){
     if(inDate.length() == 10){//If the date specified is a very specific date (dd/mm/yyyy)
       int index = indexStack.pop();
       println(index);
       for(int i = index; i < dataArray.size() && dataArray.get(i).ticker.equals(ticker) && found != true; i++){
         if(dataArray.get(i).ticker.equals(ticker) && dataArray.get(i).date.equals(date)){
           returnPoint = dataArray.get(i); 
           found = false;
         }
       }
       return returnPoint;
    } else if (inDate.length() == 7){//If the date specified is just a month & a year (mm/yyyy)
      int index = indexStack.pop();
      String monYear;
      String[] splitDate;
      for(int i = index; i < dataArray.size() && dataArray.get(i).ticker.equals(ticker); i++){
        splitDate = split(dataArray.get(i).date, "/"); 
        monYear = splitDate[1]+"/"+splitDate[2]; 
        if(monYear.equals(date)){
          avgData.add(dataArray.get(i)); 
        }
      } //<>//
      returnPoint = queries.avgDataPoint(avgData); //<>//
    }
    else if (inDate.length() == 4){ //If the date specified is just a year (yyyy). 
      int index = indexStack.pop(); //Get index from index stack. 
      String monYear;
      String[] splitDate;
      for(int i = index; i < dataArray.size() && dataArray.get(i).ticker.equals(ticker); i++){
        splitDate = split(dataArray.get(i).date, "/");
        monYear = splitDate[2];
        if(monYear.equals(date)){
          avgData.add(dataArray.get(i)); 
        }
      } //<>//
       returnPoint = queries.avgDataPoint(avgData); //<>//
    }
    return returnPoint; 
 }
  else{
    println("Returning empty DataPoint. DataPoint was not present or name passed was empty."); 
    return returnPoint;
  }
 }
 ArrayList<DataPoint> extractTickers(String ticker){
    ArrayList<DataPoint> avgData = new ArrayList<DataPoint>(0);
    boolean isPresent = searchForTicker(ticker);
    if(isPresent){
      for(int i = indexStack.pop(); i < dataArray.size() && dataArray.get(i).ticker.equals(ticker); i++){
        avgData.add(dataArray.get(i)); 
      }
      return avgData; 
    } else {
      println("Returning empty array list. Ticker not found."); 
      return avgData;
    }
 } //<>// //<>//
//----------------------------------------------------------------------------------------------------

 private void sortData(){ //Sorts the DataPoints alphabetically using DataPoint's comparator. 
   Collections.sort(dataArray);
 }
}
