-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : Callback to replace the memory with the contents of the
--           register.  Also changes the colour of the MR button if the
--           number to be placed in the memory is not 0 (ie if the memory
--           is not being cleared.  Puts the colour back if the memory is
--           being cleared.

class MINCOMMAND

inherit MODEL_COMMAND
        COLOUR_NAMES

feature {NONE}

  emptycolour, fullcolour : COLOR

feature 

  execute (mrbutton : CALC_BUTTON) is
  do
    memory.put_in_memory (register.value) 
 
    -- Tell the calculator that this is the end of the number, but we
    -- don't want to stack it as its destination was the memory.

    register.set_end_no_stack
    
    -- Work out whether to change the colour of the MR button to
    -- indicate that something is in the memory (remember that
    -- inserting 0 into the memory effectively clears it).
    
    !!emptycolour.make; !!fullcolour.make
    
    emptycolour.set_name (funccolour); fullcolour.set_name (mfullcolour)
    
    if (register.value.to_double = 0) then
      -- Clearing the memory, set the MR button colour back to normal.
      
      mrbutton.set_background_color (emptycolour)

    else
      -- There is a number in the memory, set the MR button colour to
      -- indicate this.
      
      mrbutton.set_background_color (fullcolour)
    end
  end

end
