%T4
function ans = key(Gen)
    
    G=20;K=0.1; 
  
    R=[11,5,4,7,16,6,5,7,13,6,5,7,12,5,4,6,9,5,5,11,29,21,17,20,27,13,9,10,16,6,5,7,11,5,5,6,12,7,7,10,15,10,9,11,15,10,10,16,26,21,23,36,50,45,45,49,57,43,40,44,52,43,42,45,52,41,39,41,48,35,34,35,42,34,36,43,55,48,54,65,80,70,74,85,101,89,88,90,100,87,88,89,104,89,89,90,106,96,94,99,109,99,96,102];
    
    Cb=[];Cd=[]; 
    Nc=[];Ncm=[];Ncu=[];
    Nc0=13;
    
    Ob=[];Od=[];
    No=[];Nom=[];Nou=[];Nog=[];Not=[];
    No0=50;
    
    Pcm=10;Pom=5;Pot=10;
    key=[];
    
    Cb=Gen(1:size(Gen,2)/4);
    Cd=Gen(size(Gen,2)/4+1:size(Gen,2)/2);
    Ob=Gen(size(Gen,2)/2+1:size(Gen,2)*3/4);
    Od=Gen(size(Gen,2)*3/4+1:end);
    
    f=1; 
    for i=1:size(Gen,2)/4
        if i==1
            Nc(i)=Nc0+Cb(i)-Cd(i);
            No(i)=No0+Ob(i)-Od(i);
        else
            Nc(i)=Nc(i-1)+Cb(i)-Cd(i)-round(Ncu(i-1)*K); 
            No(i)=No(i-1)+Ob(i)-Od(i)-round(Nou(i-1)*K);
        end

        Ncu(i)=R(i); 
        Ncm(i)=Nc(i)-Ncu(i); 

        Nou(i)=R(i)*4; 
        Not(i)=Ob(i); 
        Nog(i)=ceil(Ob(i)/G);
        Nom(i)=No(i)-Nou(i)-Not(i)-Nog(i); 

        
        if Ncu(i)<0||Ncm(i)<0||Nou(i)<0||Not(i)<0||Nog(i)<0||Nom(i)<0||Nc(i)<0||No(i)<0||Cb(i)<0||Cd(i)<0||Ob(i)<0||Od(i)<0
            %disp(['wa1:',num2str(i),' ',num2str(Ncu(i)) ' ' num2str(Ncm(i)) ' ' num2str(Nou(i)) ' ' num2str(Not(i)) ' ' num2str(Nog(i)) ' ' num2str(Nom(i)) ' ' num2str(Nc(i)) ' ' num2str(No(i)) ' ' num2str(Cb(i)) ' ' num2str(Cd(i)) ' ' num2str(Ob(i)) ' ' num2str(Od(i)) ]);
            %disp(['wa1:',num2str(i),' ',num2str(Ncm(i)),' ',num2str(Nom(i))]);
            %disp([num2str(Nom(i)) '=' num2str(No(i)) '-' num2str(Nou(i)) '-' num2str(Not(i)) '-' num2str(Nog(i))]);
            %disp([num2str(Nog(i)) ' ' num2str(Ob(i)) '/' num2str(G)]);
            f=0;
        end

        % 约束：使用后的操作手（除去丢弃的）一定要保养
        if (i>1 && Nom(i)< 4*R(i-1) - Od(i) - round(Nou(i-1)*K)) || (i>1&&R(i)>Nc(i-1)-Cd(i)-round(Ncu(i-1)*K)) || (i==1 && R(i)>Nc0-Cd(i))
            %disp(['wa2:',num2str(i)]);
            f=0;
        end;
   
        % 算钱
        if f==1
            if i>1
                key(i)=key(i-1)+Pc(Cb(i))+Po(Ob(i))+(Nog(i)+Not(i))*Pot+Ncm(i)*Pcm+Nom(i)*Pom;
            else
                key(i)=Pc(Cb(i))+Po(Ob(i))+(Nog(i)+Not(i))*Pot+Ncm(i)*Pcm+Nom(i)*Pom;
            end
        else
            key(i)=90000000;
        end
    end
    %disp(['wa2:',num2str(size(Gen,2)/4),' ',num2str(size(key,2))]);
    ans=key(end);
end