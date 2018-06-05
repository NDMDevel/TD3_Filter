function double = q152double(q15)
%Solo admite argumentos en hex (en forma de cadena de caracteres), o en
%formato entero.
%Ejemplo:
% >> q152double('FFAB');
% >> q152double(1234);
    if ischar(q15) == 1
        q15 = hex2dec(q15);
    end
    bin = dec2bin(q15);
    N = length(bin);
    if N > 16
        error('El argumento debe tener como maximo 16 bits.');
    elseif N < 16
        bin = sprintf('%016s',bin);
    end
    double = 0;
    for i=2:16
        if bin(i) == '1'
            double = double + 2^(-(i-1));
        end
    end
    if bin(1) == '1'
        double = -1+double;
    end
end