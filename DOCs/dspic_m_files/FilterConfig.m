function FilterConfig(varargin)
%FilterConfig(input args)
%
%   Configura mediante el puerto serie el filtro implementado en el dsPIC.
%   Se puede configurar:
%   - La frecuencia de muestreo del filtro 'fs'.
%   - La respuesta al impulso 'h[n]'.
%   - El orden del filtro 'N'.
%
%   Los argumentos de entrada pueden ser ninguno, 1 o 2:
%   - Sin argumentos de entrada:
%       El script asumira que el puerto de comunicacion es el 'COM1' y la
%       velocidad de comunicacion 9600 baudios.
%   - 1 argumento de entrada:
%       Debe ser una cadena de caracteres indicando el puerto COM usado,
%       por ejemplo 'COM1'. El script asumira que la velocidad de
%       comunicacion es de 9600 baudios.
%           Ejemplo de uso:
%           >> FilterConfig('COM1')
%   - 2 argumentos de entrada:
%       El primer argumento debe ser una cadena de caracteres indicando el
%       puerto COM usado, por ejemplo 'COM1'. El segundo argumento debe ser
%       la velocidad en baudios, por ejemplo 9600.
%           Ejemplo de uso:
%           >> FilterConfig('COM1',9600)

    % apaga las advertencias para mantener la consola limpia
    warning off

    % limpia la consola e imprime un 'splash'
    clc
    fprintf('**************************************************\n');
    fprintf('***************** FilterConfig *******************\n');
    fprintf('**************************************************\n\n');
    
    %{
    ComPort = 'COM1';
    BaudRate = 9600;
    switch nargin
        case 1
            ComPort = varargin{1};
        case 2
            ComPort = varargin{1};
            BaudRate = varargin{2};
    end
    
    % a modo informativo, imprime en pantalla la configuracion actual
    fprintf('Usando:\n\tPort: %s\n\tBaud: %d\n',ComPort,BaudRate);    
    %}
    
    % cierra todos los puertos abiertos previamente (si es que hay alguno
    % abierto)
    if ~isempty(instrfind)
        fclose(instrfind);      % cierra los puertos
    end
    
    % limpia el objeto de MATLAB que lleva que el registro de los puertos
    % abiertos (esto se hace para generar un 'clean start' del script)
    delete(instrfindall)
                                    
    % verifica que el puerto indicado exista
    reconfig_port = 0;
    port_ok = 0;
    while port_ok == 0
        try
            s = serial(ComPort,'BaudRate',BaudRate);
            fopen(s);
            port_ok = 1;
        catch exception
            reconfig_port = 1;
            delete(instrfindall)
            exception = exception.message;
            init_pos = strfind(exception,'Available ports: ');
            if isempty(init_pos)
                error('No hay puertos COM disponibles.')
            else
                available_ports = exception((init_pos+length('Available ports: ')):(strfind(exception,'Use INSTRFIND')-3));
                available_ports = strsplit(available_ports,', ');
                fprintf('ERROR:\tel puerto ''%s'' no existe.\n\t\tLos puertos disponibles son:\n',ComPort)
                option = '';
                n_ports = length(available_ports);
                for k=1:n_ports
                    fprintf('\t\t%d -> ''%s''\n',k,char(available_ports(k)))
                    option = strcat(option,char(k+48));
                    option = strcat(option,'|');
                end
                option(end) = '';
            end
            repeat = 1;
            while repeat == 1
                answer = sprintf('Selecione alguno de los puertos dispinibles [%s] o ''exit'' para salir: ',option);
                answer = input(answer,'s');
                try
                    if strcmp(strtrim(answer),'exit')
                        fprintf('\n\tBye!\n\n')
                        return;
                    end
                    answer = str2double(answer);
                    if ~isempty(find((1:n_ports)==answer,1))
                        ComPort = char(available_ports(answer));
                        repeat = 0;
                    end
                end
                if repeat ~= 0
                    fprintf('Opcion incorrecta, reintente.\n');
                end
            end
        end
    end
    
    % a modo informativo, si se reconfiguro el puerto vuelve a imprimir en
    % pantalla la configuracion actual
    if reconfig_port == 1
        fprintf('Usando:\n\tPort: %s\n\tBaud: %d\n',ComPort,BaudRate);
    end
    
    % llega aca si el puerto fue abierto con exito
    
    
    
    % mensaje de salida
    fprintf('\nSaliendo...\n\n');
    
    % cierra el puerto serie
    fclose(s);
    delete(instrfindall)
end