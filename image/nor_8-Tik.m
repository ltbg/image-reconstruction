%load C:\Users\zone\Desktop\Ansys_excel\matlab\8coils\ImageRecon.mat
Field=Field';Empty=Empty';Sen=Sen';
F=ones(64,1);S=ones(64,318);Ans_Tik=ones(318,1);
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
Tik=(S'*S+0.1*I)\(S'*F);
for i=1:1:318
Ans_Tik(i,1)=(Tik(i,1)-min(Tik))/(max(Tik)-min(Tik));
end
cc=corrcoef(Ans_Tik,G);
ie=(norm(Ans_Tik-G))/(2*norm(G));