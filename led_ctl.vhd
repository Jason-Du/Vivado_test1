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
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity led_ctl is
    Port ( rst_clk_rx   : in  std_logic;                    -- reset signal synchronized with clk_rx
           clk_rx       : in  std_logic;                    -- operational clock
           led_o        : out std_logic_vector(7 downto 0)  -- drives to LEDs
     );
end led_ctl;


architecture Behavioral of led_ctl is
  begin
    
    LEDCtrl: process (clk_rx)                                               -- process only sensitive to clock
      variable cnt : integer := 0;                                          -- cnt keeps track of the clocks for each LED       
      variable   led_buf : std_logic_vector(7 downto 0);                      -- internal buffer to keep track of LED state
      begin
        if rising_edge(clk_rx) then                     -- only on the rising edge of the clock (i.e. synchronous)
          if (rst_clk_rx = '1') then                    -- if the reset is active (sync reset)
            led_o            <= (others=>'0');          -- drive all the outputs low
            led_buf          := (others=>'0');          -- Keep track of the current state of the LED
            cnt              := 0;                      -- Reset the count
          else                                          -- not a reset condition
            cnt              := cnt+1;                  -- increment the counter
           
            -- Flash the 1st LED
            if ((cnt mod 5000000) = 0) then 
              led_buf(0) := NOT led_buf(0); 
            end if;
            -- Flash the 2nd LED
            if ((cnt mod 10000000) = 0) then
               led_buf(1) := NOT led_buf(1);
            end if;
            -- Flash the 3rd LED
            if ((cnt mod 20000000) = 0) then
               led_buf(2) := NOT led_buf(2);
            end if;
            -- Flash the 4th LED
            if ((cnt mod 40000000) = 0) then
               led_buf(3) := NOT led_buf(3);
            end if;
            -- Flash the 5th LED
            if ((cnt mod 80000000) = 0) then
               led_buf(4) := NOT led_buf(4);
            end if;
            -- Flash the 6th LED
            if ((cnt mod 160000000) = 0) then
               led_buf(5) := NOT led_buf(5);
            end if;
            -- Flash the 7th LED 
            if ((cnt mod 320000000) = 0) then
               led_buf(6) := NOT led_buf(6);
            end if;
            -- Flash the 8th LED 
            if ((cnt mod 640000000) = 0) then
               led_buf(7) := NOT led_buf(7);
            end if;

            -- Now output the internal buffered version to the port
            led_o <= led_buf;

          end if;                                      -- end of reset/normal operations
        end if;                                         -- end of synchronous events
      end process LEDCtrl;
    
end Behavioral;
