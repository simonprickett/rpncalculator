-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : This is the main GUI class, all GUI objects made here.

class CALC_GUI

inherit MOTIF_APP redefine build, set_default end
	COLOUR_NAMES

creation make

feature {NONE}

  --  Define an array of push buttons to store the calculator's buttons.

  buttons : ARRAY[CALC_BUTTON]
 
  -- Need a display area to show results, and a form to collect all of
  -- the other widgets together on.
 
  disparea : LABEL
  widget_assembly : FORM
  
  -- These constants define the number of rows and columns for the buttons.
  
  numrows : INTEGER is 5
  numcols : INTEGER is 7

  -- Some constants to define sizes and spacing between buttons.

  buttonxsize   : INTEGER is 40
  buttonysize   : INTEGER is 40
  edgegap       : INTEGER is 10
  buttongap     : INTEGER is 1         -- Go for as close as possible.
  displayysize  : INTEGER is 30

  -- Some constants for the colours of the different widgets.
  
  --numcolour     : STRING is "cyan"     -- For the numeric keys and .
  --entercolour   : STRING is "green"    -- For the enter button.
  --funccolour    : STRING is "orange"   -- For operations eg +.
  --dangercolour  : STRING is "red"      -- For destructive ops eg AC.
  --dispcolour    : STRING is "yellow"   -- For the display area background.
	
  set_default is
    do  
      -- As this is a reverse polish calculator which essentially works
      -- backwards, Reverse Polish Calculator backwards would seem an 
      -- ideal name.
      
      application_name := "rotaluclaC hsiloP esreveR"
    end

  build is
    do
      -- How to build the GUI.

      create_widgets
      size_widgets
      set_base_props
      attach_widgets
      add_commands
      create_view
    end
  
  set_base_props is
    do
      -- Set up properties of the application base.
      
      base.set_icon_name ("RPN Calc")
      base.forbid_resize
    end
    
  create_widgets is
    local
    
      -- The numeric button objects that make up the calculator.
      
      button0, button1, button2, button3, button4, button5, button6, 
      button7, button8, button9, 
      
      -- About... and decimal point.
      
      buttona, buttondot, 
      
      -- Plus minus times and divide.
      
      buttonp, buttonm, buttonx, buttond, 
      
      -- Other supported functions (cs = change sign).
      
      buttoncos, buttonsin, buttontan, buttoncs, buttonlog, buttonlog2, buttonlog10,
      buttonsqrt,
      
      -- C, AC, memory in and memory recall (no need for memory clear as 
      -- this is the same as entering 0 into the memory).
      
      buttonc, buttonac, buttonmin, buttonmr, 
      
      -- The enter button is required for a reverse polish calculator to 
      -- know when a number input finishes (otherwise, how is 3 4 could
      -- be interpreted as 34 or 3 followed by 4).
      
      buttonenter : CALC_BUTTON
      
      -- Colour objects, required to do colour changes.
      
      func_colour, danger_colour, disp_colour, enter_colour, num_colour : COLOR
    do
    
      -- Create the objects required for the GUI.
      
      !!widget_assembly.make ("form", base)
     
      -- Set the colours up.
      
      !!disp_colour.make; !!func_colour.make; !!danger_colour.make
      !!num_colour.make;  !!enter_colour.make
      
      disp_colour.set_name (dispcolour);  num_colour.set_name (numcolour)
      func_colour.set_name (funccolour);  danger_colour.set_name (dangercolour)
      enter_colour.set_name (entercolour)
      
      -- Make the buttons.
      
      !!button0.make     ("0",     num_colour,    widget_assembly)
      !!button1.make     ("1",     num_colour,    widget_assembly)
      !!button2.make     ("2",     num_colour,    widget_assembly)      
      !!button3.make     ("3",     num_colour,    widget_assembly)
      !!button4.make     ("4",     num_colour,    widget_assembly)       
      !!button5.make     ("5",     num_colour,    widget_assembly)
      !!button6.make     ("6",     num_colour,    widget_assembly)
      !!button7.make     ("7",     num_colour,    widget_assembly)
      !!button8.make     ("8",     num_colour,    widget_assembly)       
      !!button9.make     ("9",     num_colour,    widget_assembly)
      !!buttonp.make     ("+",     func_colour,   widget_assembly)
      !!buttonm.make     ("-",     func_colour,   widget_assembly)
      !!buttonx.make     ("x",     func_colour,   widget_assembly)       
      !!buttond.make     ("/",     func_colour,   widget_assembly)
      !!buttondot.make   (".",     num_colour,    widget_assembly)   
      !!buttona.make     ("About", func_colour,   widget_assembly)
      !!buttonc.make     ("C",     danger_colour, widget_assembly)       
      !!buttonac.make    ("AC",    danger_colour, widget_assembly)
      !!buttonmin.make   ("Min",   func_colour,   widget_assembly)
      !!buttonmr.make    ("MR",    func_colour,   widget_assembly)
      !!buttonenter.make ("Enter", enter_colour,  widget_assembly)
      !!buttoncos.make   ("Cos",   func_colour,   widget_assembly)
      !!buttonsin.make   ("Sin",   func_colour,   widget_assembly)
      !!buttontan.make   ("Tan",   func_colour,   widget_assembly)
      !!buttoncs.make    ("+/-",   func_colour,   widget_assembly)
      !!buttonlog2.make  ("Log2",  func_colour,   widget_assembly)
      !!buttonlog.make   ("Ln",    func_colour,   widget_assembly)   
      !!buttonlog10.make ("Log",   func_colour,   widget_assembly)
      !!buttonsqrt.make  ("Sqrt",  func_colour,   widget_assembly)
      
      -- Make the display area.
      
      !!disparea.make ("value", widget_assembly)
      
      -- Set the initial thing to be displayed in the display area.

      disparea.set_text ("0")
 
       -- Make the display area right justified, like a real calculator.
      
      disparea.set_right_alignment
      
      -- Make the display area yellow.
      
      disparea.set_background_color (disp_colour)
      
      -- Store the buttons in an array for easy bulk assignment.
      -- Array is ordered as the buttons appear on the screen, from the
      -- bottom up.
      
      buttons := <<button0, buttondot, buttona, buttonp, buttoncs,  buttonsqrt,  buttonac, 
		   button1, button2  , button3, buttonm, buttontan, buttonlog2,  buttonc, 
		   button4, button5,   button6, buttond, buttoncos, buttonlog10, buttonmin, 
		   button7, button8,   button9, buttonx, buttonsin, buttonlog,   buttonmr, 
		   buttonenter>>
      
    end

  size_widgets is
    local x, y,                 -- Used for calculating sizes.
	  n    : INTEGER        -- Loop counter.
    do
      -- Work out the base size based on the number of
      -- rows, number of columns, button sizes and gaps...
      
      x := (numcols * buttonxsize) + ((numcols - 1) * buttongap) + (2 * edgegap)
      y := (numrows * buttonysize) + ((numrows - 1) * buttongap) + (2 * edgegap) +
	   (2 * displayysize)   
	   
	   -- 2 * displayysize is used to get a gap between the keys and 
	   -- the display.
	   
      -- Size the base frame for the calculator.
	   
      base.set_size (x, y)
      
      -- Size the display area for the calculator.
      
      disparea.set_size (x - (2 * edgegap), displayysize)
      
      -- Size all of the buttons.  Set them all to buttonxsize,
      -- buttonysize EXCEPT the Enter button which should be 
      -- twice as wide (as it will be used often).  The Enter
      -- button is the last member of the buttons array.
      
      from n := buttons.lower until n = buttons.upper loop
	 
	-- Set the size of the button.
	 
	buttons.item (n).set_size (buttonxsize,buttonysize)
	 
	-- Update the loop variable.
	 
	n := n + 1 
	 
      end

      -- Now deal with the Enter button which is the last one in the array.
      
      buttons.item (buttons.upper).set_size ((2 * buttonxsize) + buttongap, buttonysize)
      
    end

  attach_widgets is
    local 
       n, m : INTEGER           -- Loop counters.
    do
      -- Attach display area at 10 from top, left and right.

      widget_assembly.attach_top    (disparea, edgegap)
      widget_assembly.attach_left   (disparea, edgegap)
      widget_assembly.attach_right  (disparea, edgegap)
      widget_assembly.attach_bottom (disparea, edgegap + (numrows * buttonysize) + ((numrows - 1)
				     * buttongap) + displayysize)

      -- Attach the buttons as numcols columns and numrows rows.
      -- The inner loop does one row.
      
      from n := buttons.lower until n > (buttons.upper - 1) loop
	
	from m := 0 until m = numcols loop
	  
	  -- Process one row.
	     
	  if (m = 0) then
	    -- We're doing the first item in the row, so attach this
	    -- at edgegap from the edge.
	    
	    widget_assembly.attach_left (buttons.item (n), edgegap) 
	       
	  else
	    -- All subsequent items get attached relative to the previous
	    -- one.
	    
	    widget_assembly.attach_left_widget (buttons.item (n+m-1), buttons.item (n+m), 
					       buttongap)
	  end
					       
	  -- All subsequent items get attached relative to the edge if this is the
	  -- first row.
	    
	  if (n = buttons.lower) then
	    -- First row, attach bottoms relative to edge.
	      
	    widget_assembly.attach_bottom (buttons.item (buttons.lower + m), edgegap)
	    
	  else
	    -- Subsequent row, attach bottom relative to widget directly underneath this one if
	    -- this wasn't the first one in the row.  
	    
	    widget_assembly.attach_bottom_widget (buttons.item (n+m-numcols), buttons.item (n+m),
						  buttongap)
	  end                                        
	  
	  -- Increment loop counter so that we do another member of this row.
	  
	  m := m + 1
	  
	end
	
	-- Increment loop counter so that we go round and do another row.
	
	n := n + numcols

      end
      
      -- The last row is a special case as it only has the one button (Enter)
      -- which is the last one in the buttons array.

      widget_assembly.attach_bottom_widget (buttons.item (buttons.upper - 1), 
					    buttons.item (buttons.upper), buttongap)
      widget_assembly.attach_right (buttons.item (buttons.upper), edgegap)

    end

  create_view is
    local
      calc_view: MODEL_VIEW
    do
      -- Make the display area a view.

      !!calc_view.make (disparea)

    end

  add_commands is
    local
      b1    : B1COMMAND;   b2   : B2COMMAND;   b3 : B3COMMAND;     b4    : B4COMMAND;      b5  : B5COMMAND
      b6    : B6COMMAND;   b7   : B7COMMAND;   b8 : B8COMMAND;     b9    : B9COMMAND;      b0  : B0COMMAND
      ac    : ACCOMMAND;   c    : CCOMMAND;    bd : DOTCOMMAND;    cs    : CSCOMMAND;      mr  : MRCOMMAND
      min   : MINCOMMAND;  cos  : COSCOMMAND;  tan : TANCOMMAND;   sin   : SINCOMMAND;    add : ADDCOMMAND
      sqrt  : SQRTCOMMAND; log  : LOGCOMMAND;  log2 : LOG2COMMAND; log10 : LOG10COMMAND
      div   : DIVCOMMAND;  mult : MULTCOMMAND; sub : SUBCOMMAND;   enter : ENTERCOMMAND
      about : ABOUTCOMMAND

      commands : ARRAY[COMMAND]         -- For easy assignment of commands to buttons.
      loopcounter : INTEGER
    do
      -- Create the commands.

      !!b1; !!b2;  !!b3;  !!b4;  !!b5;  !!b6;   !!b7;  !!b8;   !!b9;    !!b0; !!ac; !!c; !!bd; !!cs
      !!mr; !!min; !!cos; !!sin; !!tan; !!sqrt; !!log; !!log2; !!log10; !!add; !!enter; !!sub
      !!div; !!mult; !!about

      -- Store them in the array.

      commands := << b0,   bd, about, add,  cs,  sqrt,  ac,
		     b1,   b2, b3,    sub,  tan, log2,  c,
		     b4,   b5, b6,    div,  cos, log10, min,
		     b7,   b8, b9,    mult, sin, log,   mr,
		     enter >> 

      -- And assign them to their buttons.
	    
      from 
	loopcounter := 1
      until
	loopcounter > buttons.upper
      loop
	-- Add command actions to buttons - two special cases, the Min button which needs
	-- to know about the MR button, and the About button which needs to know about the
	-- widget_assembly.

	inspect loopcounter
	  when 3  then buttons.item (loopcounter).add_activate_action (commands.item (loopcounter), 
								      widget_assembly)
	  when 21 then buttons.item (loopcounter).add_activate_action (commands.item (loopcounter),
								       buttons.item (28)) 
	  else 
	       buttons.item (loopcounter).add_activate_action (commands.item (loopcounter), void)
	end

	loopcounter := loopcounter + 1
      end 

    end 

end


