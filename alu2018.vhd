----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:14:29 05/10/2018 
-- Design Name: 
-- Module Name:    alu2018 - Behavioral 
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu2018 is
    Port( 
          -- Reloj y reset 
          clk : in std_logic;
          reset_a : in std_logic;
        
          -- Entradas
          OP_in : in std_logic_vector(4 downto 0);
          A_in : in std_logic_vector(7 downto 0);
          B_in : in std_logic_vector(7 downto 0);
          
          -- Salidas
          A_out : out signed(8 downto 0);
          B_out : out signed(8 downto 0);
          TipoOP_out : out std_logic_vector(1 downto 0);
          LEDs :  out std_logic_vector(7 downto 0);
          -- Cambiar resultado a 7 downto 0
          Resultado : out signed(8 downto 0);
          Signo : out std_logic;
          Cero : out std_logic);
end alu2018;

architecture Behavioral of alu2018 is

-- Signals
signal OP : std_logic_vector(4 downto 0);
signal DatoA : signed(8 downto 0);
signal DatoB : signed(8 downto 0);
signal TipoOp : std_logic_vector(1 downto 0);
signal SalidaAluL : signed(8 downto 0);    
--signal SalidaAluH : signed(8 downto 0);

begin

ALU: process(clk, reset_a,OP,DatoA,DatoB) -- Cambiar la lista sensible para que sea acorde con lo nuevo
begin
    if(reset_a = '1') then
        OP <= (others => '0');
        DatoA <= (others => '0');
        DatoB <= (others => '0');
    end if;
    
    if (clk'event and clk = '1') then
        OP <= OP_in;
        -- Tambien podemos cambiar a (8 downto 0) y poner signed('0' & A_in)
        -- Verificar los signos de entrada, esto cambiar el signo a positivo
        DatoA <= signed(A_in(7) & A_in);
        DatoB <= signed(B_in(7) & B_in);
    end if;
   
   -- Crear un proceso nuevo para esto y que no dependa del reloj
   case OP is
        -- AND
        when "00001" => SalidaAluL <= DatoA AND DatoB;
        -- OR
        when "00010" => SalidaAluL <= DatoA OR DatoB;
        -- XOR
        when "00011" => SalidaAluL <= DatoA XOR DatoB;
        -- NAND
        when "00100" => SalidaAluL <= DatoA NAND DatoB;
        -- NOT 
        when "00101" => SalidaAluL <= NOT DatoA;
        
        -- RR  Revisar para los signos ya que tenemos la salida extendida para el signo
        when "00110" =>
            SalidaAluL <= '0' & DatoA(6 downto 0) & DatoA(7);
                            
        -- RL Igual que RR
        when "00111" =>
            SalidaAluL <= '0' & DatoA(0) & DatoA(7 downto 1); 
        
        -- addA0
        when "01000" => SalidaAluL <= DatoA + 0;
        
        -- addB0
        when "01001" => SalidaAluL <= (DatoB + 0);

        -- add A + B
        when "01010" => SalidaAluL <= (DatoA + DatoB);

        -- minnus A - B
        when "01011" => SalidaAluL <= (DatoA - DatoB);

        -- addA1
        when "01100" => SalidaAluL <= (DatoA +1);

        -- minnusA1
        when "01110" => SalidaAluL <= (DatoA -1);

        -- A*2
        when "01111" => SalidaAluL <= (DatoA(7 downto 0)&'0');

        -- A/2
        when "10000" => SalidaAluL <= (DatoA(8) & DatoA(8 downto 1));
    
        --|A|   Hacerlo de la manera no buena
        when "10001" => SalidaAluL <= (abs(DatoA));
            if(DatoA(8) = '0') then
                salidaAlu<= datoA;
                else
                salidaAlu <= not(datoA) + 1;

        --MAX(A,B)
        when "10010" =>
            if (DatoA > DatoB) then SalidaAluL <= DatoA;
                else SalidaAluL <= DatoB;
            end if;

        --MIN(A,B)
        when "10011" =>
            if (DatoA < DatoB) then 
                SalidaAluL <= DatoA;
            else SalidaAluL <= DatoB;
            end if;

        -- A > B
        when "10101" =>
            if (DatoA < DatoB) then
                SalidaAluL <= "000000001";
            else SalidaAluL <= (others => '0');
            end if;

        -- A < B
        when "10100" =>
            if (DatoA < DatoB) then 
                SalidaAluL <= "000000001";
            else SalidaAluL <= (others => '0');
            end if;

        -- A = B
        when "10110" =>
            if (DatoA = DatoB) then 
                SalidaAluL <= "000000001";
            else SalidaAluL <= (others => '0');
            end if;
        
        when others => SalidaAluL <= (others => '0');         
   end case;

end process;

CombTipoOP: process(OP)
begin
    -- Optimizar el if para reducir evaluaciones
    if(OP > "00000" AND OP <= "00111") then TipoOP <= "10";
    elsif (OP >= "01000" AND OP <= "10011") then TipoOP <= "01";
    elsif(OP >= "10100" AND OP <= "10110") then TipoOP <= "11";
    else TipoOp <= "00";
    end if;
end process;


-- Revisar el dibujo para que sean registros
CombCero: process(SalidaAluL)
begin
    if(SalidaAluL = "00000000") then
        Cero <= '1';
    else
        Cero <= '0';
    end if;
end process;

CombSigno: process(SalidaAluL,TipoOP)
begin
    if(TipoOP = "01" AND SalidaAluL(8) = '1') then
        Signo <= '1';
    else
        Signo <= '0';
    end if;
end process;

CombResultado: process(SalidaAluL,TipoOP)
begin
    if(TipoOP = "01") then 
        Resultado <= SalidaAluL;
    else 
        Resultado <= "000000000";
    end if;
end process;

CombLeds: process(SalidaAluL,TipoOP)
begin
    if(TipoOP = "10" OR TipoOP = "11") then
        LEDs <= std_logic_vector(SalidaAluL(7 downto 0));
    else
        LEDs <= "00000000";
    end if;
end process;

    A_out <= DatoA;
    B_out <= DatoB;
    
    -- Es un registro 
    TipoOP_out <= TipoOP;

end Behavioral;

