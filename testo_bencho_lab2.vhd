--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:25:17 05/11/2018
-- Design Name:   
-- Module Name:   /home/rani/Desktop/VHDL/ALU_2018/testo_bencho_lab2.vhd
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
USE ieee.numeric_std.ALL;
 
ENTITY testo_bencho_lab2 IS
END testo_bencho_lab2;
 
ARCHITECTURE behavior OF testo_bencho_lab2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT alu2018
    PORT(
         clk : IN  std_logic;
         reset_a : IN  std_logic;
         OP_in : IN  std_logic_vector(4 downto 0);
         A_in : IN  std_logic_vector(7 downto 0);
         B_in : IN  std_logic_vector(7 downto 0);
         A_out : OUT  signed(8 downto 0);
         B_out : OUT  signed(8 downto 0);
         TipoOP_out : OUT  std_logic_vector(1 downto 0);
         LEDs : OUT  std_logic_vector(7 downto 0);
         Resultado : OUT  signed(8 downto 0);
         Signo : OUT  std_logic;
         Cero : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset_a : std_logic := '0';
   signal OP_in : std_logic_vector(4 downto 0) := (others => '0');
   signal A_in : std_logic_vector(7 downto 0) := (others => '0');
   signal B_in : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal A_out : signed(8 downto 0);
   signal B_out : signed(8 downto 0);
   signal TipoOP_out : std_logic_vector(1 downto 0);
   signal LEDs : std_logic_vector(7 downto 0);
   signal Resultado : signed(8 downto 0);
   signal Signo : std_logic;
   signal Cero : std_logic;

   -- Clock period definitions
   constant clk_period : time := 20 ns;
 
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
          Resultado => Resultado,
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
      reset_a <= '1';		
      wait for 15 ns;
      reset_a <= '0';
      A_in <= "01110001";
      B_in <= "00110111";
      -- A AND B
      OP_in <= "00001";
      wait for 85 ns;
      A_in <= "01110001";
      B_in <= "00110111";
      -- A OR B
      OP_in <= "00010";
      wait for clk_period*5;
      -- A XOR B
      OP_in <= "00011";
      wait for clk_period*5;
      -- A NAND B
      OP_in <= "00100";
      wait for clk_period*5;
      -- NOT A
      OP_in <= "00101";
      wait for clk_period*5;
      -- RR A
      OP_in <= "00110";
      wait for clk_period*5;
      -- RL A
      OP_in <= "00111";
      wait for clk_period*5;
      -- A + 0
      OP_in <= "01000";
      wait for clk_period*5;
      -- B + 0
      OP_in <= "01001";
      wait for clk_period*5;
      -- A + B
      OP_in <= "01010";
      wait for clk_period*5;
      -- A - B
      OP_in <= "01011";
      wait for clk_period*5;
      -- A + 1
      OP_in <= "01100";
      wait for clk_period*5;
      -- A - 1
      OP_in <= "01101";
      wait for clk_period*5;
      -- MAX(A,B)
      OP_in <= "10010";
      wait for clk_period*5;
      -- MIN(A,B)
      OP_in <= "10011";
      wait for clk_period*5;
      -- 2*A
      OP_in <= "01111";
      wait for clk_period*5;
      -- A/2
      OP_in <= "10000";
      wait for clk_period*5;
      -- ABS(A)
      OP_in <= "10001";
      wait for clk_period*5;
      -- A < B
      OP_in <= "10100";
      wait for clk_period*5;
      -- A > B
      OP_in <= "10101";
      wait for clk_period*5;
      -- A = B
      OP_in <= "10110";
      wait for clk_period*5;
      
      A_in <= "11110001";
      -- A + 0
      OP_in <= "01000";
      wait for clk_period*5;
      -- A + B
      OP_in <= "01010";
      wait for clk_period*5;
      -- A - B 
      OP_in <= "01011";
      wait for clk_period*5;
      -- A + 1
      OP_in <= "01100";
      wait for clk_period*5;
      -- A - 1
      OP_in <= "01110";
      wait for clk_period*5;
      -- MAX(A,B)
      OP_in <= "10010";
      wait for clk_period*5;
      -- MIN(A,B)
      OP_in <= "10011";
      wait for clk_period*5;
      -- A < B
      OP_in <= "10100";
      wait for clk_period*5;
      -- A > B
      OP_in <= "10101";
      wait for clk_period*5;
      
      
      B_in <= "11110001";
      -- A = B
      OP_in <= "10110";
      wait for clk_period*5;
      -- 2*A
      OP_in <= "01111";
      wait for clk_period*5;
      -- A/2
      OP_in <= "10000";
      wait for clk_period*5;
      -- ABS(A)
      OP_in <= "10001";
      wait for clk_period*5;
      -- A - B
      OP_in <= "01011";
      wait for clk_period*5;
      -- A + B
      OP_in <= "01010";
      wait for clk_period*5;
      -- RR A
      OP_in <= "00110";
      wait for clk_period*5;
      -- RL A
      OP_in <= "00111";
      wait for clk_period*5;
      -- A XOR B
      OP_in <= "00011";
      wait for clk_period*5;
      
      wait;
   end process;

END;
