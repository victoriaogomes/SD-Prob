module rand_YandPos(VGA_clk, rand_Y, rand_Pos);
  input VGA_clk;
  output reg [9:0] rand_Pos;
  output reg [8:0] rand_Y;
  reg [5:0] pointPos, pointY = 10;

  always @(posedge VGA_clk)
    pointPos <= pointPos + 3;
  always @(posedge VGA_clk)
    pointY <= pointY + 1;

  always @(posedge VGA_clk) begin
    if (pointPos >= 63)
      rand_Pos <= 620;
    else if (pointPos < 2)
      rand_Pos <= 20;
    else
      rand_Pos <= (pointPos * 10);
  end

  always @(posedge VGA_clk) begin
    if (pointY>=47) rand_Y <=460;
    else if (pointY<2) rand_Y <= 20;
    else rand_Y <= (pointY * 10);
  end

endmodule
