%ctrl + a + i

Re=20; x=0; y=0; Psi=0; W=0; is_wall=0;

L=12; H=1; 
Nx=600; Ny=20; 
hx=L/Nx; hy=H/Ny; 
fi1 = 0;
fi2 = 1;
obstacleWidth = 0.1;
obstacleHeight = 0.5;

% obstacle 1
obst11x = H / 2;
obst12x = obst11x + obstacleWidth;

% obstacle 2
obst21x = obst12x + H;
obst22x = obst21x + obstacleWidth;

% obstacle 3
obst31x = obst22x + H;
obst32x = obst31x + obstacleWidth;

for i=1:Nx+1
    x(i)=hx*(i-1);
end
for i=1:Ny+1
    y(i)=hy*(i-1);
end
% abs(yi-obstacleHeight) < 1e-8
for j=1:Nx+1 % x
    for i=1:Ny+1 %y
        W(i, j) = 0;
        Psi(i,j)=y(i); % y, x
        % 1
        if ((abs(y(i)) < 1e-8) && (x(j)>0 && x(j)<obst11x)) 
            is_wall(i,j) = 1;
        elseif ((abs(y(i)-obstacleHeight) < 1e-8) && (x(j)>=obst11x && x(j)<=obst12x))
            is_wall(i,j) = 1;     
        elseif (abs(y(i)) < 1e-8) && (x(j)>obst12x && x(j)<obst31x)
            is_wall(i,j) = 1;
        elseif ((abs(y(i)-obstacleHeight) < 1e-8) && (x(j)>=obst31x && x(j)<=obst32x))
            is_wall(i,j) = 1;     
        elseif (abs(y(i)) < 1e-8) && (x(j)>obst32x && x(j)<L)
            is_wall(i,j) = 1;
            
            
         % 2
        elseif ((abs(y(i) - H) < 1e-8) && (x(j)>0 && x(j)<obst21x)) 
            is_wall(i,j) = 2;
        elseif ((abs(y(i)-obstacleHeight) < 1e-8) && (x(j)>=obst21x && x(j)<=obst22x))
            is_wall(i,j) = 2;     
        elseif (abs(y(i) - H) < 1e-8) && (x(j)>obst22x && x(j) < L)
            is_wall(i,j) = 2;
        
        % 4
        elseif ( y(i) >= 0 && y(i) <= obstacleHeight && (abs(x(j) - obst12x) < 1e-8))
            is_wall(i,j) = 4;
        elseif ( y(i) >= obstacleHeight && y(i) <= H  && (abs(x(j) - obst22x) < 1e-8))
            is_wall(i,j) = 4;     
        elseif ( y(i) >= 0 && y(i) <= obstacleHeight && (abs(x(j) - obst32x) < 1e-8)) 
            is_wall(i,j) = 4;
        
        % 0
        elseif (y(i) >= 0 && y(i) < obstacleHeight && (x(j)>obst11x && x(j)<obst12x)) 
            is_wall(i,j) = 0;
        elseif (y(i) > obstacleHeight && y(i) <= H && (x(j)>obst21x && x(j)<obst22x)) 
            is_wall(i,j) = 0;
        elseif (y(i) >= 0 && y(i) < obstacleHeight && (x(j)>obst31x && x(j)<obst32x)) 
            is_wall(i,j) = 0;
        
        
        
       
        
        % 3
        elseif ( y(i) >= 0 && y(i) <= obstacleHeight && (abs(x(j) - obst11x) < 1e-8))
            is_wall(i,j) = 3;
        elseif ( y(i) >= obstacleHeight && y(i) <= H  && (abs(x(j) - obst21x) < 1e-8))
            is_wall(i,j) = 3;    
        elseif ( y(i) >= 0 && y(i) <= obstacleHeight && (abs(x(j) - obst31x) < 1e-8)) 
            is_wall(i,j) = 3;
        
        
        
        % 5
        elseif ( y(i) >= 0 && y(i) <= H && (abs(x(j)) < 1e-8))
            is_wall(i,j) = 5;
        
        % 6
        elseif ( y(i) >= 0 && y(i) <= H && (abs(x(j)-L) < 1e-8))
            is_wall(i,j) = 6;
        else
            is_wall(i,j) = 7;
        end
    end
end
W=zeros(Ny+1,Nx+1);
qp=1.2; qw=0.7;
st=1;
n=0;

st=1; n=0;
while st>1e-7
    st=0; dW=0; dPsi=0;
    for i=1:Ny+1
        for j=2:Nx+1
            Psi0=Psi(i,j);
            W0=W(i,j);
            % 3 j-1
            % 4 j+1
            if is_wall(i, j) == 1 % down
                Psi(i,j)=0;
                W(i,j)=-2*(Psi(i+1,j)-Psi(i,j))/hy^2;
                dW=dW+abs(W(i,j)-W0);
                
            elseif is_wall(i, j) == 2 % up
                Psi(i,j)=1;
                W(i,j)=-2*(Psi(i-1,j)-Psi(i,j))/hy^2;
                dW=dW+abs(W(i,j)-W0);
              
            elseif is_wall(i, j) == 3 && y(i) < obstacleHeight % up
                Psi(i,j)=0;
                W(i,j)=-2*(Psi(i,j-1)-Psi(i,j))/hx^2;
                dW=dW+abs(W(i,j)-W0);
            elseif is_wall(i, j) == 3 && y(i) > obstacleHeight % up
                Psi(i,j)=1;
                W(i,j)=-2*(Psi(i,j-1)-Psi(i,j))/hx^2;
                dW=dW+abs(W(i,j)-W0);
                
            elseif is_wall(i, j) == 4 && y(i) < obstacleHeight
                Psi(i,j)=0;
                W(i,j)=-2*(Psi(i,j+1)-Psi(i,j))/hx^2;
                dW=dW+abs(W(i,j)-W0);
            elseif is_wall(i, j) == 4 && y(i) > obstacleHeight % up
                Psi(i,j)=1;
                W(i,j)=-2*(Psi(i,j+1)-Psi(i,j))/hx^2;
                dW=dW+abs(W(i,j)-W0);
            else
                % inner points start
                if is_wall(i,j) == 7
                    Ux=(Psi(i+1,j)-Psi(i-1,j))*0.5/hy;
                    Uy=-(Psi(i,j+1)-Psi(i,j-1))*0.5/hx;
                    ReUxhy=Re*Ux*hy;
                    EUx=exp(Re*Ux*hx);
                    if abs(Ux) < 1e-8
                        a1x=hy/hx;
                    else
                        a1x=ReUxhy/(EUx-1);
                    end
                    a0x=a1x*EUx;
                    ReUyhx=Re*Uy*hx;
                    EUy=exp(Re*Uy*hy);
                    if abs(Uy) < 1e-8
                        a1y=hx/hy;
                    else
                        a1y=ReUyhx/(EUy-1);
                    end
                    a0y=a1y*EUy;
                    W(i,j)=(a1x*W(i,j+1)+a0x*W(i,j-1)+a1y*W(i+1,j)+a0y*W(i-1,j));
                    W(i,j)=W(i,j)/(a1x+a0x+a1y+a0y);
                    W(i,j)=W0+qw*(W(i,j)-W0);
                    dW=dW+abs((W(i,j)-W0));
                    Psi(i,j)=(Psi(i,j-1)+Psi(i,j+1))*hy*hy+(Psi(i+1,j)+Psi(i-1,j))*hx*hx+W(i,j)*hx*hx*hy*hy;
                    Psi(i,j)=Psi(i,j)/(2*(hx*hx+hy*hy));
                    Psi(i,j)=Psi0+qp*(Psi(i,j)-Psi0);
                    dPsi=dPsi+abs((Psi(i,j)-Psi0));
                 % inner points end
                 
                % exit points start
                elseif(is_wall(i, j) == 6)
                    Psi(i,j)=Psi(i,j-1);
                    % Psi(i,j)=3.*y(i)^2-2.*y(i)^3;
                    dPsi=dPsi+abs(Psi(i,j)-Psi0);
                    W(i,j)=W(i,j-1);
                    % W(i,j)=6.*(1.-2.*y(i));
                    dW=dW+abs(W(i,j)-W0);
                % exit points end
                end
            end
        end
    end
    sw=dW/sum(sum(abs(W)));
    if st<abs(sw)
        st=abs(sw);
    end
    sp=dPsi/sum(sum(abs(Psi)));
    if st<abs(sp)
        st=abs(sp);
    end
    n=n+1;
    if rem(n,50)==0
        disp(n);disp(st);
    end
end
contour(x, y, Psi);

re = [0.01 10 20 30 40 50 60 70 80 90 100];
breakawayZoneLength = [
    (3.1 - obst32x)
    (3.5 -obst32x)
    (3.7-obst32x)
    (4.1 -obst32x)
    (4.5 -obst32x)
    (4.6 -obst32x)  
    (5 -obst32x) 
    (5.3 -obst32x) 
    (5.6 -obst32x) 
    (5.7 -obst32x) 
    (5.8 -obst32x) 
];
% plot(re, breakawayZoneLength)