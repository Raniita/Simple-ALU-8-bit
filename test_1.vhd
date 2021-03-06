--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:47:48 05/10/2018
-- Design Name:   
-- Module Name:   /home/rani/Desktop/VHDL/ALU_2018/test_1.vhd
-- Project Name:  ALU_2018
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: alu2018
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY test_1 IS
END test_1;
 
ARCHITECTURE behavior OF test_1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu2018
    PORT(
         clk : IN  std_logic;
         reset_a : IN  std_logic;
         OP_in : IN  std_logic_vector(7 downto 0);
         A_in : IN  std_logic_vector(7 downto 0);
         B_in : IN  std_logic_vector(7 downto 0);
         A_out : OUT  std_logic_vector(7 downto 0);
         B_out : OUT  std_logic_vector(7 downto 0);
         TipoOP_out : OUT  std_logic_vector(1 downto 0);
         LEDs : OUT  std_logic_vector(7 downto 0);
         RESULTADO : OUT  std_logic_vector(7 downto 0);
         Signo : OUT  std_logic;
         Cero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset_a : std_logic := '0';
   signal OP_in : std_logic_vector(7 downto 0) := (others => '0');
   signal A_in : std_logic_vector(7 downto 0) := (others => '0');
   signal B_in : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal A_out : std_logic_vector(7 downto 0);
   signal B_out : std_logic_vector(7 downto 0);
   signal TipoOP_out : std_logic_vector(1 downto 0);
   signal LEDs : std_logic_vector(7 downto 0);
   signal RESULTADO : std_logic_vector(7 downto 0);
   signal Signo : std_logic;
   signal Cero : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: alu2018 PORT MAP (
          clk => clk,
          reset_a => reset_a,
          OP_in => OP_in,
          A_in => A_in,
          B_in => B_in,
          A_out => A_out,
          B_out => B_out,
          TipoOP_out => TipoOP_out,
          LEDs => LEDs,
          RESULTADO => RESULTADO,
          Signo => Signo,
          Cero => Cero
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
      OP_in <= "00000000";
      A_in <= "00000000";
      B_in <= "00000000";
      
      reset_a <= '0';
      
      wait for 100 ns;
      
      A_in <= "00000001";
      B_in <= "00001111";
      wait for 10 ns;
      OP_in <= "00000110";
      
      wait for 200 ns;
      
      A_in <= "00000001";
      B_in <= "00001111";
      OP_in <= "00001000";
      
      wait for 300 ns;
      
      reset_a <= '1';
      
      wait for 100 ns;
      
      wait;
   end process;

END;
