function y=shif(ns,nq); 
%�����  ��������� ������� ����� ���������� ��� ����� nq  
%�� ������� 
if nq~=0,  
    for i=1:nq, 
      ns(i)=ns(i+1); 
    end; 
end; 
y=ns;