function [H,f] = filter_fft(h,fs)
    N = length(h);
    H = abs(fft(h));
    df = fs/2/(N/2);
    f = 0:df:(fs/2-df);
    plot(f,H(1:floor(N/2)))
    grid on
    xlabel('f [Hz]')
    ylabel('|H|')
end
