% Bai toan co ban gom cac buoc nhu sau
% B1: tinh nong do cua ma tran thuc an duoc sinh ra boi phuong phap SOR
% B2: Moi o o ben canh cua vi khuan se co ti le lay nhiem 
% B3: Random xem ti le lay nhiem co lon hon rand khong neu lon hon thi la
% virus an duoc

% Khoi tao
function Main()
    clc;
 
   [m,c,grow,n_virus,n_candidate,candidate,chance,virus_max,w,n]=init();
  
    solve(n_virus,virus_max,c,candidate,n_candidate,grow,m,w,n,chance);
   

end

function [m,c,grow,n_virus,n_candidate,candidate,chance,virus_max,w,n]=init()
    % kich thuoc mma tran
    m = 200; 
    c=make_food(m); 
%     c = zeros(m,m);
%     c(1,:) = 1;
    % vi tri cua cac virus hien co (co danh dau = 1, khong co danh dau = 0)
    grow = zeros(m,m);
    % So luong virus hien co
    n_virus = 0;   
    % So luong ung cu vien candidate cung la so luong cua chance 
    n_candidate = 0;
    % Danh sach cac ung cu vien gom 2 hang nhieu cot
    candidate = [0;0]; 
    % xac suat bi an cua cac ung cu vien tuong ung voi vi tri cua cac ung cu vien
    chance = [0 0]; 
    % so virus muon max
    virus_max = 10000;
    % hang so quan he tinh toan cua nong do thuc an buoc sau
    w=1.5;  
    % so mu trong luc tinh toan xac suat
    n=1; 
    % vi tri dau tien cua virus co the tuy chinh trong kich thuoc cua ma tran
    x0=m-5;
    y0=m/2;
    %khoi tao vi tri dau tien cua virus
    [grow,n_virus,candidate,n_candidate,c] = add_virus(x0,y0,grow,n_candidate,n_virus,m,candidate,c);
end

function solve(n_virus,virus_max,c,candidate,n_candidate,grow,m,w,n,chance)
    while n_virus<=virus_max
        % tinh lai nong do cua ma tran thuc an khi vua co virus them vao
        c = sor(c,w,m,grow); 
        % hien tai da co cac ung cu vien va so luong ung cu vien
        n_candidate = size(candidate,2);
        % Tinh xac suat de ung cu vien bi an
        chance = compute_probality(c,n_candidate,candidate,n,chance);
        random = rand(1,n_candidate);
        index=[];
        dem=1;
        elements_are_eaten = [];
        
        for i = 1:n_candidate
            if chance(i) > random(i)
               elements_are_eaten(:,dem) = candidate(:,i);
               index(dem) = i;
               dem = dem+1;
            end
        end
        chance(:,index) = [];
        candidate(:,index) = [];
        n_candidate = n_candidate-size(index,2);
        for i=1:size(elements_are_eaten,2)
            [grow,n_virus,candidate,n_candidate,c] = add_virus(elements_are_eaten(1,i),elements_are_eaten(2,i),grow,n_candidate,n_virus,m,candidate,c);
        end
        subplot(1,2,1)
        imagesc(c);
        subplot(1,2,2);
        imagesc(grow);
        pause(0.01);
    end
end


% Tinh va tra ve xac suat bi an cua cac ung cu vien
function [chance] = compute_probality(c,n_candidate,candidate,n,chance)
    if (n_candidate ~= 0)
        S = 0;
        for t = 1:n_candidate
            S = S + c(candidate(1,t),candidate(2,t))^n;
        end
        for t = 1:n_candidate
            chance(t) = (c(candidate(1,t),candidate(2,t))^n)/S;
        end
    end
end

% ham add them virus va them cac o xung quanh vao lam ung cu vien
function [c] = sor(c,w,m,grow)
    for i = 2:m-1
        for j = 2:m-1
            if (grow(i,j) == 1)
                continue;
            end
            c(i,j) = w/4*(c(i+1,j)+c(i-1,j)+c(i,j+1)+c(i,j-1))+(1-w)*c(i,j);
        end
    end
end
% ham add_virus da cap nhat lai so virus ma tran chua virus, so ung cu vien
% va ma tran ung cu vien
function [grow,n_virus,candidate,n_candidate,c] = add_virus(x,y,grow,n_candidate,n_virus,m,candidate,c)
    grow(x,y) = 1;
    c=eat(x,y,c);
    n_virus = n_virus+1;
    if ((x == 2 && y == 2) || (x == 2 && y == m-1)) 
        if y==2
            [candidate,n_candidate]=add_candidate(x+1,y,candidate,n_candidate,grow);
            [candidate,n_candidate]=add_candidate(x,y+1,candidate,n_candidate,grow);
        elseif y==m-1
            [candidate,n_candidate]=add_candidate(x+1,y,candidate,n_candidate,grow);
            [candidate,n_candidate]=add_candidate(x,y-1,candidate,n_candidate,grow);
        end
    elseif ((x == m-1 && y == 2) || (x == m-1 && y == m-1)) 
        if y==2
            [candidate,n_candidate]=add_candidate(x-1,y,candidate,n_candidate,grow);
            [candidate,n_candidate]=add_candidate(x,y+1,candidate,n_candidate,grow);
        elseif y==m-1
            [candidate,n_candidate]=add_candidate(x-1,y,candidate,n_candidate,grow);
            [candidate,n_candidate]=add_candidate(x,y-1,candidate,n_candidate,grow);
        end
    elseif ((x == 2 && y ~= 2 && y ~= m-1))
        [candidate,n_candidate]=add_candidate(x+1,y,candidate,n_candidate,grow);
        [candidate,n_candidate]=add_candidate(x,y+1,candidate,n_candidate,grow);
        [candidate,n_candidate]=add_candidate(x,y-1,candidate,n_candidate,grow);
    elseif ((x == m-1 && y ~= 2 && y ~= m-1))
        [candidate,n_candidate]=add_candidate(x-1,y,candidate,n_candidate,grow);
        [candidate,n_candidate]=add_candidate(x,y+1,candidate,n_candidate,grow);
        [candidate,n_candidate]=add_candidate(x,y-1,candidate,n_candidate,grow);
    elseif (y == 2 && (x ~= 2 || x ~= m-1))
        [candidate,n_candidate]=add_candidate(x-1,y,candidate,n_candidate,grow);
        [candidate,n_candidate]=add_candidate(x,y+1,candidate,n_candidate,grow);
        [candidate,n_candidate]=add_candidate(x+1,y,candidate,n_candidate,grow);
    elseif (y == m-1 && (x ~= 2 || x ~= m-1))
        [candidate,n_candidate]=add_candidate(x-1,y,candidate,n_candidate,grow);
        [candidate,n_candidate]=add_candidate(x,y-1,candidate,n_candidate,grow);
        [candidate,n_candidate]=add_candidate(x+1,y,candidate,n_candidate,grow);
    else
        [candidate,n_candidate]=add_candidate(x-1,y,candidate,n_candidate,grow);
        [candidate,n_candidate]=add_candidate(x+1,y,candidate,n_candidate,grow);
        [candidate,n_candidate]=add_candidate(x,y+1,candidate,n_candidate,grow);
        [candidate,n_candidate]=add_candidate(x,y-1,candidate,n_candidate,grow);
    end
end
function [candidate,n_candidate] = add_candidate(x,y,candidate,n_candidate,grow)
    % phai check xem o do da co virus chua
    if (grow(x,y)==0)
        candidate(:,n_candidate+1) = [x;y];
        n_candidate = n_candidate+1;
    end
end

function [c]=eat(x,y,c)
    c(x,y) = 0;
end


% add virus dau tien va cap nhat so luong virus va so luong ung cu vien
% them vi tri hang va cot cua cac ung cu vien vao ma tran 2 hang nhieu
% cot candidate hang 1 se la chi so hang cua ung cu vien hang 2 la chi
% so cua cot cua ung cu vien

function [c]=make_food(m)
    r = (m)/2;  % surrounding rows
    x = zeros(m);   % array initialization
    c = r-1:-1:0;
    calc=m/20;
% assigning  values
for i = 1:r
    x([1+c(i), end-c(i)],   :) = -i/10;
    x(:,[1+c(i), end-c(i)]) = -i/10;
end
    c=(x+calc*ones(m,m))./10;
end