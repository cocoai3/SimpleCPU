library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        q               : out    vl_logic_vector(15 downto 0);
        sr1             : in     vl_logic_vector(15 downto 0);
        sr2             : in     vl_logic_vector(15 downto 0);
        pc              : in     vl_logic_vector(15 downto 0);
        ir              : in     vl_logic_vector(15 downto 0);
        load            : in     vl_logic;
        CLK             : in     vl_logic;
        RSTN            : in     vl_logic
    );
end alu;
