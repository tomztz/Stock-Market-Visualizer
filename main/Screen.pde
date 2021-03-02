
//Screen class contains all the draw methods for each screen. (Going according to the lecture slides). 
class Screen {
  ArrayList<Widget> buttonWidgets;
  ArrayList<TextWidget> textWidgets;
  CompanyScroller companyScroller; //Screen's company scroller.
  BackButton backButton; //Screen's back button. 
  color screenColor; 
  int screenEvent;
  int entriesAllowed; //Only for error showing for input pages like the bar chart screen / line chart screen. 
  //(Change made to account for the company scroller in the screens). 
  Screen(color screenColor, int screenEvent, BackButton backButton, int entriesAllowed) {
    this.screenColor = screenColor;
    this.screenEvent = screenEvent;
    this.backButton = backButton; 
    this.entriesAllowed = entriesAllowed; 
    buttonWidgets = new ArrayList<Widget>(0);
    textWidgets = new ArrayList<TextWidget>(0);
  }
  void draw() {
    switch(screenEvent) {
    case SCREEN_BARCHART://If the screen is on the barchart.
      textSize(16); 
      fill(0);
      text("This page displays a bar chart of prices (or average prices) for given companies at a specified time." +
        "\nYou can enter in either a year (yyyy), a month (mm/yyyy), or a specific day (dd/mm/yyyy)"
        +"\nPlease enter the various companys' names:", 40, 40);
      textSize(15); 
      drawWidgets();
      showButtonHovers(barChartScreen);
      fill(pink); 
      rect(746, 0, 8, 1500);
      barChartIcon.resize(358, 308); 
      image(barChartIcon, 946, 570);
      textFont(titleFont); 
      fill(0); 
      textSize(32); 
      text("Bar Charts", 946+(barChartIcon.width/2)-(textWidth("Bar Charts")/2), 935); 
      textFont(defaultFont); 
      textSize(16); 
      fill(pink); 
      backButton.draw();
      break;
    case SCREEN_MAIN1://If the screen is on the main menu. 
      textSize(32); 
      background(screenColor);
      mainIcon.resize(665, 665); 
      image(mainIcon, 800, 96);
      textFont(titleFont); 
      textSize(52); 
      text("Stocks App", 995, 800); 
      textFont(defaultFont); 
      textSize(22); 
      text("A project by Cian Doyle, Theo Stephens Kehoe and Tianze Zhang.", 800, 850); 
      fill(0);  
      drawWidgets();
      showButtonHovers(mainScreen);
      break;
    case SCREEN_LINECHART://If the screen is on the linechart. 
      textSize(14); 
      fill(0);
      text("This page displays a line chart for 3 user entered companies for a specific time period.\nThe user can select a selection of queries."
        +"\nThe date boxes allow dd/mm/yyyy, mm/yyyy or yyyy.", 40, 30);
      textSize(15); 
      fill(0); 
      drawWidgets(); 
      fill(pink); 
      rect(746, 0, 8, 1500);
      rect(746, 0, 8, 1500);
      lineChartIcon.resize(358, 308); 
      image(lineChartIcon, 946, 570);
      textFont(titleFont); 
      fill(0); 
      textSize(32); 
      text("Line Charts", 946+(lineChartIcon.width/2)-(textWidth("Line Charts")/2), 935); 
      textFont(defaultFont); 
      textSize(16); 
      fill(pink); 
      backButton.draw();
      break;
    case SCREEN_COMPANYVIEWER://If the screen is on the company viewer. 
      theCompanyViewer.draw();
      drawWidgets();
      showButtonHovers(companyScreen);
      backButton.draw(); 
      break;
    }
  }
  //Adds a button to the screen. 
  void addButton(Widget widget) {
    buttonWidgets.add(widget);
  }
  //Adds a text widget to the screen. 
  void addtextWidget(TextWidget widget) {
    textWidgets.add(widget);
  }
  //Draws all of the widgets associated with the screen. 
  void drawWidgets() {
    for (int i=0; i < buttonWidgets.size(); i++) {
      buttonWidgets.get(i).draw();
    }
    for (int i=0; i < textWidgets.size(); i++) {
      textWidgets.get(i).draw();
    }
    if (companyScroller != null) {
      companyScroller.draw();
    }
  }
  //Displays the hover text for a button in the screen (such as those in the main menu). 
  void showButtonHovers(Screen theScreen) {
    float hoverPosition; 
    //Hover messages for the buttons in a screen. 
    for (int i = 0; i < theScreen.buttonWidgets.size(); i++) {
      Widget b = theScreen.buttonWidgets.get(i); 
      if (b.hoverMessage != null) {
        if (mouseX > b.x && mouseX < b.x+b.width && mouseY > b.y && mouseY < b.y+b.length) {
          textSize(13); 
          fill(green); 
          hoverPosition = (b.hoverPosition == "left"? -textWidth(b.hoverMessage)-50 : 0);  
          rect(mouseX+hoverPosition, mouseY, textWidth(b.hoverMessage)+50, textAscent()+textDescent()+50); 
          fill(0);
          text(b.hoverMessage, mouseX+30+hoverPosition, mouseY+textDescent()+textAscent()+5);
        }
      }
    }
    //Hover messages for the text widgets in a screen. 
    for (int i = 0; i < theScreen.textWidgets.size(); i++) {
      Widget b = theScreen.textWidgets.get(i); 
      if (b.hoverMessage != null) {
        if (mouseX > b.x && mouseX < b.x+b.width && mouseY > b.y && mouseY < b.y+b.length) {
          textSize(13); 
          fill(green); 
          hoverPosition = (b.hoverPosition == "left"? -textWidth(b.hoverMessage)-50 : 0);  
          rect(mouseX+hoverPosition, mouseY, textWidth(b.hoverMessage)+50, textAscent()+textDescent()+50); 
          fill(0);
          text(b.hoverMessage, mouseX+30+hoverPosition, mouseY+textDescent()+textAscent()+5);
        }
      }
    }
    //Hover messages for company scollers.
    int displayTextTime = 0;
    if (companyScroller != null) {
      if (displayTextTime < 240) {//Display for 4 seconds before disappearing.
        CompanyScroller b = this.companyScroller; 
        if (mouseX > b.textBoxPos.x && mouseX < b.textBoxPos.x+b.textBox.width && mouseY > b.textBoxPos.y && mouseY < b.textBoxPos.y+b.textBox.height) 
        {
          textSize(13); 
          fill(green); 
          rect(mouseX, mouseY, textWidth(b.hoverMessage)+50, textAscent()+textDescent()+50); 
          fill(0);
          text(b.hoverMessage, mouseX+30, mouseY+textDescent()+textAscent()+5); 
          displayTextTime++;
        }
      }
    }
  }
}
