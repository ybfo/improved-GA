function v = Po(x)
    if x<=20
        v=100*x;
    elseif x<=40
        v=90*x+200;
    else
        v=80*x+600;
    end
end