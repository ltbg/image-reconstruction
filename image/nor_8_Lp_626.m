%load C:\Users\zone\Desktop\Ansys_excel\matlab\8coils\ImageRecon.mat
Field=Field';Empty=Empty';Sen=Sen';
F=ones(64,1);S=ones(64,318);Ans_Tik=ones(318,1); Ans_lp=ones(318,1);   A=zeros(64,1);   B=zeros(318,1);
for i=1:1:64,F(i,1)=abs((Field(i,1)-Empty(i,1))/Empty(i,1));end
%for i=1:1:64,F_Nor(1,i)=(Field_Nor(1,i)-F_min)/(F_max-F_min); end
for i=1:1:318
    %S_max=max(Sen_Nor(i,:));S_min=min(Sen_Nor(i,:));
    for j=1:1:64
        %S_Nor(i,j)=(Sen_Nor(i,j)--S_min)/(S_max-S_min);
        S(j,i)=abs((Sen(j,i)-Empty(j,1))/Empty(j,1));
    end
end

I=eye(318);
LBP=S'*F;
Tik=(S'*S+0.1*I)\(S'*F);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Modified Lp%%%%%%%%%%%%%%%%%%% 
[m,n] = size(S);  

lp=(S'*S+0.05*I)\(S'*F);
 
  for i=1:20
     
      alfa=1*10^(-8);
      beta=1*10^(-8);
      q=2; p=2;     
      %q=1; p=2;     
    %  q=2; p=1;     
     % q=2; p=2;   
      
      lamda=1*10^(-3);
    for j=1:m  
       A(j)=((F(j)-S(j,:)*lp)^2+alfa)^((q-2)/2);      
    end
      a=q*diag(A);
      
    for k=1:n
      B(k)=(lp(k)^2+beta)^((p-2)/2);
    end
      b=p*diag(B);
      
      f1=S'*a*(S*lp-F)+lamda*b*lp;
      f2=S'*a*S+lamda*b;
      lp=lp-f2\f1; 
	 
 end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% end   %%%%%%%%%%%%%%%%%%%
 

for i=1:1:318
Ans_Tik(i,1)=(Tik(i,1)-min(Tik))/(max(Tik)-min(Tik));
Ans_LBP(i,1)=(LBP(i,1)-min(LBP))/(max(LBP)-min(LBP));
Ans_lp(i,1)=(lp(i,1)-min(lp))/(max(lp)-min(lp));
Ans_lp(i,1)=Ans_lp(i,1)^3;

end
cc_LBP=corrcoef(Ans_LBP,G);
ie_LBP=(norm(Ans_LBP-G))/(2*norm(G));
cc_Tik=corrcoef(Ans_Tik,G);
ie_Tik=(norm(Ans_Tik-G))/(2*norm(G));
cc_lp=corrcoef(Ans_lp,G);
ie_lp=(norm(Ans_lp-G))/(2*norm(G));