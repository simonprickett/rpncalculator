-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : Contains the definitions of the names for the colours used
--           by the calculator GUI and the callback to Min (to make the memory
--           recall button change colour when there is a value in memory.

class COLOUR_NAMES

feature {NONE}

  -- Some constants for the colours of the different widgets.
  
  numcolour     : STRING is "cyan"     -- For the numeric keys and .
  entercolour   : STRING is "green"    -- For the enter button.
  funccolour    : STRING is "orange"   -- For operations eg +.
  dangercolour  : STRING is "red"      -- For destructive ops eg AC.
  dispcolour    : STRING is "yellow"   -- For the display area background.
  mfullcolour   : STRING is "green"    -- For when the memory is in use.
  
end
        
