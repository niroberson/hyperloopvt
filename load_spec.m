function spec_raw = load_spec(spec_name)
%     Read in the json file
    spec_filename = [spec_name '.json'];
    spec_path = fullfile(pwd, 'Specs', spec_filename);
    fid = fopen(spec_path);
    raw = fread(fid, inf);
    str = char(raw');
    fclose(fid);
    spec_raw = JSON.parse(str);
    
%     Convert all structure fields to numbers
    constants = fields(spec_raw);
    for i=1:numel(constants)
        spec_raw.(constants{i}) = str2double(spec_raw.(constants{i}));
    end
    
end