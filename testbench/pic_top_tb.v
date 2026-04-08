`timescale 1ns / 1ps

module pic_top_tb();

    // Inputs
    reg clk;
    reg reset;
    reg [7:0] irq;
    reg [7:0] mask;
    reg cpu_ack;

    // Outputs
    wire irq_req;
    wire [2:0] irq_to_cpu;

    // Instantiate the Unit Under Test (UUT)
    pic_top uut (
        .clk(clk), 
        .reset(reset), 
        .irq(irq), 
        .mask(mask), 
        .cpu_ack(cpu_ack), 
        .irq_req(irq_req), 
        .irq_to_cpu(irq_to_cpu)
    );

    // Clock generation (100MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;
        irq = 0;
        mask = 0;
        cpu_ack = 0;

        // Wait for Global Reset
        #20;
        reset = 0;
        #10;

        // --- Scenario 1: Basic Interrupt ---
        $display("Scenario 1: Triggering IRQ[3]");
        irq = 8'b0000_1000; // Bit 3 is high
        mask = 8'b0000_0000;
        
        // Wait for FSM to request
        wait(irq_req == 1);
        #20;
        $display("CPU acknowledging IRQ ID: %d", irq_to_cpu);
        cpu_ack = 1;
        #10;
        cpu_ack = 0;
        irq = 0; // Clear IRQ after ack

        // --- Scenario 2: Multiple Interrupts with Masking ---
        #30;
        $display("Scenario 2: Triggering Multiple IRQs with Masking");
        irq = 8'b1010_0000; // Bits 7 and 5 are high
        mask = 8'b1000_0000; // Mask bit 7
        
        // IRQ 5 should be the one serviced because 7 is masked
        wait(irq_req == 1);
        #10;
        if(irq_to_cpu == 3'd5)
            $display("Correct: IRQ 5 serviced, 7 was masked.");
        else
            $display("Error: Masking failed. Serviced ID: %d", irq_to_cpu);
            
        #10;
        cpu_ack = 1;
        #10;
        cpu_ack = 0;
        irq = 0;

        #50;
        $display("Simulation Finished");
        $finish;
    end
      
    initial begin
        $dumpfile("pic_top_waves.vcd");
        $dumpvars(0, pic_top_tb);
    end

endmodule
