class CompanyViewer{
  //ArrayLists used
 ArrayList<SingleStock> companiesDisplayed = new ArrayList<SingleStock>(0); //Companies being displayed at a time
 ArrayList<SingleStock> companiesInSearch; 
 ArrayList<Widget> theButtons = new ArrayList<Widget>(0);   //Their respective buttons
 float scroll = 0; //For the scoll bar 
 int xPos = 750; int yPos = 0; //Position of the page 
 int buttonWidth = 600; int buttonLength = 20; //Dimensions of the buttons 
 String sectorInView = ""; 
 CompanyViewer(ArrayList<SingleStock> companiesPassed){
   theButtons = new ArrayList<Widget>(0); //Empties the button list to prevent the program from overloading the list.
   companiesDisplayed = companiesPassed; 
   intialiseButtons(companiesDisplayed); 
 }
 //set() does the exact same as the constructor, it is used when changing which buttons to display. 
 void set(ArrayList<SingleStock> companiesPassed, String sector){
   theButtons = new ArrayList<Widget>(0); //Empties the button list to prevent the program from overloading the list. 
   companiesDisplayed = companiesPassed; 
   intialiseButtons(companiesDisplayed); 
   sectorInView = sector; 
 }
 void draw(){
   fill(pink); 
   rect(xPos, yPos, 750, 1500);
   scroll(); 
   if(theButtons.size() > 0 ){ //Only display buttons if there are buttons. 
     for(int i = 0; i < theButtons.size(); i++){
       theButtons.get(i).draw(); 
     } 
   } else {
     text("No companies for this sector present.", 1000, 500); //Text that is displayed if there is no companies for a sector. 
   }
   //Company Viewer title box
   fill(pink); 
   rect(xPos, yPos, 450, 40); 
   textFont(titleFont); textSize(22); fill(0); 
   text("Company Viewer", xPos+20, yPos+28); 
   textFont(defaultFont); textSize(13); 
   //'Sector: ' bar: 
   fill(pink); rect(750, 40, 750, 20); 
   fill(0);  text("Select a sector: ", 760, 55); 
   //'Show in ' bar: 
   fill(pink); rect(750, 100, 750, 20); 
   fill(0);  text("Show: ", 760, 115);
   searchButtons(); 
   theCompanyPage.draw(); 
 }
 private void intialiseButtons(ArrayList<SingleStock> display){
   Widget companyButton; 
   for(int i = 0; i < display.size(); i++){
     companyButton = new Widget(display.get(i).getRealName(),"", xPos+100, 150+(i)*(buttonLength)+(i)*5, buttonWidth, buttonLength, 255, 0,
      defaultFont, i+1000);
     theButtons.add(companyButton); 
    }
 }
 private void scroll(){
  for(int i = 0; i < theButtons.size(); i++){
    theButtons.get(i).y += scroll;   
  }
 }
 void buttonsClicked(){
   int event;
   for(int i = 0; i < theCompanyViewer.theButtons.size(); i++){
    Widget currentButton = theButtons.get(i);
    event = currentButton.getEvent(mouseX, mouseY); 
    if(event > 1000){ //all button events for the stocks is 1000+ 
      theCompanyPage.set(companiesDisplayed.get(i).getCompanyName()); 
      focusButton(currentButton); 
    }
  }
 }
//searchButtons() is called when the user starts typing into the search widget. 
 void searchButtons(){
   SearchWidget userIn = (SearchWidget) companyScreen.textWidgets.get(0);
   if(userIn.getEvent(mouseX, mouseY) == EVENT_TEXT){
     if(userIn.returnedEntry != ""){
     companiesInSearch = new ArrayList<SingleStock>(0);
       for(int i=0; i < companiesDisplayed.size(); i++){
         if(companiesDisplayed.get(i).getRealName().toLowerCase().contains(userIn.label.toLowerCase())){ //Looks like a chunk full - it is just comparing the current label
            companiesInSearch.add(companiesDisplayed.get(i));                                           //to the names that are being currently displayed.  
         }
        }
     theButtons = new ArrayList<Widget>(0); //Empties the button list to prevent the program from overloading the list.
     intialiseButtons(companiesInSearch); 
     }
   }
 }
 private void focusButton(Widget thisButton){
   focusButton = thisButton; 
   focusButton.widgetPressed(); 
 }
}
