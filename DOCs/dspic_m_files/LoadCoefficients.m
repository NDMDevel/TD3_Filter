function LoadCoefficients(varargin)
%Crea el archivo 'LoadCoefficients.c' con los coeficientes de la respuesta
%al impulso. Genera dentro del archivo .c las funciones LoadCoefficientsFIR
% o LoadCoefficientsIIR. El primer argumento debe ser la direccion en la
% que se crea el archivo .c, es conveniente seleccionar la carpeta donde se
% almacena el proyecto de MPLAB X.
%Ejemplo:
%      El vector [0 0.1 0.2 0.3 0.4] se considera la h de un filtro fir
%   en donde el orden es la longitud del vector:
%   >> LoadCoefficientsFIR('C:\MPLAB_PROJECT.X\',[0 0.1 0.2 0.3 0.4]);
%
%      Los vectores [0 0.1 0.2 0.3 0.4] y [0.5 0.6 0.7 0.8 0.9] se
%   consideran el numerador y denominador respectivamente de la funcion
%   de transferencia del filtro IIR:
%   en donde el orden es la longitud del vector:
%   >> LoadCoefficientsFIR('C:\MPLAB_PROJECT.X\',[0 0.1 0.2 0.3 0.4],[0.5 0.6 0.7 0.8 0.9]);
    filename = 'LoadCoefficients.c';
    if nargin == 2
        path = varargin{1};
        f = fopen(strcat(path,filename),'w+');
        h = varargin{2};
        N = length(h);
        fprintf(f,'#include "DspLibrary.h"\n\n');
        fprintf(f,'extern ImpulseResponse h;\n\n');
        fprintf(f,'void LoadCoefficientsFIR(void)\n{\n');
        for n=1:N
            fprintf(f,'\th.fir[%d] = 0x%s;\n',n-1,dec2q15(h(n),'hex'));
        end
        fprintf(f,'}\n');
        fclose(f);
    elseif nargin == 3
        path = varargin{1};
        f = fopen(strcat(path,filename),'w+');
        num = varargin{2};
        den = varargin{3};
        N = length(den);
        if N ~= length(num)
            error('Las longitudes del numerador y denominador deben coincidir.');
        end
        fprintf(f,'#include "DspLibrary.h"\n\n');
        fprintf(f,'extern ImpulseResponse h;\n\n');
        fprintf(f,'void LoadCoefficientsIIR(void)\n{\n');
        for n=1:N
            fprintf(f,'\th.irr.num[%d] = 0x%s;\t',n-1,dec2q15(num(n),'hex'));
            fprintf(f,'h.irr.den[%d] = 0x%s;\n',n-1,dec2q15(den(n),'hex'));
        end
        fprintf(f,'}\n');
        fclose(f);
    else
        error('Solo dos o tres argumentos deben usarse');
    end
end
