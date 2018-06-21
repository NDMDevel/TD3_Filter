function h = generate_filter(f,m,N,fs)
% generate_filter admite 4 argumentos de entrada:
% f: vector frecuencias
% m: vector de magnitudes
% N: orden del filtro
% fs: frecuencia de muestreo
% Ejemplo de uso:
% 
    b = fir2(N-1,f,m);
    [H,w] = freqz(b,1,256);
    f = w/pi*fs/2;
    
    h = b;    % numerador, coincide con h[n] del filtro
    %den = 1;    % denominador, siempre 1 porque es FIR
    
    subplot(2,1,1)
    plot(f,abs(H))
    ylabel('Magnitude [Gain]');
    xlabel('Freq [Hz]');
    grid on

    subplot(2,1,2);
    plot(f,unwrap(angle(H)))
    ylabel('Pahse');
    xlabel('Freq [Hz]');
    grid on
    generate_q15_coefs(b);
end