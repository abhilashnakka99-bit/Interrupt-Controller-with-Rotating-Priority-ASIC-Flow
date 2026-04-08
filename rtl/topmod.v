// Top Level Module
module pic_top(
    input clk,
    input reset,
    input [7:0] irq,
    input [7:0] mask,
    input cpu_ack,
    output irq_req,
    output [2:0] irq_to_cpu
);

    wire [7:0] m_irq;
    wire [2:0] irq_id;
    wire [7:0] rotated_irq;
    wire valid;

    // Masking Logic
    mask u1(
        .m_irq(m_irq),
        .irq(irq),
        .mask(mask)
    );

    // Priority Encoder (Strict Priority)
    priority_enc u2(
        .irq(rotated_irq),
        .irq_id(irq_id),
        .valid(valid)
    );

    // FSM Controller (Registered Outputs)
    controller_fsm u3(
        .clk(clk),
        .reset(reset),
        .valid(valid),
        .irq_id(irq_id),
        .cpu_ack(cpu_ack),
        .irq_req(irq_req),
        .irq_to_cpu(irq_to_cpu)
    );

    // Rotating Priority Logic
    rotating_priority u4(
        .clk(clk),
        .reset(reset),
        .irq(m_irq),
        .cpu_ack(cpu_ack),
        .irq_id(irq_id),
        .rotated_irq(rotated_irq)    
    );

endmodule

// --- Sub-Modules ---

module priority_enc(
    output reg [2:0] irq_id,
    output reg valid,
    input [7:0] irq
);
    // Replaced casex with if-else for better synthesis/simulation matching
    always @(*) begin
        valid = 1'b1;
        if      (irq[7]) irq_id = 3'b111;
        else if (irq[6]) irq_id = 3'b110;
        else if (irq[5]) irq_id = 3'b101;
        else if (irq[4]) irq_id = 3'b100;
        else if (irq[3]) irq_id = 3'b011;
        else if (irq[2]) irq_id = 3'b010;
        else if (irq[1]) irq_id = 3'b001;
        else if (irq[0]) irq_id = 3'b000;
        else begin
            irq_id = 3'b000;
            valid  = 1'b0;
        end
    end
endmodule

module mask(
    output [7:0] m_irq,
    input [7:0] irq,
    input [7:0] mask
);
    assign m_irq = irq & ~mask;
endmodule

module rotating_priority(
    input clk,
    input reset,
    input [7:0] irq,
    input cpu_ack,
    input [2:0] irq_id,
    output [7:0] rotated_irq
);
    reg [2:0] priority_ptr;

    always @(posedge clk or posedge reset) begin
        if(reset)
            priority_ptr <= 3'd0;
        else if(cpu_ack)
            priority_ptr <= irq_id + 1'b1;
    end

    // Handling 8-bit rotation safely for synthesis tools
    // (irq << ptr) performs the rotation, while (irq >> (8-ptr)) handles the wrap-around
    assign rotated_irq = (irq << priority_ptr) | (irq >> (4'd8 - priority_ptr));
endmodule

module controller_fsm(
    output reg irq_req,
    output reg [2:0] irq_to_cpu,
    input clk,
    input reset,
    input valid,
    input [2:0] irq_id,
    input cpu_ack
);

    parameter IDLE     = 2'b00;
    parameter REQUEST  = 2'b01;
    parameter WAIT_ACK = 2'b10;

    reg [1:0] state;

    // State Transition Logic
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            state <= IDLE;
            irq_req <= 1'b0;
            irq_to_cpu <= 3'b000;
        end else begin
            case(state)
                IDLE: begin
                    irq_req <= 1'b0;
                    if(valid) state <= REQUEST;
                end

                REQUEST: begin
                    irq_req <= 1'b1;
                    irq_to_cpu <= irq_id; // Lock the ID being sent to CPU
                    state <= WAIT_ACK;
                end

                WAIT_ACK: begin
                    irq_req <= 1'b1;
                    if(cpu_ack) begin
                        irq_req <= 1'b0;
                        state <= IDLE;
                    end
                end
                
                default: state <= IDLE;
            endcase
        end
    end
endmodule
