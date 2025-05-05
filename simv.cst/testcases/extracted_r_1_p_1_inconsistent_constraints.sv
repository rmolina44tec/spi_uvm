class c_1_1;
    bit[0:0] pop = 1'h0;
    bit[0:0] push = 1'h0;

    constraint pop_c_this    // (constraint_mode = ON) (spi_seq_item.sv:46)
    {
       (pop != push);
    }
endclass

program p_1_1;
    c_1_1 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "00111zzxxzzz0xx1x0111xz111x11100xzzxzzxxzxzzxzzxxzxxzxxzzzzzxzxz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
