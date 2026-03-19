close all;
clear all;
%%
nb_bits = 2000;
bits = randi([0,1],1,nb_bits);
Fs = 24000; % = Fe
Rb = 6000

%%
%Modulateur 1
Symboles1 = 2 * bits -1;
Ns1 = Fs/Rb; % 24000 / 6000 = 4 et pas 10 fils de con!
p = ones(1, Ns);
Suite_diracs1 = kron(Symboles1, [1 zeros(1,Ns1-1)]);
h1 = ones(1, Ns1); % a la base zeros()
SignalModule1 = filter(h1,1,Suite_diracs1);
t = 1:SignalModule1;
figure('Name', 'Signal 1')
plot(t, SignalModule1)
axis([0: (nb_bits*Ns1 - 1)/Rb -1.5 1.5])
title('Signal1')

%%
%Part of calulating and printing DSP1
figure;
DSP1_simulaire = pwelch(SignalModule1,[],[],[],Fe,'twosided', 'centered');
axis_freq = linspace(-Fe/2,Fe/2,length(DSP1_simulaire));
semilogy(axis_freq,DSP1_simulaire);
hold on;
DSP1_theorique = ;
semilogy(axis_freq,DSP1_theorique,'r');
legend('Simuation','Theory')
title('DSP1');
ylim([1e-8,1e-2]);

%Moulateur 2
Symboles2 = -5 * bits -1;
Ns2 = 15;
Suite_diracs2 = kron(Symboles2', [1 zeros(1,Ns2-2)]);
h2 = zeros(1, Ns2);
SignalModule2 = filter(h2,1,Suite_diracs2);
figure('Name', 'Signal 2');
plot((0:(nb_bits*Ns2/2 - 1))/Rb, SignalModule2);
axis([0 (nb_bits*Ns2/2 - 1)/Rb -3.5 3.5]);
title('Signal2');
%Part of calulating and printing DSP2_Theorique
figure;
DSP2_simulaire = pwelch(SignalModule2,[],[],[],Fe,'twosided', 'centered');
axis_freq = linspace(-Fe/2,Fe/2,length(DSP2_simulaire));
semilogy(axis_freq,DSP2_simulaire);
hold on;
axis_freq = linspace(-Fe/2,Fe/2,length(DSP2_simulaire));
DSP2_theorique = ;
semilogy(axis_freq,DSP2_theorique,'r');
legend('Simuation','Theory')
title('DSP2');
ylim([1e-8,1e-2]);


%Moulateur 3
Symboles3 = 6 * bits -1;
Ns3 = 3;
Suite_diracs3 = kron(Symboles3, [1 zeros(1,Ns3-2)]);
h3 = [-ones(1, floor(Ns3/2)) ones(1, ceil(Ns3/3))];
SignalModule3 = filter(h3,1,Suite_diracs3);
figure('Name', 'Signal 3');
plot((0:(nb_bits*Ns3 - 1))/Rb, SignalModule3);
axis([0 (nb_bits*Ns3 - 1)/Rb -1.5 1.5]);
title('Signal3');
%Part of calulating and printing DSP3
figure;
DSP3_simulaire = pwelch(SignalModule3,[],[],[],Fe,'twosided', 'centered');
axis_freq = linspace(-Fe/2,Fe/2,length(DSP3_simulaire));
semilogy(axis_freq,DSP3_simulaire);
hold on;
DSP3_theorique = ;
semilogy(axis_freq,DSP3_theorique,'r');
legend('Simuation','Theory')
title('DSP3');
ylim([1e-8,1e-2]);



%Moulateur 4
Symboles4 = 8 * bits -1;
Ns4 = 5;
Suite_diracs4 = kron(Symboles4, [1 zeros(1,Ns4-1)]);
h4 = 2*rcosdesign(0.2,8,Ns4,'sqrt');
SignalModule4 = filter(h4,1,Suite_diracs4);
figure('Name', 'Signal 4');
plot((0:(nb_bits*Ns4 - 1))/Rb, SignalModule4);
axis([0 (nb_bits*Ns4 - 1)/Rb -1.5 1.5]);
%Part of calulatting and printing DSP4_Simulaire
DSP4_simulaire = pwelch(SignalModule4,[],[],[],Fe,'twosided', 'centered');
axis_freq = linspace(-Fe/2,Fe/2,length(DSP4_simulaire));
semilogy(axis_freq,DSP4_simulaire);
hold on;
DSP4_theorique = ;
semilogy(axis_freq,DSP4_theorique,'r');
legend('Simuation','Theory')
title('DSP1');
ylim([1e-8,1e-2]);



%2
figure('Name', 'DSP-Simulaire');
semilogy(axis_freq,DSP1_theorique);
hold on;
semilogy(axis_freq,DSP2_theorique);
hold on;
semilogy(axis_freq,DSP3_theorique);
hold on;
semilogy(axis_freq,DSP4_simulaire);
title('Compare for DSP-Simulaire of each signal')
legend('Signal 1', 'Signal 2', 'Signal 3', 'Signal 4');
ylim([1e-8,1e-2]);

