function write_table2_line(measure, data)

fprintf('%-30s & %4.2f & (%4.2f) \\\\ \n', measure, mean(data), std(data));

end

