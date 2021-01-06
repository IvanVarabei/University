W = tf([0.02 1 0.01],[0.05 0.01 1])
figure(1)
step(W,50)
grid on
zero(W)
pole(W)
figure(2)
bode(W)
grid on
figure(3)
margin(W)
grid on