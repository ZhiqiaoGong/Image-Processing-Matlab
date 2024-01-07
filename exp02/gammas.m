c=1;

x1 = [0:0.01:1];
y1 = c*x1.^0.04;
plot(x1,y1,'r');
hold on;

x1 = [0:0.01:1];
y1 = c*x1.^0.1;
plot(x1,y1,'g');
hold on;

x1 = [0:0.01:1];
y1 = c*x1.^0.2;
plot(x1,y1,'b');
hold on;

x1 = [0:0.01:1];
y1 = c*x1.^0.4;
plot(x1,y1,'c');
hold on;

x1 = [0:0.01:1];
y1 = c*x1.^0.67;
plot(x1,y1,'m');
hold on;

x1 = [0:0.01:1];
y1 = c*x1.^1;
plot(x1,y1,'k');
hold on;

x1 = [0:0.01:1];
y1 = c*x1.^1.5;
plot(x1,y1,'--r');
hold on;

x1 = [0:0.01:1];
y1 = c*x1.^2.5;
plot(x1,y1,'--g');
hold on;

x1 = [0:0.01:1];
y1 = c*x1.^5;
plot(x1,y1,'--b');
hold on;

x1 = [0:0.01:1];
y1 = c*x1.^10;
plot(x1,y1,'--c');
hold on;

x1 = [0:0.01:1];
y1 = c*x1.^25;
plot(x1,y1,'--m');
hold on;
grid on;

legend({'0.04','0.1','0.2','0.4','0.67','1','1.5','2.5','5','10','25'},'Location','southeast')