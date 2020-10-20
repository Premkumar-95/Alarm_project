# Alarm_project Description:
    
   In this project, output is an 8-bit ASCII value which is used to display time on the LCD display and input is a 4-bit BCD value.
   This project has 6 modules namely Time_generator,Controller,Key_register,Counter,Alarm_register,Display_driver.
   Time generator produces one_second ,one_minute signals.
   Controller generates control signals which controls remaining modules except Time_generator.
   Key_register is used to store the BCD value entered.This BCD value is fed to Counter and Alarm_register,these modules will loaded with these BCD value based on control signals.
   Counter is used to increment the current time or it can also used to store the current time.
   Alarm_register is used to store the alarm time.Output of Alarm_register,Counter and Key_register are given to Display_driver.Based on control signals, Display_driver converts anyone of the 4-bit BCD value to 8-bit ASCII value.
