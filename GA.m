function [best_v,best_gen,Convergence_curve]=GA(SearchAgents_no,Max_iter,dim,fobj)
    log_v=[];log_w=[];log_r=[];
    best_gen=[];best_v=90000000;best_w=0;
    gen=initialization(SearchAgents_no,dim);
    t=1;
    r=100;
    gen_new=gen;
    while t<=Max_iter
        %disp(['r:',num2str(r)]);
        t=t+1;
        gen = gen_new;
       
        v=[];w=[];
        for i = 1:SearchAgents_no
            v(i)=fobj(gen(i,:));
        end
        w=ones([1,SearchAgents_no])*sum(v)./v;
       
        for i = 1:SearchAgents_no
            if v(i)<best_v
                best_v=v(i);
                best_w=w(i);
                best_gen=gen(i,:);
                new=1; 
            end
        end
   
        log_v(end+1)=best_v;
        log_w(end+1)=best_w;
        log_r(end+1)=r;
       
        w=w/sum(w);
        
        for o = 1:SearchAgents_no/2
            
            p1=choose(w);p2=choose(w);
            g1=gen(p1,:);g2=gen(p2,:);
            
            q_rand = rand();
            if q_rand<0.9 && p1~=p2
                ran1 = randi([1,size(gen,2)]);
                ran2 = randi([1,size(gen,2)]);
                if ran1 > ran2 %让 ran1<ran2
                    k = ran1;
                    ran1 = ran2;
                    ran2 = k;
                end
                
                for i = ran1:ran2 
                    k=g1(i);
                    g1(i)=g2(i);
                    g2(i)=k;
                end
    
            end
          
            q_rand = rand();
            if(q_rand<0.5)
                ran1 = randi([1,size(gen,2)]);
                g1(ran1)=g1(ran1)+round((rand-0.5)*r);
            end
            q_rand = rand();
            if(q_rand<0.5)
                ran1 = randi([1,size(gen,2)]);
                g2(ran1)=g2(ran1)+round((rand-0.5)*r);
            end
            
            q_rand = rand();
            if(q_rand<0.2)
                ran1 = randi([1,size(gen,2)]);
                ran2 = ran1+round(randi([0,size(gen,2)-ran1])*rand);
                q_rand = rand()/2+0.75;
                for i = ran1:ran2 
                    g1(i)=round(round(g1(i)*q_rand));
                end
            end
            
            q_rand = rand();
            if(q_rand<0.2)
                ran1 = randi([1,size(gen,2)]);
                ran2 = ran1+round(randi([0,size(gen,2)-ran1])*rand);
                for i = ran1:ran2 
                    g2(i)=g2(i)+round((rand-0.5)*(rand+0.5)*r*2);
                end
            end
            
            q_rand = rand();
            if(q_rand<0.1)
                ran1 = randi([1,size(gen,2)]);
                ran2 = ran1+round(randi([0,size(gen,2)-ran1])*rand*rand);
                q_rand = round((rand-0.5)*r);
                for i = ran1:ran2 
                    g2(i)=g2(i)+q_rand;
                end
            end
            
            gen_new(o*2-1,:)=g1;
            gen_new(o*2,:)=g2;
            
            w=ones(size(w))./w; 
            w=w/sum(w);
            gen(choose(w),:)=best_gen;
        end
        
    end
    

    Convergence_curve =  log_v;
end



