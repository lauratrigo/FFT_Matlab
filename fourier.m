% -------------------------------------------------------------------------
% Código para análise espectral (Transformada de Fourier) de dados ionosféricos
% 
% Descrição:
%   Este script carrega dados de ionosfera e plota a transformada de Fourier
%   unilateral (apenas frequências positivas) e bilateral (frequências positivas
%   e negativas) para três parâmetros ionosféricos: hF, f0F2 e hmF2.
%
% Arquivo de entrada:
%   SAA0K_20031004(277).TXT - Arquivo de dados ionosféricos
%
% Parâmetros analisados:
%   - hF: Altura do ponto F
%   - f0F2: Frequência crítica da camada F2
%   - hmF2: Altura da densidade de pico da camada F2
%
% Autor: [Seu Nome]
% Data: [Data de criação]
% GitHub: [Seu link do GitHub]
% -------------------------------------------------------------------------

% Limpa o ambiente de trabalho (variáveis, figuras, console)
close all  % Fecha todas as figuras
clear all  % Limpa todas as variáveis
clc        % Limpa a janela de comando

% Define o vetor de tempo (96 pontos, assumindo 1 ponto a cada 15 minutos)
tempo = 1:96;

% Carrega os dados do arquivo TXT
dados = importdata('SAA0K_20031004(277).TXT');
dados = dados.data;  % Extrai a matriz de dados

% Extrai as colunas de interesse
hmF2(:,1) = dados(:,11);  % Altura da densidade de pico da camada F2
hF(:,1) = dados(:,10);    % Altura do ponto F
f0F2(:,1) = dados(:,9);   % Frequência crítica da camada F2

% Configurações para a Transformada de Fourier
Fs = 1/(15*60);  % Frequência de amostragem (1 amostra a cada 15 minutos = 1/900 Hz)
T = 1/Fs;        % Período de amostragem (900 segundos = 15 minutos)
L = length(tempo);  % Número de pontos no sinal

% Cria um vetor de tempo para plotagem
t = (0:L-1)*T;  % Vetor de tempo em segundos

% -------------------------------------------------------------------------
% Análise espectral para hF (Altura do ponto F)
% -------------------------------------------------------------------------
subplot(3,1,1)  % Cria o primeiro subplot (3 linhas, 1 coluna)

% Calcula a FFT (Transformada Rápida de Fourier)
Y = fft(hF(:,1));

% Plotagem do espectro unilateral (apenas frequências positivas)
plot(Fs/L*(0:L-1), abs(Y), "LineWidth", 3)
title("Espectro unilateral de hF")
xlabel("f (Hz)")
ylabel("|fft(X)|")

% Plotagem do espectro bilateral (frequências positivas e negativas)
plot(Fs/L*(-L/2:L/2-1), abs(fftshift(Y)), "LineWidth", 3)
title("Espectro bilateral de hF")
xlabel("f (Hz)")
ylabel("|fft(X)|")

% -------------------------------------------------------------------------
% Análise espectral para f0F2 (Frequência crítica da camada F2)
% -------------------------------------------------------------------------
subplot(3,1,2)  % Cria o segundo subplot

Y = fft(f0F2(:,1));

% Plotagem do espectro unilateral
plot(Fs/L*(0:L-1), abs(Y), "LineWidth", 3)
title("Espectro unilateral de f0F2")
xlabel("f (Hz)")
ylabel("|fft(X)|")

% Plotagem do espectro bilateral
plot(Fs/L*(-L/2:L/2-1), abs(fftshift(Y)), "LineWidth", 3)
title("Espectro bilateral de f0F2")
xlabel("f (Hz)")
ylabel("|fft(X)|")

% -------------------------------------------------------------------------
% Análise espectral para hmF2 (Altura da densidade de pico da camada F2)
% -------------------------------------------------------------------------
subplot(3,1,3)  % Cria o terceiro subplot

Y = fft(hmF2(:,1));

% Plotagem do espectro unilateral
plot(Fs/L*(0:L-1), abs(Y), "LineWidth", 3)
title("Espectro unilateral de hmF2")
xlabel("f (Hz)")
ylabel("|fft(X)|")

% Plotagem do espectro bilateral
plot(Fs/L*(-L/2:L/2-1), abs(fftshift(Y)), "LineWidth", 3)
title("Espectro bilateral de hmF2")
xlabel("f (Hz)")
ylabel("|fft(X)|")