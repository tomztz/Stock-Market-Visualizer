class Widget{  //Main widget class. (I.e a Button) 
  //Implemented by Theo SK (17/02/2020) 
  //Class is from lecture notes. 
  //Subclasses include BackButton, TextWidget, DateWidget and SearchBox. 
  int x, y, widgetSize, event; 
  int width, length; 
  String label, header; 
  String hoverMessage; 
  String hoverPosition; 
  color widgetColor, labelColor, headerColor;
  PFont widgetFont; 
  Widget(String label, String header, int x, int y, int width, int length, color widgetColor, color headerColor,
    PFont font, int event){
      this.x=x; this.y=y; this.label=label;
      this.event=event; this.widgetColor=widgetColor; this.widgetFont=font; this.headerColor=headerColor;
      this.header=header; 
      this.width = width;
      this.length = length;
      labelColor = 0;
    }
  void draw(){
    fill(widgetColor);
    rect(x,y,width,length); 
    if(header != null){ //If there is a header specified, draw it. Else, draw nothing for the header. 
      fill(headerColor);
      text(header, x+10, y-5);
    }
    fill(labelColor);
    text(label, x+(width/8), y+(length/2)+4);
  }
  int getEvent(int mouseX, int mouseY){//Checks if the mouse is in the bounds of the widget. 
    if(mouseX > x && mouseX < x+width && mouseY > y && mouseY < y+length){
      return event; 
    }
    else{
      return EVENT_NULL; 
    }
  }
  void widgetPressed(){
    widgetColor = green; 
  }
  void widgetError(){
    widgetColor = red;
  }
  void setHoverMessage(String message, String position){
    this.hoverMessage = message; 
    this.hoverPosition = position; 
  }
  void resetColor(){
    widgetColor = pink; 
  }
}
//Created by Theo SK. 
//Back button displayed in the corner that when pressed will revert back to the previous screen.
//Is used in all screens except in the main menu. 
class BackButton extends Widget{ 
  BackButton(int screenSwitch){
    super("", null, 0, 0, 25, 25, pink, 0, defaultFont, screenSwitch);
  }
  @Override  //Overriding draw method from widget. 
  void draw(){
    fill(widgetColor);
    rect(0, 0, 25, 25); //Box 
    backImage.resize(25,25); //Image size
    image(backImage, 0,0);
  }
  //Used instead of getEvent(), it instead immediately switches back the screen instead of returning an event. 
  void pressed(int mouseX, int mouseY){
     if(mouseX > x && mouseX < x+width && mouseY > y && mouseY < y+length){
       currentScreen = event; //Goes back to the backbutton's screen event. 
    }
  }
}
