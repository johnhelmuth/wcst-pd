function absmax = absmax(arg)

if abs(min(arg)) >= abs(max(arg))
 absmax = min(arg);
else
 absmax = max(arg);
end

% alternatively 
% max(arg(abs(arg) == max(abs(arg))))


end