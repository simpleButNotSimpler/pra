function s = getScale(Q, P, R)
    n = size(P, 1);
    s = zeros(2);
    
    for j=1:2
        den = 0;
        num = 0;
        
        T =  R * E(j);
        for i=1:n
           num = num +  Q(i, :) * T * transpose(P(i, :));
           den = den + P(i, :) * E(j) * transpose(P(i, :));
        end
        
        if den == 0
            den = 1;
        end
        
        s(j, j) = num/den;        
    end

end