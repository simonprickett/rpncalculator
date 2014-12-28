-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : Callback for the About button, displays the About box.

class ABOUTCOMMAND

inherit COMMAND

feature {NONE}

  -- Message box to make the About box from.

  aboutbox          : MESSAGE_D 

feature

  execute (parent : FORM) is
    local okcommand : OKCOMMAND         -- Command for when OK button is pressed.
  do
    if (aboutbox = void) then
      -- Create it.
      
      !!aboutbox.make ("About", parent)

      -- Set up properties to make it only have one button, centred text etc...

      aboutbox.hide_cancel_button
      aboutbox.hide_help_button
      aboutbox.set_center_alignment
      aboutbox.forbid_resize
      aboutbox.set_message ("Reverse Polish Calculator%N%NWritten In ISE Eiffel By%N%NSimon Prickett 1996,%N%NFor CS313 Module.")

      -- Create and attach the OK button.

      !!okcommand
      aboutbox.add_ok_action (okcommand, aboutbox)
    end

    -- Display the box if not displayed already.

    if (not aboutbox.is_popped_up) then
      aboutbox.popup
    end
  end

end
