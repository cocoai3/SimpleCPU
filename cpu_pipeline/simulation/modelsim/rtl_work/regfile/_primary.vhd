library verilog;
use verilog.vl_types.all;
entity regfile is
    port(
        q0              : out    vl_logic_vector(15 downto 0);
        q1              : out    vl_logic_vector(15 downto 0);
        q2              : out    vl_logic_vector(15 downto 0);
        q3              : out    vl_logic_vector(15 downto 0);
        q4              : out    vl_logic_vector(15 downto 0);
        q5              : out    vl_logic_vector(15 downto 0);
        q6              : out    vl_logic_vector(15 downto 0);
        q7              : out    vl_logic_vector(15 downto 0);
        load            : in     vl_logic;
        wsel            : in     vl_logic_vector(15 downto 0);
        d_a             : in     vl_logic_vector(15 downto 0);
        d_d             : in     vl_logic_vector(15 downto 0);
        CLK             : in     vl_logic;
        RSTN            : in     vl_logic
    );
end regfile;
