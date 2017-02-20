function [R, T] = getlst(moving, fixed)
    n = size(moving, 1);
    H = zeros(2 , 2);
    
    % centroids
    cm = sum(moving) / n;
    cf = sum(fixed) / n;
    
    %rotation matrix
    for i=1:n
        H = H + (moving(i, :) - cm)' * (fixed(i, :) - cf); 
    end
  
    %svd decomposition
    [U,~,V] = svd(H);
    
    %rotation matrix and translation vector
    R = V*U';
    T = cf'- R*cm';
end