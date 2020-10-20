//CONTROLLER
module aclk_controller(clk,reset,one_second,alarm_button,time_button,key,
                       reset_count,load_new_c,show_new_time,show_a,load_new_a,shift);
 input clk,reset,one_second,alarm_button,time_button;
 input [3:0]key;
 output  reset_count,load_new_c,show_new_time,show_a,load_new_a;
 output wire shift;
 reg [6:0]state,nextstate;
 reg [3:0] count1,count2;
 wire time_out;
 parameter SHOW_TIME=7'd1,KEY_STORED=7'd2,KEY_WAITED=7'd4,KEY_ENTRY=7'd8,
           SET_ALARM_TIME=7'd16,SET_CURRENT_TIME=7'd32,SHOW_ALARM=7'd64;
//sequential logic
always@(posedge clk or posedge reset)
 begin
  if(reset) state<=SHOW_TIME; 
  else state<=nextstate;
 end
//next state decoding logic
always@( alarm_button or time_button or key or state or time_out)
 begin
   case(state)
    SHOW_TIME       : begin 
                       if(alarm_button) nextstate<=SHOW_ALARM;
                       else if(key!=4'd10) nextstate<=KEY_STORED;
                       else nextstate<=SHOW_TIME; 
                      end
    KEY_STORED      : nextstate=KEY_WAITED; 
    KEY_WAITED      : begin
                       if(key==4'd10) nextstate=KEY_ENTRY;
                       else if(time_out==0) nextstate=SHOW_TIME;
                       else nextstate=KEY_WAITED;
                      end
    KEY_ENTRY       : begin
                       if(alarm_button) nextstate=SET_ALARM_TIME; 
                       else if(time_button) nextstate=SET_CURRENT_TIME;
                       else if(time_out==0) nextstate=SHOW_TIME;
                       else if(key!=4'd10) nextstate=KEY_STORED;
                       else nextstate=KEY_ENTRY;
                      end
    SET_ALARM_TIME  : nextstate=SHOW_TIME;
    SET_CURRENT_TIME: nextstate=SHOW_TIME;                      
    SHOW_ALARM      : begin
                       if(!alarm_button) nextstate=SHOW_TIME;
                       else nextstate=SHOW_ALARM;
                      end
    default         : nextstate=SHOW_TIME;
   endcase
 end
//output logic
 assign reset_count=(state==SET_CURRENT_TIME)?1:0;
 assign load_new_c=(state==SET_CURRENT_TIME)?1:0;
 assign show_new_time=(state==KEY_ENTRY || state==KEY_STORED || state==KEY_WAITED)?1:0;
 assign show_a=(state==SHOW_ALARM)?1:0;
 assign load_new_a=(state==SET_ALARM_TIME)?1:0;
 assign shift=(state==KEY_STORED)?1:0;
//timers
always@(posedge clk or posedge reset)
 begin
  if(reset)
   count1<=4'd0;
  else if(!(state==KEY_WAITED))
   count1<=4'd0;
  else if(count1==9)
   count1<=4'd0;
  else if(one_second)
   count1=count1+1'b1;
 end
always@(posedge clk or posedge reset)
 begin
  if(reset)
   count2<=4'd0;
  else if(!(state==KEY_ENTRY))
   count2<=4'd0;
  else if(count2==9)
   count2<=4'd0;
  else if(one_second)
   count2=count2+1'b1;
 end
assign time_out=((count1==9) || (count2==9))?0:1;
endmodule
