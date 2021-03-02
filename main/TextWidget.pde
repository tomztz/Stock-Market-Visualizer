
//TextWidget extends Widget, adding a label that can be edited by the user.
//Contains a returned variable, that is set when the user presses enter (returned variable = the label when they hit enter). 
//Returns EVENT_TEXT when pressed. 
class TextWidget extends Widget {
  int maxLength; 
  String returnedEntry = ""; 
  int indx = 0; 
  boolean typeAfterError = true; 
  TextWidget(int x, int y, int width, int length, String label, String header, color widgetColor, color headerColor, 
    PFont font, int maxLength) {
    super(label, header, x, y, width, length, widgetColor, headerColor, font, EVENT_TEXT);
    this.maxLength=maxLength;
  }
  void append(char entry) {//This function is changing the text label / where user inputs. 
    if (typeAfterError == true) {//If the user got an error and is editing the text after, immediately clear the label. 
      label=""; 
      typeAfterError = false;
    }
    if (entry==BACKSPACE) { //Backspace deletion. Deletes the returnedEntry. 
      returnedEntry = "";
      println(header+" returnedEntry deleted."); 
      if (!label.equals("")) {
        widgetColor= pink;
        label=label.substring(0, label.length()-1);
      }
    } else if (entry==ENTER) {//User entering in their text. Calls the userHitEnter function (see function below). 
      userHitEnter(label);
    } else if (label.length() < maxLength 
      && (entry >= ' ' && entry <= '}')
      ) { //User input. Only allows letters and numbers. 
      println(header+" returnedEntry deleted.");
      returnedEntry = null;
      widgetColor = pink;
      label=label+str(entry);
    }
  }
  void userHitEnter(String entry) { //Function checks the entry. If the entry is not found, or is empty, it will return an error message.entry.toLowerCase();
    String passEntry = entry;
    passEntry = passEntry.toLowerCase();
    passEntry = passEntry.replaceAll(" ", "");
    boolean entryIs = theStocks.searchForName(passEntry);
    if (entry.equals("")) {
      widgetColor=green;
    } else if (entryIs == true) {
      widgetColor = green;
      returnedEntry = passEntry; 
      println(returnedEntry);
    } else {
      println(entryIs);
      widgetColor = red; 
      label="Company not found.";
      returnedEntry = "!error!"; 
      typeAfterError = true;
    }
  }
  String getEntry() {
    return returnedEntry;
  }
  void textWidgetError() {
    widgetColor = red;
    typeAfterError = true;
  }
}
//-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
//TSK: Date widget is an extenstion of text widget.
//Checks specifically if the numbers entered is a valid date (either dd/mm/yyyy, mm/yyyy, or yyyy). 
//If they are any of them, the returned entry is set to the label. 
class DateWidget extends TextWidget {
  String widgetType;
  DateWidget(int x, int y, int width, int length, String label, String header, color widgetColor, color headerColor, 
    PFont font, int maxLength, String widgetType) {
    super(x, y, width, length, label, header, widgetColor, headerColor, font, maxLength); 
    this.widgetType = widgetType; 
    this.returnedEntry = "!error!";
  }
  @Override
    void userHitEnter(String entry) {
    if (entry.contains("/")) {
      String[] entryStrings = split(entry, "/");
      if (entryStrings.length==2 && (widgetType.equals("BARCHART") || widgetType.equals("COMPANYVIEWER"))) {
        if ((entryStrings[0].matches("\\d+") && entryStrings[0].length() == 2) && (entryStrings[1].matches("\\d+") && entryStrings[1].length() == 4)) {
          widgetColor = green;
          returnedEntry = label;
        } else {
          textWidgetError();
          label="Please enter a valid date.";
        }
      } else if (entryStrings.length==3) {
        if ((entryStrings[0].matches("\\d+") && entryStrings[0].length() == 2)
          && (entryStrings[1].matches("\\d+") && entryStrings[1].length() ==2) && (entryStrings[2].matches("\\d++") && entryStrings[2].length() == 4)) {
          if ((Integer.parseInt(entryStrings[0]) <= 31) && (Integer.parseInt(entryStrings[1]) <= 12)) {
            widgetColor = green;
            returnedEntry = label;
          } else {
            textWidgetError();
            label="Please enter a valid date.";
          }
        } else {
          textWidgetError();
          label="Please enter a valid date.";
        }
      } else {
        textWidgetError();
        label="Please enter a valid date.";
      }
    } else if (entry.length()==4 && (widgetType.equals("BARCHART") || widgetType.equals("COMPANYVIEWER"))) {
      widgetColor = green;
      returnedEntry = label;
    } else {
      textWidgetError();
      label="Please enter a valid date.";
    }
  }
}
//TSK: Used by company scroller.
//SearchWidget extends the textWidget.
//Does nothing if the user hits enter. 
//Currently not used as at 12/04/2020. 
class SearchWidget extends TextWidget {
  SearchWidget(int x, int y, int width, int length, String label, color widgetColor, 
    PFont font, int maxLength) 
  {
    super(x, y, width, length, label, null, widgetColor, 0, font, maxLength);
    returnedEntry = ""; 
  }
  @Override 
    void userHitEnter(String entry) {
    //Do nothing if they hit enter
  }
  @Override
    void append(char entry) {
    if (typeAfterError == true) {//If the user got an error and is editing the text after, immediately clear the label. 
      label=""; 
      returnedEntry = label; 
      typeAfterError = false;
    }
    if (entry==BACKSPACE) { //Backspace deletion. Deletes the returnedEntry.  
      if (!label.equals("")) {
        label=label.substring(0, label.length()-1);
        returnedEntry = label; 
      }
    } else if (label.length() < maxLength 
      && (entry >= ' ' && entry <= '}')
      ) { //User input. Only allows letters and numbers. 
      label=label+str(entry);
      returnedEntry = label; 
    }
  }
}
