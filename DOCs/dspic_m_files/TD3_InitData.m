function TD3_InitData(varargin)
% Genera el header para dsPIC llamado TD3_InitData.h en funcion de los
% coeficientes del filtro que se pasan como argumento.
% Admite 2 o 3 argumentos de entrada.
% La direccion en la que se genera el archivo TD3_InitData.h esta indicada
% en el tercer argumento (si esta presente); si no hay tercer argumento se
% lo genera en el directorio de trabajo.
%
% Argumentos de entrada:
% Puede ser 2 o 3.
% Con 2 args de entrada:
%       El primero arg es el vector numerador del filtro.
%       El segundo arg es el vector denominador del filtro.
% Con 3 arg de entrada:
%       El primero arg es el vector numerador del filtro.
%       El segundo arg es el vector denominador del filtro.
%       El tercer arg es la direccion en donde se desea generar
%           el archivo TD3_InitData.h.
% Argumentos de salida: Ninguno (solo genera el header TD3_InitData.h)
%
% Ejemplos de uso:
% Para un IIR:
% >> TD3_InitData(num,den,'C:\PROJECT.X');
%
% Para un FIR:  (notar el vector denominador que esta vacio)
% >> TD3_InitData(num,[],'C:\PROJECT.X');
%
    filename = 'TD3_InitData.h';
    if nargin == 2
        path = filename;
    elseif nargin == 3
        path = varargin{3};
        if path(length(path)) ~= '\'
            path = strcat(path,'\');
%            path = strcat(path,filename);
        end
        path = strcat(path,filename);
    else
        error('Solo 2 o 3 argumentos son admisibles.');
    end
    num = varargin{1};
    den = varargin{2};
    N = length(num);
    Nd = length(den);
    f = fopen(path,'w');
    fprintf(f,'#ifndef TD3_INITDATA_H\n');
    fprintf(f,'#define TD3_INITDATA_H\n');
    fprintf(f,'\n');
    fprintf(f,'#define N\t%d\n',N+Nd);
    fprintf(f,'#define Nminus1\tN-1\n');
    fprintf(f,'\n');
    fprintf(f,'#define TD3_LOAD_MACRO =\\\n');
    fprintf(f,'{');
    i = 1;
    while i<=N
        fprintf(f,'\\\n');
        cols = 0;
        fprintf(f,'\t');
        while cols<=5 && i<=N
            fprintf(f,'0x%04s',dec2q15(num(i),'hex'));
            if i<N || Nd>0
                fprintf(f,',');
            end
            i = i + 1;
            cols = cols + 1;
        end
    end
    i = 1;
    while i<=Nd
        fprintf(f,'\\\n');
        cols = 0;
        fprintf(f,'\t');
        while cols<=5 && i<=Nd
            fprintf(f,'0x%04s',dec2q15(den(i),'hex'));
            if i<Nd
                fprintf(f,',');
            end
            i = i + 1;
            cols = cols + 1;
        end
    end
    fprintf(f,'\\\n};\n\n');
    fprintf(f,'#endif\n');
    fclose(f);
end