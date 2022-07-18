c = 1; N = 20; T = 5; dt = 0.01; dx = 0.05; t = 0; 
for i=1:N+1
    x = (i-1)*dx;
    X0(i) = sin(2*pi*x);
    X1(i) = sin(2*pi*x);
end    
while t < T
    for i=1:N+1
        if (i==1 || i==N+1)
            Formula(i) = 0;
        else
            Formula(i) = (X1(i-1) - 2*X1(i) + X1(i+1))/(dx*dx);
        end
    end
    for i=1:N+1
        tmp = X1(i)
        X1(i) = 2*X1(i) - X0(i) + Formula(i)*c^2*dt^2;
        X0(i) = tmp;
    end
    T = 1:N+1;
    plot (T,X1); pause(0.1);
    t = t+dt;
end