function [result, status] = python(varargin)
%PYTHON Execute Python command and return the result.
%   PYTHON(PYTHONFILE) calls python script specified by the file PYTHONFILE
%   using appropriate python executable.
%
%   PYTHON(PYTHONFILE,ARG1,ARG2,...) passes the arguments ARG1,ARG2,...
%   to the python script file PYTHONFILE, and calls it by using appropriate
%   python executable.
%
%   RESULT=PYTHON(...) outputs the result of attempted python call.  If the
%   exit status of python is not zero, an error will be returned.
%
%   [RESULT,STATUS] = PYTHON(...) outputs the result of the python call, and
%   also saves its exit status into variable STATUS.
%

    
cmdString = '';
args = varargin{1};
nargs = length(args);

% Add input to arguments to operating system command to be executed.
% (If an argument refers to a file on the MATLAB path, use full file path.)
for i = 1:nargs
    thisArg = args{i};
    display(thisArg);
    if ~ischar(thisArg)
        error(message('MATLAB:perl:InputsMustBeStrings'));
    end
    if i==1
        if exist(thisArg, 'file')==2
            % This is a valid file on the MATLAB path
            if isempty(dir(thisArg))
                % Not complete file specification
                % - file is not in current directory
                % - OR filename specified without extension
                % ==> get full file path
                thisArg = which(thisArg);
            end
        else
            % First input argument is PythonFile - it must be a valid file
            error(message('MATLAB:perl:FileNotFound', thisArg));
        end
    end

    % Wrap thisArg in double quotes if it contains spaces
    if isempty(thisArg) || any(thisArg == ' ')
        thisArg = ['"', thisArg, '"']; %#ok<AGROW>
    end

    % Add argument to command string
    cmdString = [cmdString, ' ', thisArg]; %#ok<AGROW>
end

% Execute Python script
if isempty(cmdString)
    error(message('MATLAB:perl:NoPerlCommand'));
elseif ispc
    % PC
    % the pythonCmd need to be changed to fit your system's python2.7 path
    pythonCmd = fullfile('C:\Users\tangkk\Anaconda3\envs\python2\');
    cmdString = ['python' cmdString];
    pythonCmd = ['set PATH=',pythonCmd, ';%PATH%&' cmdString];
    [status, result] = dos(pythonCmd);
else
    % UNIX
    [status, ~] = unix('which python');
    if (status == 0)
        cmdString = ['python', cmdString];
        [status, result] = unix(cmdString);
    else
        error(message('MATLAB:perl:NoExecutable'));
    end
end

% Check for errors in shell command
if nargout < 2 && status~=0
    error(message('MATLAB:perl:ExecutionError', result, cmdString));
end

