function h = shenoid_lp(wc_pi,N)
    wc = wc_pi*pi;
    n = -floor(N/2):ceil(N/2);
    n = n(1:N);
    h = sin(wc*n)./(pi*n);
    h(isnan(h)) = wc/pi;
end