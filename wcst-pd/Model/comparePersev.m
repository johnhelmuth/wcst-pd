function pers_out = comparePersev(persCell,letter)

pers_out = 0; 

% Returns the number of last consecutive cells that have the letter 

persCell = persCell(1:length(find(~cellfun(@isempty, persCell) == 1))); % only non-empty cells

for cc = length(persCell):-1:1
    
  if ~isempty(strfind(persCell{cc},letter))
      pers_out = pers_out + 1; 
  else
      break;
  end
  
end



end