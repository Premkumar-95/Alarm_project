//TIME_GENERATOR
module aclk_timegen(clk,reset,reset_count,fast_watch,one_second,one_minute);
 input clk,reset,reset_count,fast_watch;
 output reg one_second,one_minute;
 reg [13:0]count;
 reg one_minutereg;

 always@(posedge clk or posedge reset)
  begin
   if(reset)
    begin
     count<=14'b0;
     one_minutereg<=1'b0;
     end
   else if(reset_count)
    begin
     count<=14'b0;
     one_minutereg<=1'b0;
    end
   else if(count[13:0]==14'd15359)
    begin 
     count<=14'b0;
     one_minutereg=1'b1;
    end
   else
    begin
      count<=count+1'b1;
      one_minutereg=1'b0;
    end
  end

 always@(posedge clk or posedge reset)
  begin
   if(reset)
    begin
     one_second<=1'b0;
     end
   else if(reset_count)
    begin
     one_second<=1'b0;
    end
   else if(count[7:0]==8'd255)
    begin 
     one_second<=1'b1;
    end
   else
    begin
     one_second<=1'b0;
    end
  end

 always@(*)
  begin
   if(fast_watch)
    one_minute<=one_second;
   else
    one_minute<=one_minutereg;
  end

endmodule

