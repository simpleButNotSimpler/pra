function count = transb2w(mat)
    count = 0;
    for t=2:9
       if mat(t - 1) == 0 && mat(t) == 1
           count = count + 1;
       end
    end
end