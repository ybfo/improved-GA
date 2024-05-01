function p = choose(w)
    %The roulette wheel selects w as the weight
    %w=[0.5,1]
    q=w(1);
    for i = 2:size(w,2)
        q(i)=q(i-1)+w(i);%cumulative probability
    end
    q_rand = rand();
        k=1;%Number the selected path
        for i = 1:size(w,2)
            if q_rand>q(i)
                k=i+1;
            end
        end
    p=k;
end