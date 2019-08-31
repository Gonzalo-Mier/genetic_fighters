function [ outs ] = nn( format, weights_hl, input)

    N = length(format);
    layer{N} =[];
    layer{1} = input;  
    
    for i=1:N-1
        [A,~,C] = size(weights_hl{i});
        layer{i+1} = sigmf(reshape(weights_hl{i},[A,C])'*layer{i}',[8 0.5])';          
    end
    outs = layer{N};

end

