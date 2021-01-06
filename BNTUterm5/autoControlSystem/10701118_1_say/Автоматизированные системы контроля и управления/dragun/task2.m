w=0:1000;
yr=j^2*w.^2+2*j*w+11; 
x=real(yr);
y=imag(yr);

plot(x,y, 'g.-');
grid on;

title('Hodograph Michailova');
xlabel('Real axes');
ylabel('Image axes');