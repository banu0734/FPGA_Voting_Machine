`timescale 1ns / 1ps

//====================================================
// Vote Counter
//====================================================

module vote_counter(

    input clk,
    input rst,

    input voteA,
    input voteB,
    input voteC,
    input voteD,
    input voteE,

    output reg [6:0] countA,
    output reg [6:0] countB,
    output reg [6:0] countC,
    output reg [6:0] countD,
    output reg [6:0] countE

);

always @(posedge clk)
begin

    if(rst)
    begin
        countA <= 7'd0;
        countB <= 7'd0;
        countC <= 7'd0;
        countD <= 7'd0;
        countE <= 7'd0;
    end

    else
    begin

        if(voteA && countA < 99)
            countA <= countA + 1;

        if(voteB && countB < 99)
            countB <= countB + 1;

        if(voteC && countC < 99)
            countC <= countC + 1;

        if(voteD && countD < 99)
            countD <= countD + 1;

        if(voteE && countE < 99)
            countE <= countE + 1;

    end

end

endmodule

//====================================================
// Edge Detector
//====================================================

module edge_detector(

    input clk,
    input signal_in,

    output pulse

);

reg delay;

always @(posedge clk)
begin
    delay <= signal_in;
end

assign pulse = signal_in & ~delay;

endmodule

//====================================================
// Display Selector
//====================================================

module display_selector(

    input [6:0] countA,
    input [6:0] countB,
    input [6:0] countC,
    input [6:0] countD,
    input [6:0] countE,

    input swA,
    input swB,
    input swC,
    input swD,
    input swE,

    output reg [6:0] vote_count,
    output reg [2:0] party

);

always @(*)
begin

    if(swA)
    begin
        vote_count = countA;
        party = 3'd0;
    end

    else if(swB)
    begin
        vote_count = countB;
        party = 3'd1;
    end

    else if(swC)
    begin
        vote_count = countC;
        party = 3'd2;
    end

    else if(swD)
    begin
        vote_count = countD;
        party = 3'd3;
    end

    else if(swE)
    begin
        vote_count = countE;
        party = 3'd4;
    end

    else
    begin
        vote_count = 7'd0;
        party = 3'd7;
    end

end

endmodule

//====================================================
// Clock Divider
//====================================================

module clock_divider(

    input clk,
    input rst,

    output reg refresh_clk

);

reg [16:0] counter;

always @(posedge clk)
begin

    if(rst)
    begin
        counter <= 17'd0;
        refresh_clk <= 1'b0;
    end

    else
    begin

        if(counter == 17'd49999)
        begin
            counter <= 17'd0;
            refresh_clk <= ~refresh_clk;
        end

        else
            counter <= counter + 1'b1;

    end

end

endmodule

//====================================================
// Binary to BCD
//====================================================

module binary_to_bcd(

    input [6:0] binary,

    output reg [3:0] hundreds,
    output reg [3:0] tens,
    output reg [3:0] ones

);

integer i;
reg [19:0] shift;

always @(*)
begin

    shift = 20'd0;
    shift[6:0] = binary;

    for(i=0;i<7;i=i+1)
    begin

        if(shift[11:8] >= 5)
            shift[11:8] = shift[11:8] + 3;

        if(shift[15:12] >= 5)
            shift[15:12] = shift[15:12] + 3;

        if(shift[19:16] >= 5)
            shift[19:16] = shift[19:16] + 3;

        shift = shift << 1;

    end

    hundreds = shift[19:16];
    tens     = shift[15:12];
    ones     = shift[11:8];

end

endmodule

//====================================================
// Seven Segment Controller
//====================================================

module seven_segment(

    input refresh_clk,

    input [2:0] party,

    input [3:0] hundreds,
    input [3:0] tens,
    input [3:0] ones,

    output reg [3:0] an,
    output [6:0] seg

);

reg [1:0] sel = 2'b00;

reg [3:0] digit;
reg [2:0] letter;

always @(posedge refresh_clk)
begin
    sel <= sel + 1;
end

always @(*)
begin

    case(sel)

    // Left-most digit = Party
    2'b00:
    begin
        an = 4'b0111;
        digit = 4'd0;
        letter = party;
    end

    // Second digit = Hundreds
    2'b01:
    begin
        an = 4'b1011;
        digit = hundreds;
        letter = 3'd7;
    end

    // Third digit = Tens
    2'b10:
    begin
        an = 4'b1101;
        digit = tens;
        letter = 3'd7;
    end

    // Right-most digit = Ones
    2'b11:
    begin
        an = 4'b1110;
        digit = ones;
        letter = 3'd7;
    end

    endcase

end

bcd_to_7seg DEC(

    .digit(digit),
    .letter(letter),
    .seg(seg)

);

endmodule

//====================================================
// BCD to Seven Segment Decoder
//====================================================

module bcd_to_7seg(

    input [3:0] digit,
    input [2:0] letter,

    output reg [6:0] seg

);

always @(*)
begin

    if(letter != 3'd7)
    begin

        case(letter)

            3'd0: seg = 7'b0001000; // A
            3'd1: seg = 7'b0000011; // b
            3'd2: seg = 7'b1000110; // C
            3'd3: seg = 7'b0100001; // d
            3'd4: seg = 7'b0000110; // E

            default: seg = 7'b1111111;

        endcase

    end

    else
    begin

        case(digit)

            4'd0: seg = 7'b1000000;
            4'd1: seg = 7'b1111001;
            4'd2: seg = 7'b0100100;
            4'd3: seg = 7'b0110000;
            4'd4: seg = 7'b0011001;
            4'd5: seg = 7'b0010010;
            4'd6: seg = 7'b0000010;
            4'd7: seg = 7'b1111000;
            4'd8: seg = 7'b0000000;
            4'd9: seg = 7'b0010000;

            default: seg = 7'b1111111;

        endcase

    end

end

endmodule

//====================================================
// Button Debounce
//====================================================

module button_debounce(

    input clk,
    input rst,
    input button,

    output reg button_out

);

reg [19:0] counter;
reg sync0, sync1;
reg stable_state;

always @(posedge clk)
begin

    sync0 <= button;
    sync1 <= sync0;

    if(rst)
    begin
        counter      <= 0;
        stable_state <= 0;
        button_out   <= 0;
    end

    else
    begin

        // Default: no pulse
        button_out <= 0;

        if(sync1 != stable_state)
        begin
            counter <= counter + 1;

            if(counter == 20'd99999)    // 1 ms debounce
            begin
                counter <= 0;
                stable_state <= sync1;

                // Generate ONE pulse only on rising edge
                if(sync1)
                    button_out <= 1;
            end
        end

        else
        begin
            counter <= 0;
        end

    end

end

endmodule

//====================================================
// Top Module
//====================================================

module top(

    input clk,
    input rst,

    input btnA,
    input btnB,
    input btnC,
    input btnD,
    input btnE,

    input swA,
    input swB,
    input swC,
    input swD,
    input swE,

    output [6:0] seg,
    output [3:0] an

);

//--------------------------------------------------
// Internal Wires
//--------------------------------------------------

wire dbA;
wire dbB;
wire dbC;
wire dbD;
wire dbE;


wire [6:0] countA;
wire [6:0] countB;
wire [6:0] countC;
wire [6:0] countD;
wire [6:0] countE;

wire [6:0] vote_count;
wire [2:0] party;

wire [3:0] hundreds;
wire [3:0] tens;
wire [3:0] ones;

wire refresh_clk;

//--------------------------------------------------
// Button Debounce
//--------------------------------------------------

button_debounce DB0(
    .clk(clk),
    .rst(rst),
    .button(btnA),
    .button_out(dbA)
);

button_debounce DB1(
    .clk(clk),
    .rst(rst),
    .button(btnB),
    .button_out(dbB)
);

button_debounce DB2(
    .clk(clk),
    .rst(rst),
    .button(btnC),
    .button_out(dbC)
);

button_debounce DB3(
    .clk(clk),
    .rst(rst),
    .button(btnD),
    .button_out(dbD)
);

button_debounce DB4(
    .clk(clk),
    .rst(rst),
    .button(btnE),
    .button_out(dbE)
);

//--------------------------------------------------
// Edge Detector
//--------------------------------------------------



//--------------------------------------------------
// Vote Counter
//--------------------------------------------------

vote_counter VC(

    .clk(clk),
    .rst(rst),

    .voteA(dbA),
    .voteB(dbB),
    .voteC(dbC),
    .voteD(dbD),
    .voteE(dbE),

    .countA(countA),
    .countB(countB),
    .countC(countC),
    .countD(countD),
    .countE(countE)

);

//--------------------------------------------------
// Display Selector
//--------------------------------------------------

display_selector DS(

    .countA(countA),
    .countB(countB),
    .countC(countC),
    .countD(countD),
    .countE(countE),

    .swA(swA),
    .swB(swB),
    .swC(swC),
    .swD(swD),
    .swE(swE),

    .vote_count(vote_count),
    .party(party)

);

//--------------------------------------------------
// Binary to BCD
//--------------------------------------------------

binary_to_bcd BCD(

    .binary(vote_count),

    .hundreds(hundreds),
    .tens(tens),
    .ones(ones)

);

//--------------------------------------------------
// Clock Divider
//--------------------------------------------------

clock_divider CD(

    .clk(clk),
    .rst(rst),

    .refresh_clk(refresh_clk)

);

//--------------------------------------------------
// Seven Segment Controller
//--------------------------------------------------

seven_segment DISP(

    .refresh_clk(refresh_clk),

    .party(party),

    .hundreds(hundreds),
    .tens(tens),
    .ones(ones),

    .an(an),
    .seg(seg)

);

endmodule
