%load C:\Users\zone\Desktop\Ansys_excel\matlab\8coils\ImageRecon.mat
Field=Field';Empty=Empty';Sen=Sen';
F=ones(64,1);S=ones(64,318);Ans_Tik=ones(318,1);Ans_LW=ones(318,1);Ans_LW2=ones(318,1);
for i=1:1:64,
    F(i,1)=abs((Field(i,1)-Empty(i,1))/Empty(i,1));%��õ�ѹ�Ĺ�һ��
end
%for i=1:1:64,F_Nor(1,i)=(Field_Nor(1,i)-F_min)/(F_max-F_min); end
for i=1:1:318
    %S_max=max(Sen_Nor(i,:));S_min=min(Sen_Nor(i,:));
    for j=1:1:64
        %S_Nor(i,j)=(Sen_Nor(i,j)--S_min)/(S_max-S_min);
        S(j,i)=abs((Sen(j,i)-Empty(j,1))/Empty(j,1));%�����Ⱦ���Ĺ�һ��
    end
end
[x,y]=eig(S'*S);   % [V,D]=eig(A)�������A��ȫ������ֵ�����ɶԽ���D   %����������ӵ�ֵ��alfa=2/k
eigenvalue=diag(y);%eigenvalue����ֵ
k=max(eigenvalue);%����������ֵ

I=eye(318);
LBP=S'*F;
Tik=(S'*S+0.1*I)\(S'*F);

LW=S'*F;
LW2=S'*F;
alfa=0.1;
for i=1:200
     LW2=LW2-alfa*S'*(S*LW2-F);   %��ͳ��landweber�����㷨
end       
      

beta=0.1;
for i=1:13       %����S�����landwer�㷨
    LW=LW-alfa*S'*(S*LW-F);     
end
S=F*LW'/(LW*LW'+beta*I);
for i=1:200   
    LW=LW-alfa*S'*(S*LW-F);
end

% esp=1*10^(-6);            %CG�㷨
% CG_0=S'*F;
% k=0;
%  while(k<10)
%     if k==0
%         r_0=S'*(S*CG_0-F);  %r0���ݶ�
%         p_0=-r_0;       %p0����������
%         lamda_(k)=-(r_(k)'*p_(k))/(p_(k)'*p_(k));  %landa�ǲ�������
%         CG_(k+1)=CG_(k)+lamda_(k)*p_(k);   %G�ǵ�����ʽ
%     else 
%         r_(k)=S'*(S*CG_(k)-F);
%         betal_(k)=(norm(r_(k)))^2/(norm(r_(k-1)))^2;
%         p_(k)=-r_(k)+betal_(k)*p_(k-1);
%         lamda_(k)=-(r_(k)'*p_(k))/(p_(k)'*p_(k));    
%         CG_(k+1)=CG_(k)+lamda_(k)*p_(k);   
%     end
%     k=k+1;   
%  end

for i=1:1:318
Ans_Tik(i,1)=(Tik(i,1)-min(Tik))/(max(Tik)-min(Tik));%��һ��
Ans_LBP(i,1)=(LBP(i,1)-min(LBP))/(max(LBP)-min(LBP));
% Ans_LW(i,1)=(LW(i,1)-min(LW))/(max(LW)-min(LW));
% Ans_LW2(i,1)=(LW2(i,1)-min(LW2))/(max(LW2)-min(LW2));
end
cc_LBP=corrcoef(Ans_LBP,G);%Ans_LBP��G�����ϵ��
ie_LBP=(norm(Ans_LBP-G))/(2*norm(G));%norm���㷶��
cc_TIK=corrcoef(Ans_Tik,G);
ie_TIK=(norm(Ans_Tik-G))/(2*norm(G));
cc_LW=corrcoef(Ans_LW,G);
ie_LW=(norm(Ans_LW-G))/(2*norm(G));
cc_LW2=corrcoef(Ans_LW2,G);
ie_LW2=(norm(Ans_LW2-G))/(2*norm(G));
% %��Ԫ�����
% X=Coord(:,1);Y=Coord(:,2);%ȡ�����е�x y
% patch('Faces',Topo,'Vertices',[X,Y],'FaceVertexCData',Ans_LBP,...
% 'FaceColor','flat','EdgeColor','none');%ͼ���ɲ�Ƭ��ɣ����⻬��