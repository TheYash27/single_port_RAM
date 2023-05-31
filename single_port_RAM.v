module single_port_RAM (
    input clock,
    input [5:0] address,
    input [7:0] write_data,
    input write_enable,
    output [7:0] read_data
);

reg [7:0] RAM [63:0];
reg [5:0] read_address;

always @(posedge clock) begin
    if (write_enable) RAM[address] <= write_data;
    else read_address <= address;
end

assign read_data = RAM[read_address];
    
endmodule

module Single_Port_RAM_Test_Bench ();
    
reg [7:0] write_data;
reg [5:0] address;
reg write_enable;
reg clock;
wire [7:0] read_data;

single_port_RAM uut(
    .write_data(write_data),
    .address(address),
    .write_enable(write_enable),
    .clock(clock),
    .read_data(read_data)
);

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, Single_Port_RAM_Test_Bench);

    clock = 1'b1;
    forever #50 clock = ~clock;
end

initial begin
    write_data = 8'd9;
    address = 6'd9;
    write_enable = 1'b1;

    #100;
    address = 6'd9;
    write_enable = 1'b0;

    #100;
    write_data = 8'd27;
    address = 6'd27;
    write_enable = 1'b1;

    #100;
    address = 6'd27;
    write_enable = 1'b0;

    #100;
    write_data = 8'd21;
    address = 6'd21;
    write_enable = 1'b1;

    #100;
    address = 6'd21;
    write_enable = 1'b0;
end
    
endmodule