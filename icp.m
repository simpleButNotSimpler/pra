function [R, T, moving, angle, er] = icp(moving, fixed, ntimes, threshold, scaling)
    n = size(moving, 1);
    eri = 15200;
    Mdl = KDTreeSearcher(fixed);
    er = zeros(ntimes, 1);
    R = [1 0; 0 1];
    T = [0; 0];
    S = [1 0; 0 1];
    
    for t=1:ntimes
        %correspondance
        Idx = knnsearch(Mdl, moving);
        corrFixed = fixed(Idx, :);
        
        %least square transformation
        [Rn, Tn] = getlst(moving, corrFixed);
        
        %get the scale
        if scaling == 1
            S = getScale(corrFixed, moving, Rn);
        end
        
        
        %apply transformation
        moving = (Rn *S* moving' + repmat(Tn, 1, n))';
        %total transfrmation
        R = R*Rn;
        T = R*T + Tn;

        %rsm
        temp = (corrFixed - moving).^2;
        er(t) = sqrt( sum(sum(temp, 2)));
        
        if(eri - er(t)) < threshold || er(t) < threshold
            break;
        end
        
        eri = er(t);
    end
    
    angle = acos(R(1, 1)) * 180/pi;
end