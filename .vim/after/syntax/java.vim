


if v:version < 703
   " the default Java syntax file lacks the 'fold' option
   syn region javaFold start="{" end="}" transparent fold
endif
