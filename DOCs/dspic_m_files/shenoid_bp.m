function h = shenoid_bp(wc1_pi,wc2_pi,N)
% Devuelve la respuesta al impulso de un FIR BandPass de orden N.
% Argumentos de entrada:
% wc1_pi: frecuencia de corte normalizada izquierda (valor entre 0 y 1)
% wc2_pi: frecuencia de corte normalizada derecha (valor entre 0 y 1)
% N: orden del filtro
%
% Ejemplo de uso:
% >> h = shenoid_bp(0.2,0.6,120);
% >> freqz(h,1,256); % esto es opcional, plotea la respuesta en frecuencia
    wc1 = wc1_pi*pi;
    wc2 = wc2_pi*pi;
    n = -floor(N/2):ceil(N/2);
    n = n(1:N);
    h = (sin(wc2*n)-sin(wc1*n))./(pi*n);
    h(isnan(h)) = (wc2-wc1)/pi;
end