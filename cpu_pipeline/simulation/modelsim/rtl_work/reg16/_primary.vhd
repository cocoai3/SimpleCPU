library verilog;
use verilog.vl_types.all;
entity reg16 is
    port(
        q               : out    vl_logic_vector(15 downto 0);
        d               : in     vl_logic_vector(15 downto 0);
        load            : in     vl_logic;
        CLK             : in     vl_logic;
        RSTN            : in     vl_logic
    );
end reg16;
