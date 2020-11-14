close all, clear all, clc, format compact
% define segments of time vector
dt = 0.01; % time step [seconds]
t1 = 0 : dt : 3; % first time vector [seconds]
t2 = 3+dt : dt : 6; % second time vector [seconds]
t = [t1 t2]; % complete time vector [seconds]
% define signal
y = [sin(4.1*pi*t1) .8*sin(8.3*pi*t2)];
% plot signal
plot(t,y,'.-')
xlabel('Time [sec]');
ylabel('Target Signal');
grid on
ylim([-1.2 1.2])
p = con2seq(y);
% The resulting network will predict the next value of the target signal
% using delayed values of the target.
inputDelays = 1:5; % delayed inputs to be used
learning_rate = 0.2; % learning rate
% define ADALINE
net = linearlayer(inputDelays,learning_rate);
% before the next step in the sequence is presented. Thus the network is
% updated N times. The output signal and the error signal are returned,
% along with new network.
[net,Y,E] = adapt(net,p,p);
% view network structure
view(net)
% check final network parameters
disp('Weights and bias of the ADALINE after adaptation')
net.IW{1}
net.b{1}
% transform result vectors
Y = seq2con(Y); Y = Y{1};
E = seq2con(E); E = E{1};
% start a new figure
figure;
% first graph
subplot(211)
plot(t,y,'b', t,Y,'r--');
legend('Original','Prediction')
grid on
xlabel('Time [sec]');
ylabel('Target Signal');
ylim([-1.2 1.2])
% second graph
subplot(212)
plot(t,E,'g');
grid on
legend('Prediction error')
xlabel('Time [sec]');
ylabel('Error');
ylim([-1.2 1.2])