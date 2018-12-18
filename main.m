% Sterowanie zlozonymi ukladami mechanicznymi
% Sprawozdanie 3
% Agnieszka Opalka, Ewa Walkowiak, AiR, 2018/2019

L = 10; % rozstaw kól robota
R = 2; % promien kola robota
% warunki poczatkowe
X0 = 0; 
Y0 = 0;
theta = pi/4;
omega = 2.5; % maksymalna predkosc katowa
step = 0.01;
t = 0:0.01:10;

% rysowanie polozenia poczatkowego
hold on;
subplot(2,2,[1,3]) % jeden plot po lewej i dwa po prawej... ogarnac
plot(X0, Y0,".");
X = [X0+sin(theta)*L/2 X0-(sin(theta)*L/2)];
Y = [Y0+(-cos(theta)*L/2) Y0-(-cos(theta)*L/2)];
plot(X,Y);
plot(X,Y,"*");
pbaspect([1 1 1])
hold off

% wartosci wysylane do arduino
kolo1 = 100/255;
kolo2 = 225/255;
PWMkolo1 = abs(kolo1*100); % procent wypelnienia PWM dla kola 1
PWMkolo2 = abs(kolo2*100); % procent wypelnienia PWM dla kola 2
omega1 = kolo1*omega;
omega2 = kolo2*omega;

subplot(2,2,2)
a = max(square(2*pi*t,PWMkolo1),0); 
plot(t,a);
axis([0 5 -0.1 1.1]);
title(['PWM ko³a 1 - ' num2str(PWMkolo1) '%']);
grid on;
    
subplot(2,2,4)
b = max(square(2*pi*t,PWMkolo2),0); 
plot(t,b);
axis([0 5 -0.1 1.1]);
title(['PWM ko³a 2 - ' num2str(PWMkolo2) '%']);
grid on;

% rysowanie kolejnych kroków    
while (1)
	X0 = X0 + (omega1+omega2)*R/2*cos(theta)*step;
	Y0 = Y0 + (omega1+omega2)*R/2*sin(theta)*step;
	theta = theta + (omega1-omega2)*R/L*step;
	X = [X0+sin(theta)*L/2 X0-(sin(theta)*L/2)];
	Y = [Y0+(-cos(theta)*L/2) Y0-(-cos(theta)*L/2)];
	subplot(2,2,[1,3])
	plot(X,Y);
	hold on;
	axis([-50 50 -50 50]);
	plot(X,Y,"*");
    pbaspect([1 1 1])
    hold off;
    
    pause(0.01);
end