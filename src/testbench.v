module testbench();
reg clk;
reg reset;
wire [31:0] writedata, dataadr;
wire memwrite;
// instantiate device to be tested
top dut(clk, reset, writedata, dataadr, memwrite);
// initialize test
initial begin
  reset <= 1; #22;
  reset <= 0;
  $display("\t\t time \tdataadr\t\twritedata");
  $monitor("%d\t%d\t%d", $time, dataadr, writedata);
end
// generate clock to sequence tests
always begin
  clk <= 1; #5;
  clk <= 0; #5;
end
// If successful, it should write the value -5 to address 84
always @(negedge clk) begin
  if(memwrite) begin
    if(dataadr === 84 & writedata === -5) begin
      $display("Simulation succeeded");
      $stop;
    end
  end
end
endmodule