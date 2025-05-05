class c_2_1;
    bit[0:0] pop = 1'h0;
    bit[0:0] push = 1'h0;

    constraint pop_c_this    // (constraint_mode = ON) (spi_seq_item.sv:46)
    {
       (pop != push);
    }
endclass

program p_2_1;
    c_2_1 obj;
    string randState;

    initial
        begin
            obj = new;
            randState = "zz1z0x01z0xz11zxxz0xz11zz100xz1xzzzxzzzxxzzzxxxxzxzzzzxzxzxxzxzz";
            obj.set_randstate(randState);
            obj.randomize();
        end
endprogram
