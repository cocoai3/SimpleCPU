library verilog;
use verilog.vl_types.all;
entity muxreg16 is
    port(
        q               : out    vl_logic_vector(15 downto 0);
        d0              : in     vl_logic_vector(15 downto 0);
        d1              : in     vl_logic_vector(15 downto 0);
        d2              : in     vl_logic_vector(15 downto 0);
        d3              : in     vl_logic_vector(15 downto 0);
        d4              : in     vl_logic_vector(15 downto 0);
        d5              : in     vl_logic_vector(15 downto 0);
        d6              : in     vl_logic_vector(15 downto 0);
        d7              : in     vl_logic_vector(15 downto 0);
        load            : in     vl_logic;
        sel             : in     vl_logic_vector(2 downto 0);
        CLK             : in     vl_logic;
        RSTN            : in     vl_logic
    );
end muxreg16;
