
//CompanyScroller is the box containing all of the companies names as seen in 
//the bar chart screen and the line chart screen. 
class CompanyScroller{
  PGraphics textBox = new PGraphics(); 
  String stocksString = ""; 
  String hoverMessage; 
  private PVector textBoxPos; 
  float scroll = 0; 
  int scrollMax = 300;
  SearchWidget searchBox;
  String searchEntry; 
  CompanyScroller(int x, int y){ //Only takes in position parameters. 
    textBoxPos = new PVector(x, y); 
    textBox = createGraphics(750, 500); //Creates a text box graphic with size 800, 200. 
    searchBox = new SearchWidget(int(textBoxPos.x+599), int(textBoxPos.y-20), 200, 20, "Search", pink,
      defaultFont, 32);
    stocksToString();
  }
  //stocksToString() creates a string containing all the names, tickers, sectors, etc of all of the companies present in the data sheet given to the program. 
  void stocksToString(){ 
    for(int i = 0; i < stocksInDataSheet.size(); i++){
      stocksString += (i == 0? "": "\n"); //if its the first one of the list, don't start another new line. 
      stocksString += stocksInDataSheet.get(i).getRealName()+"  -  "+ stocksInDataSheet.get(i).getRealTicker()
        +"  -  "+stocksInDataSheet.get(i).getRealSector()+"  -  "+ stocksInDataSheet.get(i).getRealIndustry(); 
    }
  }
  //TSK: Scroller's draw method. 
  void draw(){
   fill(pink); 
   rect(textBoxPos.x, textBoxPos.y-20, textBox.width-1, 20); 
   textSize(11); fill(0); 
   text("Name - Ticker - Sector - Industry", textBoxPos.x+10, textBoxPos.y-5); //Header
   searchBox.draw(); 
   textBox.beginDraw();         //Start drawing of graphic of the scroll box.    
    textBox.background(pink);  
    textBox.stroke(0,0,0);
    textBox.fill(0,0,0,0);
    textBox.rect(0, 0, textBox.width-1, textBox.height-1);  // Black rectangle around the outside.
    textBox.textSize(11);
    textBox.fill(0);
    textBox.text(stocksString, 10, 5+scroll);      //Text displayed is based on the value of scroll. 
  textBox.endDraw();
  image(textBox, textBoxPos.x, textBoxPos.y); 
  }
  //pressed() changes the focus scroller to the scroller pressed. 
  void pressed(int mouseX, int mouseY){ 
     if(mouseX > textBoxPos.x && mouseX < textBoxPos.x+textBox.width && mouseY > textBoxPos.y && mouseY < textBoxPos.y+textBox.height){
       focusScroller = this;  
    }
  }
  void setHoverMessage(String message){
    this.hoverMessage = message; 
  }
}
