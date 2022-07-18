f = @(y,t)y + t*t*y + 1;
y0 = 1;
t0 = 0;
h = 0.1;

for i=1:2
    Y = y0 + h*feval(f,y0,t0)
    t = t0 + h
    t0 = t;
    y0 = Y;
end