library verilog;
use verilog.vl_types.all;
entity count16rle is
    port(
        q               : out    vl_logic_vector(15 downto 0);
        d               : in     vl_logic_vector(15 downto 0);
        load            : in     vl_logic;
        inc             : in     vl_logic;
        CLK             : in     vl_logic;
        RSTN            : in     vl_logic
    );
end count16rle;
