function vector_downsampled = downsample(vector,step_size)
    vector_downsampled = zeros(floor(max(size(vector)/step_size)),1);
    k = 1;
    for counter=1:max(size(vector)):step_size
        vector_downsampled(k) = vector(counter);
        k = k + 1;
    end
end