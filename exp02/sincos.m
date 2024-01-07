x1 = [-2*pi:0.01:2*pi];
y1 = sin(x1);
plot(x1,y1,'r');
set(gca,'XTick',-2*pi:pi/2:2*pi);
set(gca,'XTickLabel',{'-2pi','-3/2pi','-pi','-1/2pi','0','1/2pi','pi','3/2pi','2pi'});

hold on;
grid on;

x2 = [-2*pi:0.01:2*pi];
y2 = cos(x2);
plot(x2,y2,'b');
legend({'y = sin(x)','y = cos(x)'},'Location','southwest')

