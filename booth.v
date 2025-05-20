module booths_multiplier (
    input clk,
    input reset,
    input start,
    input signed [3:0] multiplicand,
    input signed [3:0] multiplier,
    output reg signed [7:0] product,
    output reg done
);

    reg signed [4:0] A;      // 1 bit more for sign extension
    reg signed [4:0] Q;
    reg Q_1;
    reg [2:0] count;

    reg [1:0] state;

    localparam IDLE = 2'b00,
               RUN  = 2'b01,
               DONE = 2'b10;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            A <= 5'b0;
            Q <= 5'b0;
            Q_1 <= 1'b0;
            count <= 3'd0;
            product <= 8'b0;
            done <= 1'b0;
            state <= IDLE;
        end else begin
            case (state)
                IDLE: begin
                    if (start) begin
                        A <= 5'b0;
                        Q <= {multiplier[3], multiplier}; // sign-extend multiplier
                        Q_1 <= 1'b0;
                        count <= 3'd4;
                        state <= RUN;
                        done <= 1'b0;
                    end
                end

                RUN: begin
                    case ({Q[0], Q_1})
                        2'b01: A <= A + {multiplicand[3], multiplicand};   // Add M
                        2'b10: A <= A - {multiplicand[3], multiplicand};   // Sub M
                        default: A <= A;
                    endcase

                    // Arithmetic right shift {A, Q, Q_1}
                    {A, Q, Q_1} <= {A[4], A, Q, Q_1} >>> 1;
                    count <= count - 1;

                    if (count == 1)
                        state <= DONE;
                end

                DONE: begin
                    product <= {A[3:0], Q[4:1]};  // Combine A and Q (ignoring extended sign bits)
                    done <= 1'b1;
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
