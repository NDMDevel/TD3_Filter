function h = shenoid_lp(wc_pi,N)
% Devuelve la respuesta al impulso de un FIR LowPass de orden N.
% Argumentos de entrada:
% wc_pi: frecuencia de corte normalizada (valor entre 0 y 1)
% N: orden del filtro
%
% Ejemplo de uso:
% >> h = shenoid_lp(0.25,64);
% >> freqz(h,1,256); % esto es opcional, plotea la respuesta en frecuencia
    wc = wc_pi*pi;
    n = -floor(N/2):ceil(N/2);
    n = n(1:N);
    h = sin(wc*n)./(pi*n);
    h(isnan(h)) = wc/pi;
end