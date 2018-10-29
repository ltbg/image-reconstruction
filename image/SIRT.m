%load C:\Users\zone\Desktop\Ansys_excel\matlab\8coils\ImageRecon.mat
Field=Field';Empty=Empty';Sen=Sen';
F=ones(64,1);S=ones(64,318);Ans_Tik=ones(318,1); Ans_LW=ones(318,1);% deta_fij=zeros(64,318); 
deta_SIRT=zeros(318,1); deta_fij=zeros(318,1);

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

%灵敏度矩阵中的每个元素都对灰度值进行更新，有贡献；
% [m,n] = size(S);  %S的行敿
% 
% SIRT=(S'*S+0.05*I)\(S'*F);
% Ar=sum((S.*S),2);   %S对应元素相乘，按行求和； 
% % Iterate.
% for i=1:100
%     for j=1:m
%            for k=1:n
%               deta_fij(j,k)=(F(j)-S(j,:)*SIRT)*S(j,k)/Ar(j);         
%            end
%     end
%     
%     for k=1:n  %318
%         for j=1:m  %64
%           deta_SIRT(k)=deta_fij(j,k)/m;
%         end
%     end
%        
%         SIRT = SIRT+0.1*deta_SIRT;
% 
% end


%灵敏度矩阵的每一行去更新灰度值；
 [m,n] = size(S);  %S的行
 SIRT=(S'*S+0.05*I)\(S'*F);
 Ar=sum((S.*S),2);   %S对应元素相乘，按行求和； 

 for i=1:100
    for j=1:m
             deta_fij=deta_fij+(F(j)-S(j,:)*SIRT)*S(j,:)'/Ar(j);         
    end
    deta_SIRT=deta_fij/m;
    SIRT = SIRT+0.1*deta_SIRT;
end








for i=1:1:318
Ans_Tik(i,1)=(Tik(i,1)-min(Tik))/(max(Tik)-min(Tik));
Ans_LBP(i,1)=(LBP(i,1)-min(LBP))/(max(LBP)-min(LBP));
Ans_SIRT(i,1)=(SIRT(i,1)-min(SIRT))/(max(SIRT)-min(SIRT));
end
cc_LBP=corrcoef(Ans_LBP,G);
ie_LBP=(norm(Ans_LBP-G))/(2*norm(G));
cc_Tik=corrcoef(Ans_Tik,G);
ie_Tik=(norm(Ans_Tik-G))/(2*norm(G));
cc_SIRT=corrcoef(Ans_SIRT,G);
ie_SIRT=(norm(Ans_SIRT-G))/(2*norm(G));