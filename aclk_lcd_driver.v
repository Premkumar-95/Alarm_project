//LCD_DRIVER_MODULE
module aclk_lcd_driver(show_a,show_new_time,alarm_time,current_time,key,
                       display_time,sound_alarm);
input show_a,show_new_time;
input [3:0]alarm_time,current_time,key;
output reg[7:0]display_time;
output reg sound_alarm;

function [7:0]_display_time(input[3:0] in_time);
parameter ZERO=4'b0000,ONE=4'b0001,TWO=4'b0010,THREE=4'b0011,FOUR=4'b0100,
          FIVE=4'b0101,SIX=4'b0110,SEVEN=4'b0111,EIGHT=4'b1000,NINE=4'b1001;
 begin
   case(in_time)
     ZERO   : _display_time=8'h30;
     ONE    : _display_time=8'h31;
     TWO    : _display_time=8'h32;
     THREE  : _display_time=8'h33;
     FOUR   : _display_time=8'h34;
     FIVE   : _display_time=8'h35;
     SIX    : _display_time=8'h36;
     SEVEN  : _display_time=8'h37;
     EIGHT  : _display_time=8'h38;
     NINE   : _display_time=8'h39;
     default: _display_time=8'h3A;
   endcase
  end
endfunction
always@(*)
 begin
  if(!show_a && !show_new_time)
   display_time=_display_time(current_time);
  else if(!show_a && show_new_time)
   display_time=_display_time(key);
  else if(show_a && !show_new_time) 
   display_time=_display_time(alarm_time);
  else
   display_time=_display_time(current_time); 
  if(alarm_time==current_time)
   sound_alarm=1'b1;
  else
   sound_alarm=1'b0;
 end
endmodule

