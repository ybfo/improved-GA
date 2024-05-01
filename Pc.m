function v = Pc(x)
    if x<=5
        v=200*x;
    elseif x<=10
        v=180*x+100;
    else
        v=160*x+300;
    end
end