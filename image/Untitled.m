X=Coord(:,1);Y=Coord(:,2);%ȡ�����е�x y
Flat1=[Topo,Ans_LBP];%318*4�ľ��� Topo�ǽڵ��� 
Interp1=ones(681,1);
for i=1:1:681
    e=0;sum=0;%��ʼ��ô��
  for j=1:1:318
    for k=1:1:3
       if Flat1(j,k)==i;
          e=e+1;sum=sum+Flat1(j,4);%��i��Ⱥ������ansLBP�����Ҷ�ֵ�ۼ�
       end
     end
  end
  if e==0,Interp1(i,1)=0;%�Ҷ�ֵΪ0
  else
     Interp1(i,1)=sum/e;%e�����ĻҶ�ֵ�ĺ� ������ƽ����
  end
end
Flat2=[Topo,Ans_Tik];%%Topo�������εĽڵ�ı�š�
Interp2=ones(681,1);
for i=1:1:681
    e=0;sum=0;
for j=1:1:318
    for k=1:1:3
    if Flat2(j,k)==i
        e=e+1;sum=sum+Flat2(j,4);
    end
    end
end
if e==0,Interp2(i,1)=0;
else
Interp2(i,1)=sum/e;
end
end
Num1=[Coord,Interp1];Num2=[Coord,Interp2];
% for i=681:-1:1 %����681����
%     if Num1(i,3)==0%i�е����У���i�лҶ�ֵΪ0
%         Num1(i,:)=[];%ɾ����i�������У�(�����i���������ݣ���681�����182��
%     end
%     if Num2(i,3)==0
%         Num2(i,:)=[];
%     end
% end
X1=Num1(:,1);Y1=Num1(:,2);Gray1=Num1(:,3);
X2=Num2(:,1);Y2=Num2(:,2);Gray2=Num2(:,3);
tri=delaunay(X1,Y1);%�����ʷ���Ϊ�˰����еĽڵ�����������   

%�ڵ����
subplot(1,2,1);              % ����ͼ����һ��
%figure
patch('Faces',tri,'Vertices',[X1,Y1],'FaceVertexCData',Gray1,...
'FaceColor','interp','EdgeColor','none'); 

%��Ԫ�����
%patch('Faces',Topo,'Vertices',[X,Y],'FaceVertexCData',Ans_LBP,...
%'FaceColor','flat','EdgeColor','none');

subplot(1,2,2);
%figure
patch('Faces',tri,'Vertices',[X2,Y2],'FaceVertexCData',Gray2,...
'FaceColor','interp','EdgeColor','none');    