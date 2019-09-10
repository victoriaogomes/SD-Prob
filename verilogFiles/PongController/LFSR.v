module LFSR(
  input clock,
  input reset,
  output reg [4:0] rnd_Y,
  output reg rnd
);

reg [4:0] data_next;

always @* begin
  data_next[4] = rnd_Y[4]^rnd_Y[1];
  data_next[3] = rnd_Y[3]^rnd_Y[0];
  data_next[2] = rnd_Y[2]^data_next[4];
  data_next[1] = rnd_Y[1]^data_next[3];
  data_next[0] = rnd_Y[0]^data_next[2];
end

always @(posedge clock or negedge reset)
  if(!reset) begin
    rnd_Y <= 5'h1f;
    rnd <= rnd_Y[3];
  end
  else begin
    rnd_Y <= data_next;
    rnd <= data_next[2];
  end
endmodule
