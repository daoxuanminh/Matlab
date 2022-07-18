f = @(y,x)-y + x + 1;
f_chinhxac = @(x)x + exp(-x);
y0 = 1;
h = 0.1;
% for i=1:3
%     X = 0:h^i:1;
%     Y_cx = feval(f_chinhxac,X);
%     plot (X,Y_cx);
%     hold on;
% end

X = 0:h:1;
Y_cx = feval(f_chinhxac,X);
plot (X,Y_cx);

for i=0:h:1
    y_1 = 
