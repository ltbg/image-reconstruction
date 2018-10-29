X=Coord(:,1);Y=Coord(:,2);%取坐标中的x y
Flat1=[Topo,Ans_LBP];%318*4的矩阵 Topo是节点编号 
Interp1=ones(681,1);
for i=1:1:681
    e=0;sum=0;%初始化么？
  for j=1:1:318
    for k=1:1:3
       if Flat1(j,k)==i;
          e=e+1;sum=sum+Flat1(j,4);%和i相等后计数，ansLBP，即灰度值累加
       end
     end
  end
  if e==0,Interp1(i,1)=0;%灰度值为0
  else
     Interp1(i,1)=sum/e;%e个结点的灰度值的和 所以求平均。
  end
end
Flat2=[Topo,Ans_Tik];%%Topo是三角形的节点的编号。
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
% for i=681:-1:1 %遍历681个点
%     if Num1(i,3)==0%i行第三列，即i行灰度值为0
%         Num1(i,:)=[];%删除第i行所有列？(即清空i行所有数据，由681变成了182）
%     end
%     if Num2(i,3)==0
%         Num2(i,:)=[];
%     end
% end
X1=Num1(:,1);Y1=Num1(:,2);Gray1=Num1(:,3);
X2=Num2(:,1);Y2=Num2(:,2);Gray2=Num2(:,3);
tri=delaunay(X1,Y1);%三角剖分是为了把所有的节点连接起来。   

%节点填充
subplot(1,2,1);              % 两张图合在一起
%figure
patch('Faces',tri,'Vertices',[X1,Y1],'FaceVertexCData',Gray1,...
'FaceColor','interp','EdgeColor','none'); 

%单元格填充
%patch('Faces',Topo,'Vertices',[X,Y],'FaceVertexCData',Ans_LBP,...
%'FaceColor','flat','EdgeColor','none');

subplot(1,2,2);
%figure
patch('Faces',tri,'Vertices',[X2,Y2],'FaceVertexCData',Gray2,...
'FaceColor','interp','EdgeColor','none');    