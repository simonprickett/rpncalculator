-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : Class to implement the calculator's register (the number
--           currently being worked on) and operations on that register.
--           Also contains the calculator's stack, used to store operands.

class CALC_REGISTER

inherit MVC_MODEL
	SINGLE_MATH             -- For the sin, cos, tan functions.
	FUNC_IDRS

creation reset 

feature {NONE}

  end_of_number : BOOLEAN       -- Determines when the end of a number is
				-- reached.
  error_state   : BOOLEAN       -- Determines whether the calculator is in an
				-- error state or not.

  -- The following are the maximum and minimum permitted values for the 
  -- calculator.
				
  minnumber : REAL is -9999999999999999999.0
  maxnumber : REAL is  9999999999999999999.0

  -- The following is a constant representing 360/(2*pi) used for calculating
  -- sin, cos, tan in degrees as the built in functions to do this work in
  -- radians.  Calculate this once to save doing it over and over.  Would
  -- have written this out as an expression but the Eiffel compiler refused to
  -- recognise this as something it could work out at compile time.

  conv_factor : REAL is 57.2957795131
				
  -- The following is a once only stack to hold the numbers being worked
  -- on.
  
  stack : LINKED_STACK[REAL] is
    once
      !!Result.make
    end
  
  validate_number (tovalidate : REAL) : BOOLEAN is
  do
    -- Checks that the number tovalidate is in the range of numbers allowed by
    -- the calculator.

    if (tovalidate > maxnumber) then
      set_error_state ("Error : Number too large!")
      Result := FALSE
    else
      if (tovalidate < minnumber) then
	set_error_state ("Error : Number too small!")
	Result := FALSE
      else
	Result := TRUE
      end
    end
  end

  set_error_state (errormsg : STRING) is
  do
    -- Puts the calculator into the error state, which displays an error
    -- message and won't let the calculator do anything until the error
    -- is cleared bypressing AC.

    value := clone (errormsg)
    error_state := TRUE
    notify_dependant
  end
 
  unset_error_state is
  do
    -- Takes the calculator out of the error state.

    error_state := FALSE
  end
 
  set_end_of_number is
  do
    -- Used to tell the system that numeric input has finished, or that
    -- the answer produced from a calculation is a number in its own right
    -- and cannot be modified directly.

    -- Don't do anything if in the error state.
  
    if (not error_state) then
      end_of_number := TRUE
      stack.put (value.to_real)
    end
  end
 
  unset_end_of_number is
  do
    -- Used to unset the end of number condition.

    end_of_number := FALSE
  end
 
feature

  value : STRING                -- The calculator's register for number input.
  
  reset is 
  do
    -- Clears out the current register value.

    -- Don't do anything if in the error state.

    if (not error_state) then 
      value := "0"
      notify_dependant
    end
  end
  
  complete_reset is
    local loopcounter : INTEGER
  do 
    -- Clear out the current register value, all values on the stack, and
    -- clears any error.

    unset_error_state
    
    from
      loopcounter := 0
    until
      stack.count = 0
    loop
      stack.remove
    end
    reset
  end

  set_end_no_stack is
  do
    -- Used to tell the system that numeric input is finished, but not
    -- to stack the number.  Only used by the Min command which indicates
    -- the end of a number but does not mean that it is to be stacked.
    
    end_of_number := TRUE
  end

  insert (toinsert : STRING) is
    local prevvalue : STRING
  do
    -- Used to make up numbers in the register.

    -- Don't do anything if in the error state.

    if (not error_state) then 
      prevvalue := clone (value)

      -- Remove the 0 if not entering a 0.x type number.   
      if ((equal (value, "0")) and (not (equal (toinsert, "."))) or
	  end_of_number) then
	value := toinsert
	unset_end_of_number
      else
	-- Add in the next digit.

	value.append (toinsert)
      end

      -- The following traps sillies, eg 2..1 by checking that what
      -- has been entered is a real number.
      
      if (not value.is_double) then
	value := prevvalue 
      end

      -- The following performs range checking on the number that has
      -- been entered.
      
      if (validate_number (value.to_real)) then
	notify_dependant
      end
    end
  end

  set_to (newvalue : STRING) is
  do
    -- Used to force a certain number into the register.  Primary
    -- use is for memory recall.

    -- Don't do anything if there's an error.

    if (not error_state) then
      value := clone (newvalue)
      set_end_of_number
      notify_dependant
    end
  end 

  change_sign is                  
  do
    -- Puts a - in front of the number if it didn't have one and takes it
    -- away if it did.

    -- Don't do anything if there's an error.
   
    if (not error_state) then

      -- Don't change sign if the value is 0, 0.0 etc...
      if (not (value.to_real = 0)) then
	if (value.has ('-')) then
	  value.remove (1)
	else
	  value.precede ('-')
	end 
	notify_dependant
      end
    end
  end

  enter is
  do
    -- Put the value in the register onto the top of the stack.

    -- Don't do anything if in the error state.
   
    if (not error_state) then
      set_end_of_number
    end
  end

  one_arg_func (functodo : INTEGER) is
    local answer : REAL 
  do
    -- Implements all one operand functions eg cos.
   
    -- Don't do anything if in the error state.

    if (not error_state) then

      -- Do an implied press of the Enter key if necessary.
      
      if (not end_of_number) then
	set_end_of_number
      end

      -- Check if the stack is empty, put the number on the
      -- stack if so.
    
      if (stack.count = 0) then
	stack.put (value.to_real)
      end
      
      -- Check that a valid operation is being attempted.
      
      if ( (((functodo = log2_) or (functodo = log10_) or (functodo = log_))
	   and (stack.item < 1)) or ((functodo = sqrt_) and (stack.item < 0)))
	 then
	-- Bad operation.
	
	set_error_state ("Error: Operation not defined on that number!")

      else
	 -- Perform the operation.
	 
	inspect functodo
	  -- For the trig functions, fiddle the input which will be in degrees
	  -- to be in radians, so that the right output is produced.

	  when cos    then answer := cosine  (stack.item / conv_factor)
	  when sin    then answer := sine    (stack.item / conv_factor)
	  when tan    then answer := tangent (stack.item / conv_factor)
	  when sqrt_  then answer := sqrt    (stack.item)
	  when log_   then answer := log     (stack.item)
	  when log10_ then answer := log10   (stack.item)
	  when log2_  then answer := log_2   (stack.item)
	end

	-- Remove the operand from the stack.

	stack.remove

	-- Range check the result.
      
	if (validate_number (answer)) then
	  -- Display the answer and store it on the stack top.

	  value := answer.out
	  set_end_of_number
	  notify_dependant
	end
      end
    end
  end
  
  two_arg_func (functodo : INTEGER) is
    local otheroperand, answer : REAL 
  do
    -- Performs two operand functions eg 3 4 +

    -- Don't do anything if in the error state.

    if (not error_state) then

      -- Do an implied press of the Enter key if necessary.

      if (end_of_number = FALSE) then
	set_end_of_number
      end

      -- Only do anything if there's operands to work with.
    
      if stack.count > 1 then
	-- Pick off an operand.

	otheroperand := stack.item
	stack.remove

	-- Check for attempted division by 0.

	if (not (otheroperand = 0 and functodo = div)) then  
	  inspect functodo
	    when add  then answer := stack.item + otheroperand
	    when mult then answer := stack.item * otheroperand
	    when sub  then answer := stack.item - otheroperand
	    when div  then answer := stack.item / otheroperand
	  end

	  -- Remove the second operand.

	  stack.remove
 
	  -- Range check the answer.

	  if (validate_number (answer)) then
	    -- Display the answer and stack it.
      
	    value := answer.out
	    set_end_of_number
	    notify_dependant
	  end
	else
	  set_error_state ("Error: Division by 0!")
	end
      end
    end
  end

end
