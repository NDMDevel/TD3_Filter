function A = MAC(x,h)
% Ejemplo de uso
% A = MAC(['C000';'FFFF';'EEEE';'DDDD';'CCCC';'BBBB'],['C000';'0022';'0332';'0044';'6555';'0044'])
    N = size(x);
    if N ~= size(h)
        error('Las dimensiones de los argumentos deben coincidir.');
    end
    X = zeros(1,N(1));
    for i=1:N(1)
        X(i) = q152double(x(i,:));
    end
    H = zeros(1,N(1));
    for i=1:N(1)
        H(i) = q152double(h(i,:));
    end
    x = X(:)';
    h = H(:)';
    A = sum(x.*h);
    fprintf('\n\tMAC Result: %s\n\n',dec2q15(A,'hex'));
end