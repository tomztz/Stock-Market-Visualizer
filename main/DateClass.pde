
//constants
 final int MONTHS_IN_YEAR = 12;
 final int LENGTH_OF_MONTH = 31;
 final int LENGTH_OF_SHORTER_MONTH = 30;
 final int LENGTH_OF_FEBRUARY = 28;
 final int FEBRUARY_INDEX = 2;
 final int[] SHORTER_MONTHS = { 4, 6, 9, 11 };
public class Date {
    private int day, month, year;
    
   //check for invalid date
    void date(int day, int month, int year) throws Exception {
        if (day <= 0 || day > daysInMonth(month, year) ||
            month <= 0 || month > MONTHS_IN_YEAR)
            throw new Exception("Invalid date provided!");
        this.day = day;
        this.month = month;
        this.year = year;
    }
     int getDay() {
        return day;
    }
    int getMonth() {
        return month;
    }
     int getYear() {
        return year;
    }
    //convert to string function
     String getString() {
        return String.format("%02d",day) + "/" + String.format("%02d", month) + "/" + String.format("%02d", year);
    }
    // Returns the number of days in a month
    int daysInMonth(int month, int year) {
        for (int shortMonthIndex : SHORTER_MONTHS)
            if (month == shortMonthIndex){
                return LENGTH_OF_SHORTER_MONTH;}
        if (month == FEBRUARY_INDEX){
            return isLeapYear(year) ? LENGTH_OF_FEBRUARY + 1 : LENGTH_OF_FEBRUARY;}
        else return LENGTH_OF_MONTH;
    }

    // check if it is a leap year
    boolean isLeapYear(int year) {
        return year % 4 == 0 && (year % 100 != 0 || year % 400 == 0);
    }
}
