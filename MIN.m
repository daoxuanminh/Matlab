function [ ] = MIN(f,a,b,e)
while (abs(b-a) >= 2*e)
	x1 = a + (b-a)/2 - e/2;
	x2 = a + (b-a)/2 + e/2;
	fx1 = feval(f,x1);
	fx2 = feval(f,x2);
	if fx1 < fx2
		b = x2;
    elseif fx1 > fx2
		a = x1;
	else
		a = x1; b = x2;
    end
end
x_min = (a+b)/2
ans = feval(f,x_min)
end

