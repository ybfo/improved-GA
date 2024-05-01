

% PSO(50,5000,zeros(1,dim),ones(1,dim)*500,dim,@obj);

function [gbest_fitness,gbest_index,Convergence_curve] = PSO(SearchAgents_no,Max_iter,lb,ub,dim,fobj)

funct = fobj;                         
popsize = SearchAgents_no;                          
fun_range = [lb',ub'];    
maxgen = Max_iter;                           
limit_v = 10;                          
maxormin = 0;                          
dynamic = 1;                            
W = [0.7,1.4];                          
C2 = [0.5,2.5];
C1 = [0.5,2.5];                         


x=initialization(popsize,dim);
for i = 1 : popsize
    for j = 1 : dim
        if i>5
            x(i,j) = x(i,j) + (rand-0.5)*0.05*(ub(j)-lb(j));
        end
        v(i,j) = rand * limit_v;
    end
end
for i = 1 : popsize
    fitness(i,:) = funct(x(i,:)); 
end

pbest = x;              
pbest_fitness = fitness;
if maxormin == 1
    [gbest_fitness,gbest_index] = max(fitness);
elseif maxormin == 0
    [gbest_fitness,gbest_index] = min(fitness);
else print('maxormin的值非法')
        return
end
gbest = x(gbest_index,:);



times = 1;

for i = 1 : maxgen      
    if dynamic == 1
        w = W(2) - (W(2) - W(1)) * i/maxgen; 
        c1 = (C1(1) - C1(2)) * i / maxgen + C1(2);
        c2 = (C2(2) - C2(1)) * i / maxgen + C2(1);
    elseif dynamic == 0
        w = W;
        c1 = C1(1);
        c2 = C2(1);
    end
    for j = 1 : popsize    
        
        v(j,:) = w * v(j,:) + c1 * rand * (pbest(j,:) - x(j,:)) + c2 * rand * (gbest - x(j,:));
    end
   
    for g=1:dim           
        for k=1:popsize    
            if  v(k,g) > limit_v
                v(k,g) = limit_v;
            end
            if  v(k,g) < (-1 * limit_v)
                v(k,g) = (-1 * limit_v);
            end
        end
    end     
   
    x(j,:) = x(j,:) + v(j,:);
   
    for g=1:dim          
        for k=1:popsize    
        if  x(k,g) > fun_range(g,2)
            x(k,g) = fun_range(g,2);
        end
        if  x(k,g) < fun_range(g,1)
            x(k,g) = fun_range(g,1);
        end
        end
    end   

    for u = 1 : popsize
        fitness(u,:) = funct(x(u,:)); 
    end

    if maxormin == 0
        if min(fitness) < gbest_fitness
            [gbest_fitness,gbest_index] = min(fitness);
            gbest = x(gbest_index,:);
        end
    elseif maxormin == 1
        if max(fitness) > gbest_fitness
            [gbest_fitness,gbest_index] = max(fitness);
            gbest = x(gbest_index,:);
        end
    end
    

    for k = 1 : popsize
      if maxormin == 0
        if fitness(k,:) < pbest_fitness(k,:)
            pbest_fitness(k,:) = fitness(k,:);
            pbest(k,:) = x(k,:);
        end
      elseif maxormin == 1 
        if fitness(k,:) > pbest_fitness(k,:)
            pbest_fitness(k,:) = fitness(k,:);
            pbest(k,:) = x(k,:);
        end
      end
    end
    Convergence_curve(times) = gbest_fitness;
    times = times + 1;
end




end
