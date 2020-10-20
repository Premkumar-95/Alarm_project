//LCD_DRIVER_UNIT
module aclk_lcd_driver_unit(show_a,show_new_time,
                            alarm_time_ms_hr,current_time_ms_hr,key_ms_hr,
                            alarm_time_ms_min,current_time_ms_min,key_ms_min,
                            alarm_time_ls_hr,current_time_ls_hr,key_ls_hr,                 
                            alarm_time_ls_min,current_time_ls_min,key_ls_min,
                            display_time_ms_hr,display_time_ms_min,
                            display_time_ls_hr,display_time_ls_min,
                            sound_alarm);
input show_a,show_new_time;
input [3:0] alarm_time_ms_hr,current_time_ms_hr,key_ms_hr;
input [3:0] alarm_time_ms_min,current_time_ms_min,key_ms_min;
input [3:0] alarm_time_ls_hr,current_time_ls_hr,key_ls_hr;                 
input [3:0] alarm_time_ls_min,current_time_ls_min,key_ls_min;
output [7:0]display_time_ms_hr,display_time_ms_min;
output [7:0]display_time_ls_hr,display_time_ls_min;                            
output wand  sound_alarm;
wire sound_alarm1,sound_alarm2,sound_alarm3,sound_alarm4;
aclk_lcd_driver LCD_DR1(show_a,show_new_time,
                        alarm_time_ms_hr,current_time_ms_hr,key_ms_hr,
                        display_time_ms_hr,sound_alarm1);
aclk_lcd_driver LCD_DR2(show_a,show_new_time,
                        alarm_time_ms_min,current_time_ms_min,key_ms_min,
                        display_time_ms_min,sound_alarm2);
aclk_lcd_driver LCD_DR3(show_a,show_new_time,
                        alarm_time_ls_hr,current_time_ls_hr,key_ls_hr,
                        display_time_ls_hr,sound_alarm3);
aclk_lcd_driver LCD_DR4(show_a,show_new_time,
                        alarm_time_ls_min,current_time_ls_min,key_ls_min,
								display_time_ls_min,sound_alarm4);
      assign sound_alarm=(sound_alarm1 && sound_alarm2 && sound_alarm3 && sound_alarm4);                  
endmodule


