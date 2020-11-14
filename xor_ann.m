clc
clear
a=0.1;
t3=0.8;t4=-0.1;t5=0.3;
dt3=0;dt4=0;dt5=0;
w13=0.5;w14=0.9;w23=0.4;w24=1.0;w35=-1.2;w45=1.1;
dw13=0;dw14=0;dw23=0;dw24=0;dw35=0;dw45=0;
xi=[0 0;0 1;1 0;1 1];
yd=[0 1 1 0]';
yp=zeros(4,1);
er=zeros(4,1);
y3=0;y4=0;y5=0;
d3=0;d4=0;d5=0;
ers=1;
ep=0;
while(ers>0.001)
  for i=1:4;
      y3=sigmf( ((xi(i,1)*w13) + (xi(i,2)*w23)),[1 t3] );
      y4=sigmf( ((xi(i,1)*w14) + (xi(i,2)*w24)),[1 t4] );
      y5=sigmf( ((y3*w35) + (y4*w45)),[1 t5] );
      yp(i)=y5;
      er(i)=yd(i)-yp(i);
      d5=y5*(1-y5)*er(i);
      dw35=a*y3*d5;
      dw45=a*y4*d5;
      dt5=a*(-1)*d5;
      d3=y3*(1-y3)*d5*w35;
      d4=y4*(1-y4)*d5*w45;
      dw13=a*xi(i,1)*d3;
      dw23=a*xi(i,2)*d3;
      dt3=a*(-1)*d3;
      dw14=a*xi(i,1)*d4;
      dw24=a*xi(i,2)*d4;
      dt4=a*(-1)*d4;
      w13=w13+dw13;
      w14=w14+dw14;
      w23=w23+dw23;
      w24=w24+dw24;
      w35=w35+dw35;
      w45=w45+dw45;
      t3=t3+dt3;
      t4=t4+dt4;
      t5=t5+dt5;
  end
  ers=sum(power(er,2));
  ep=ep+1;
end
  display(ep);
  display(yp)