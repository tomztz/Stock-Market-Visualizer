import java.util.Stack;
//Stores the entire stocks file given. 
class Stocks {
  ArrayList<SingleStock> stocksArray = new ArrayList<SingleStock>(0); //The arrayList containing the SingleStocks. 
  Stack<Integer> indexStack = new Stack<Integer>(); //For the use of searching when binary search is executed. 
  String[] stocksFile; 
  Stocks(String[] stocksFile){ //Takes in a stocks file as string array, and separates it using a delimiter. 
    this.stocksFile = stocksFile; 
    separateStocksFile(this.stocksFile); 
    sortStocks(); 
  }
  //Separates each of the stocks file and creates a SingleStock for the company/line. 
  private void separateStocksFile(String[] thisFile){
    for(int i=0; i < thisFile.length; i++){
      SingleStock thisStock = new SingleStock(thisFile[i]);
      stocksArray.add(thisStock); 
    }
  }
//Search functions------------------------------------------------------------------------
  boolean searchForName(String namePassed){
    boolean isPresent = false;
    SingleStock c = new SingleStock();
    c.setName(namePassed); 
    int indx = Collections.binarySearch(stocksArray, c);
    if (indx < 0){
      isPresent = false;
    } else if (indx > 0){
      isPresent = true;
      indexStack.push(indx);
    }
    return isPresent;
  }
  
  SingleStock extractStockFromName(String name){
    boolean isPresent = searchForName(name);
    if(isPresent == true){
      return stocksArray.get(indexStack.pop());
    }
    else{
      return new SingleStock();
    }
  }
  boolean searchForSector(String sectorPassed){
    boolean isPresent = false; 
    for(int i = 0; i < stocksArray.size() && isPresent == false; i++){
      if(stocksArray.get(i).getRealSector().equalsIgnoreCase(sectorPassed)){
        isPresent = true; 
      }
    }
    return isPresent; 
  }
  ArrayList<SingleStock> extractCompaniesFromSector(String sector){
    ArrayList<SingleStock> sectorCompanies = new ArrayList<SingleStock>(0); 
    boolean isPresent = searchForSector(sector); 
    if(isPresent == true){
      for(int i = 0; i < stocksArray.size(); i++){
        if(stocksArray.get(i).getRealSector().equalsIgnoreCase(sector)){
          sectorCompanies.add(stocksArray.get(i)); 
        }
      }
      return sectorCompanies; 
    } else {
     println("Sector does not exist. Please make sure the sector passed into extractCompaniesFromSector() exists first. Returning null arraylist."); 
     return sectorCompanies; 
    }
  }
  ArrayList<SingleStock> getStocksInDataSheet(ArrayList<DataPoint> theData){
    ArrayList<SingleStock> dataSheetStocks = new ArrayList<SingleStock>(0); 
    int indx; 
    DataPoint point = new DataPoint(); 
    for(int i = 0; i < stocksArray.size(); i++){
      point.setTicker(stocksArray.get(i).ticker);  
      indx = Collections.binarySearch(theData, point);
      if(indx > 0){
        dataSheetStocks.add(stocksArray.get(i)); 
      }
    }
    return dataSheetStocks; 
  }
  ArrayList<SingleStock> sectorStocksInDataSheet(String sector){
      ArrayList<SingleStock> returnedList = new ArrayList<SingleStock>(0); 
      for(int i = 0; i < stocksInDataSheet.size(); i++){
        if(stocksInDataSheet.get(i).getRealSector().equalsIgnoreCase(sector)){
          returnedList.add(stocksInDataSheet.get(i)); 
        }
      }
      return returnedList; 
  }
//-------------------------------------------------------------------------------------------
  String getTicker(int index){
    return stocksArray.get(index).ticker;
  }
  private void sortStocks(){
    Collections.sort(this.stocksArray); 
  }
}
