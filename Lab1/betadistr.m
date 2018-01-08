function u = betadistr( v, w )
%betadistr Generates a beta-distributed pseudorandom numbers
    while true
        s1 = rand ^ (1 / v);
        s2 = rand ^ (1 / w);
        
        if (s1 + s2 <= 1)
            break
        end
    end
    
    u = s1 / (s1 + s2);
end

