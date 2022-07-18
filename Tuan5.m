f = @(y,t)-20*y + 7*exp(-0.5*t);
y0 = 5;
t0 = 0; t1 = 0.5;
h = 0.04;

y_chinhxac = @(t)5*exp(-20*t)+(7/19.5)*(exp(-0.5*t)-exp(-20*t));
X = t0:h:t1;
Y_cx = feval (y_chinhxac,X);
plot (X,Y_cx); hold on;


for t=t0:h:t1
    Y = y0 + h*feval(f,y0,t);
    plot (t,y0,'r*');
    y0 = Y;
end
% Kutta Bac 2
y0=5;
for t=t0:h:t1
    k1 = h*feval(f,y0,t);
    k2 = h*feval(f,y0+k1,t+h);
    Y = y0+0.5*(k1+k2);
    plot (t,Y,'bo');
    hold on;
    y0 = Y;
end
% Kutta Bac 3
y0=5;
for t=t0:h:t1
    k1 = h*feval(f,y0,t+0.5*h);
    k2 = h*feval(f,y0+0.5*k1,t+0.5*h);
    k3 = h*feval(f,y0-k1+2*k2,t+h);
    Y = y0+(1/6)*(k1+4*k2+k3);
    plot (t,y0,'c+');
    y0 = Y;
end


