fx = @(x)x^2 + sin(x) + 1;
X = pi/3;
% Kiem tra ham khi x = pi/3
ChinhXac = fx(X);
Ax = 0:pi/4:pi/2;
result = 0;
for i=0:2
    tg = 1;
    for j=0:2
        if i~=j
            tg = tg*(X-Ax(j+1))/(Ax(i+1)-Ax(j+1));
        end
    end
    tg = tg*fx(Ax(i+1));
    result = result + tg;
end
fprintf ('fx(pi/3) = %f\n',ChinhXac);
fprintf ('Pm(pi/3) = %f\n',result);


