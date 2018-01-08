function y=shif(ns,nq); 
%сдвиг  элементов массива после уменьшения его длины nq  
%на единицу 
if nq~=0,  
    for i=1:nq, 
      ns(i)=ns(i+1); 
    end; 
end; 
y=ns;