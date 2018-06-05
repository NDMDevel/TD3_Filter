function LoadSamples(varargin)
%Crea el archivo 'LoadSamples.c' con las muestras de entrada.
%Genera dentro del archivo .c las funciones LoadSamplesFIR
% o LoadSamplesIIR. El primer argumento debe ser la direccion en la
% que se crea el archivo .c, es conveniente seleccionar la carpeta donde se
% almacena el proyecto de MPLAB X.
    filename = 'LoadSamples.c';
    if nargin == 2
        path = varargin{1};
        f = fopen(strcat(path,filename),'w+');
        x = varargin{2};
        N = length(x);
        fprintf(f,'#include "DspLibrary.h"\n\n');
        fprintf(f,'extern Samples samples;\n\n');
        fprintf(f,'void LoadSamplesFIR(void)\n{\n');
        for n=1:N
            fprintf(f,'\tsamples.fir[%d] = 0x%s;\n',n-1,dec2q15(x(n),'hex'));
        end
        fprintf(f,'}\n');
        fclose(f);
    elseif nargin == 3
        path = varargin{1};
        f = fopen(strcat(path,filename),'w+');
        x = varargin{2};
        y = varargin{3};
        N = length(x);
        if N ~= length(y)
            error('Las longitudes de las muestras de entrada y salida deben coincidir.');
        end
        fprintf(f,'#include "DspLibrary.h"\n\n');
        fprintf(f,'extern Samples samples;\n\n');
        fprintf(f,'void LoadSamplesIIR(void)\n{\n');
        for n=1:N
            fprintf(f,'\tsamples.irr.x[%d] = 0x%s;\t',n-1,dec2q15(x(n),'hex'));
            fprintf(f,'samples.irr.y[%d] = 0x%s;\n',n-1,dec2q15(y(n),'hex'));
        end
        fprintf(f,'}\n');
        fclose(f);
    else
        error('Solo dos o tres argumentos deben usarse');
    end
end