----------------------------------------------------------------------------------
-- Company:        
-- Engineer:       Lance Simms
-- 
-- Create Date:    07/04/15
-- Design Name: 
-- Module Name:    clocked_led - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
------------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.all;

library UNISIM;
use UNISIM.VComponents.all;

entity clocked_led is
     Generic (CLOCK_RATE : integer := 200_000_000
             );
    Port ( clk_pin_p     : in  STD_LOGIC;
           clk_pin_n     : in  STD_LOGIC;
           rst_pin       : in  STD_LOGIC;
           led_pins      : out STD_LOGIC_VECTOR (7 downto 0)
         );
end clocked_led;


architecture Behavioral of clocked_led is

    --
    -- module definitions
    --    
    component led_ctl is
        Port ( rst_clk_rx         : in  std_logic;
               clk_rx             : in  std_logic;
               led_o              : out std_logic_vector(7 downto 0)
        );
    end component led_ctl;  
 
    component meta_harden is
        Port ( clk_dst            : in  std_logic;
               rst_dst            : in  std_logic;
               signal_src         : in  std_logic;
               signal_dst         : out std_logic
        );
    end component meta_harden;
 
    component clk_core is                   
        Port ( clk_in1_p          : in  std_logic; 
               clk_in1_n          : in  std_logic; 
               clk_out1           : out std_logic
        );                                     
    end component clk_core;                 

    -- clock and controls
    signal rst_i, rst_clk_rx      : std_logic := 'U';
    signal clk_i, clk_rx          : std_logic := 'U';
    signal rxd_i                  : std_logic := 'U';
    signal led_o                  : std_logic_vector(7 downto 0) := (others=>'U');
    
    constant vcc                  : std_logic := '1';
    constant gnd                  : std_logic := '0';
    

begin

    --
    -- define the buffers for the incoming data, clocks, and control
    IBUF_rst_i0:    IBUF    port map (I=>rst_pin, O=>rst_i);
    
    --
    clk_core_inst : clk_core port map ( clk_in1_p => clk_pin_p,              
                                        clk_in1_n => clk_pin_n,              
                                        clk_out1 => clk_rx                   
                                      );                               

    --
    -- define the buffers for the outgoing data
    OBUF_led_ix: for i in 0 to 7 generate
          OBUF_led_i: OBUF port map (I=>LED_o(i), O=>LED_pins(i));
       end generate;
       
    --
    -- instantiate a metastability hardener for the incoming reset
    meta_harden_rst_i0: meta_harden port map (rst_dst=>gnd, clk_dst=>clk_rx, signal_src=>rst_i, signal_dst=>rst_clk_rx);

    --
    -- instantiate the LED controller
    led_ctl_i0: led_ctl port map ( rst_clk_rx    => rst_clk_rx,
                                   clk_rx        => clk_rx,
                                   led_o         => led_o
                                  );
       
end Behavioral;
