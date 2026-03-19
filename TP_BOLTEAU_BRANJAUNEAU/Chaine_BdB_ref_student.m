
clear all
close all

%PARAMETRES
%Ordre de la modulation
M=2
%Fréquence d'échantillonnage
Fe=24000;
%Débit binaire
Rb=6000; %en bit/s = 1/Tb
%Facteur de suréchantillonnage
Ns=;
%Réponse impulsionnelle du filtre de mise en forme
h=ones(1,);
%Réponse impulsionnelle du filtre de réception
hr=fliplr();
%Valeurs de Eb/N0 à tester
tab_Eb_sur_N0_dB=[0:8];
N_bit_block = 1000;
%BOUCLE SUR LES VALEURS DE Eb/N0
for indice_Eb_sur_N0=0:length(tab_Eb_sur_N0_dB)-1
    %Valeur testée
    Eb_sur_N0_dB=tab_Eb_sur_N0_dB(indice_Eb_sur_N0+1)
    %Compteurs (erreurs, nombre de boucles)
    nb_erreurs=0;
    compteur=0;
    %Variable de cumul pour le TEB
    TEB_simu_cumul=0;
    
    %BOUCLE SUR LE NOMBRE D'ERREURS (voir précision sur la mesure du TEB)
    while(nb_erreurs<1000)
        
        %MODULATEUR BANDE DE BASE
        %-----------------------------------------------------------------------
        %Information binaire
        bits=randi([0,1],1,N_bit_block);
        %Mapping binaire à moyenne nulle
        symboles=;
        %Suéchantillonnage
        diracs=kron(symboles,[1 zeros(1,)]);
        %Filtrage de mise en forme
        signal_emis=filter(h,1,diracs);

        %CANAL DE PROPAGATION AWGN
        %----------------------------------------------------------------------
        %Puissance du signal
        Pr=mean(abs(signal_emis).^2);
        %Puissance du bruit
        Pb=;
        %Génération du bruit
        bruit=sqrt()*randn(1,length(signal_emis));
        %Ajout du bruit
        signal_recu=signal_emis+bruit;

        %DEMODULATEUR BANDE DE BASE
        %---------------------------------------------------------------------
        %Filtrage de réception
        signal_filtre=filter(hr,1,signal_recu);
        %Choix de t0
        t0=;
        %Echantillonnage
        signal_echantillonne=signal_filtre(::end);
        %Décisions
        symboles_decides=;
        %Demapping
        bits_decides=;
        %Estimation du TEB pour cette boucle
        nb_erreurs=nb_erreurs+;
        TEB_simu_cumul=TEB_simu_cumul+;
        compteur=compteur+1;
    end
    %TEB SIMULE POUR LA VALEUR TESTEE DE Eb/N0
    TEB_simu(indice_Eb_sur_N0+1)=;
end

%TEB THEORIQUE
TEB_th = ;
%TRACES DES TEBs THEORIQUE ET SIMULE
figure
semilogy(tab_Eb_sur_N0_dB,TEB_th,'r-o')
hold on
semilogy(tab_Eb_sur_N0_dB,TEB_simu,'b-+')
xlabel('E_b/N_0')
ylabel('TEB')
legend('TEB théorique','TEB simulé');
grid



