----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:54:41 03/07/2008 
-- Design Name: 
-- Module Name:    BramCfg - Structural 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- This is the Digilent BramCfg reference project. 
-- It is an example for transferring data between a Block RAM and a PC.
-- The BramCfg project instantiates a Block RAM and interfaces it to 
-- an Epp port (the Digilent OnBoard USB circuitry and firmware)
-- It is used in conjunction with a program running on a PC (a Digilent
-- utility as TransPort or a user generated application) which in turn
-- uses the APIs provided by Digilent Adept Suite.
--
-- The BramCfg project connects to Block RAM port A and leaves all 
-- port B signals "open". Port B can be used for extending the project.
--
-- For more details about using the project, see the 
-- Digilent BramCfg Reference Project Manual
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BramCfg is
   port ( 
-- Epp-like bus signals
      EppAstb: in std_logic;                       -- Address strobe
      EppDstb: in std_logic;                       -- Data strobe
      EppWr  : in std_logic;                       -- Port write signal
      EppDB  : inout std_logic_vector(7 downto 0); -- port data bus
      EppWait: out std_logic);                     -- Port wait signal

end BramCfg;

architecture Structural of BramCfg is

-- signals to interconnect the components
   signal BramDataOut   : std_logic_vector (7 downto 0);
   signal BramAdrIn     : std_logic_vector (10 downto 0);
   signal BramDataIn    : std_logic_vector (7 downto 0);
   signal BramWeIn      : std_logic;
   signal BramEnIn      : std_logic;
   signal BramClkIn     : std_logic;
   signal EppBusOut     : std_logic_vector (7 downto 0);
   signal EppBusIn      : std_logic_vector (7 downto 0);
   signal EppAdrOut     : std_logic_vector (4 downto 0);
   signal EppStbDataOut : std_logic;
   signal EppWrOut      : std_logic;
   signal selBramCtrl   : std_logic;

   signal XLXI_10_adrB_openSignal   : std_logic_vector (10 downto 0);
   signal XLXI_10_busDiB_openSignal : std_logic_vector (7 downto 0);
   signal XLXI_10_clkB_openSignal   : std_logic;
   signal XLXI_10_ctlEnB_openSignal : std_logic;
   signal XLXI_10_ctlWeB_openSignal : std_logic;


-- component declarations
   component EppCtrlAsync
      port ( EppAstb   : in    std_logic; 
             EppDstb   : in    std_logic; 
             EppWr     : in    std_logic; 
             busIn     : in    std_logic_vector (7 downto 0); 
             sel0      : inout std_logic; 
             sel2      : inout std_logic; 
             sel4      : inout std_logic; 
             sel6      : inout std_logic; 
             sel8      : inout std_logic; 
             selA      : inout std_logic; 
             selC      : inout std_logic; 
             selE      : inout std_logic; 
             EppDB     : inout std_logic_vector (7 downto 0); 
             EppWait   : out   std_logic; 
             stbData   : out   std_logic; 
             ctlrWr    : out   std_logic; 
             outEppAdr : out   std_logic_vector (4 downto 0); 
             busOut    : out   std_logic_vector (7 downto 0));
   end component;
   
   component BramComCtrl
      port ( stbData     : in    std_logic; 
             ctrlWr      : in    std_logic; 
             selBram     : in    std_logic; 
             busEppIn    : in    std_logic_vector (7 downto 0); 
             busEppAdrIn : in    std_logic_vector (4 downto 0); 
             busBramIn   : in    std_logic_vector (7 downto 0); 
             ctlWeBram   : out   std_logic; 
             clkBram     : out   std_logic; 
             busEppOut   : out   std_logic_vector (7 downto 0); 
             busBramAdr  : out   std_logic_vector (10 downto 0); 
             busBramOut  : out   std_logic_vector (7 downto 0); 
             ctlEnBram   : out   std_logic);
   end component;
   
   component BlockRam
      port ( ctlWeA : in    std_logic; 
             busDiA : in    std_logic_vector (7 downto 0); 
             busDoA : out   std_logic_vector (7 downto 0); 
             adrA   : in    std_logic_vector (10 downto 0); 
             ctlEnA : in    std_logic; 
             clkA   : in    std_logic; 
             ctlWeB : in    std_logic; 
             busDiB : in    std_logic_vector (7 downto 0); 
             busDoB : out   std_logic_vector (7 downto 0); 
             adrB   : in    std_logic_vector (10 downto 0); 
             ctlEnB : in    std_logic; 
             clkB   : in    std_logic);
   end component;
   
begin

-- component instantiations
   EppCtrlAsyncInst : EppCtrlAsync
      port map (busIn     => EppBusIn,
                EppAstb   => EppAstb,
                EppDstb   => EppDstb,
                EppWr     => EppWr,
                busOut    => EppBusOut,
                ctlrWr    => EppWrOut,
                EppWait   => EppWait,
                outEppAdr => EppAdrOut,
                stbData   => EppStbDataOut,
                EppDB     => EppDB,
                selA      => open,
                selC      => open,
                selE      => open,
                sel0      => selBramCtrl,
                sel2      => open,
                sel4      => open,
                sel6      => open,
                sel8      => open);
   
   BramComCtrlInst : BramComCtrl
      port map (busBramIn   => BramDataOut,
                busEppAdrIn => EppAdrOut,
                busEppIn    => EppBusOut,
                ctrlWr      => EppWrOut,
                selBram     => selBramCtrl,
                stbData     => EppStbDataOut,
                busBramAdr  => BramAdrIn,
                busBramOut  => BramDataIn,
                busEppOut   => EppBusIn,
                clkBram     => BramClkIn,
                ctlEnBram   => BramEnIn,
                ctlWeBram   => BramWeIn);
   
   BlockRamInst : BlockRam
      port map (adrA   => BramAdrIn,
                adrB   => XLXI_10_adrB_openSignal,
                busDiA => BramDataIn,
                busDiB => XLXI_10_busDiB_openSignal,
                clkA   => BramClkIn,
                clkB   => XLXI_10_clkB_openSignal,
                ctlEnA => BramEnIn,
                ctlEnB => XLXI_10_ctlEnB_openSignal,
                ctlWeA => BramWeIn,
                ctlWeB => XLXI_10_ctlWeB_openSignal,
                busDoA => BramDataOut,
                busDoB => open);
 
end Structural;
