library verilog;
use verilog.vl_types.all;
entity cpu is
    port(
        led             : out    vl_logic_vector(7 downto 0);
        seg0            : out    vl_logic_vector(15 downto 0);
        seg1            : out    vl_logic_vector(15 downto 0);
        seg2            : out    vl_logic_vector(15 downto 0);
        seg3            : out    vl_logic_vector(15 downto 0);
        seg4            : out    vl_logic_vector(15 downto 0);
        seg5            : out    vl_logic_vector(15 downto 0);
        seg6            : out    vl_logic_vector(15 downto 0);
        seg7            : out    vl_logic_vector(15 downto 0);
        seg8            : out    vl_logic_vector(15 downto 0);
        seg9            : out    vl_logic_vector(15 downto 0);
        sega            : out    vl_logic_vector(15 downto 0);
        segb            : out    vl_logic_vector(15 downto 0);
        segc            : out    vl_logic_vector(15 downto 0);
        segd            : out    vl_logic_vector(15 downto 0);
        sege            : out    vl_logic_vector(15 downto 0);
        segf            : out    vl_logic_vector(15 downto 0);
        start           : in     vl_logic;
        stop            : in     vl_logic;
        CLK             : in     vl_logic;
        RSTN            : in     vl_logic
    );
end cpu;
