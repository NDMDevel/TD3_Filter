function h = shenoid_bp(wc1_pi,wc2_pi,N)
    wc1 = wc1_pi*pi;
    wc2 = wc2_pi*pi;
    n = -floor(N/2):ceil(N/2);
    n = n(1:N);
    h = (sin(wc2*n)-sin(wc1*n))./(pi*n);
    h(isnan(h)) = (wc2-wc1)/pi;
end