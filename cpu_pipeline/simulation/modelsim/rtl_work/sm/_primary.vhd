library verilog;
use verilog.vl_types.all;
entity sm is
    port(
        q               : out    vl_logic_vector(3 downto 0);
        start           : in     vl_logic;
        stop            : in     vl_logic;
        CLK             : in     vl_logic;
        RSTN            : in     vl_logic
    );
end sm;
