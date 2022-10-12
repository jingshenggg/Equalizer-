function varargout = FiveBands(varargin)
% FiveBands MATLAB code for FiveBands.fig
%      FiveBands, by itself, creates a new FiveBands or raises the existing
%      singleton*.
%
%      H = FiveBands returns the handle to a new FiveBands or the handle to
%      the existing singleton*.
%
%      FiveBands('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in FiveBands.M with the given input arguments.
%
%      FiveBands('Property','Value',...) creates a new FiveBands or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before FiveBands_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to FiveBands_OpeningFcn via varargin. 
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
% Edit the above text to modify the response to help FiveBands

% Last Modified by GUIDE v2.5 09-Mar-2022 11:02:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @FiveBands_OpeningFcn, ...
                   'gui_OutputFcn',  @FiveBands_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before FiveBands is made visible.
function FiveBands_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to FiveBands (see VARARGIN)

% Choose default command line output for FiveBands
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes FiveBands wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = FiveBands_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in StartButton.
function StartButton_Callback(hObject, eventdata, handles)
% hObject    handle to StartButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%filename = 'mydata.xlsx';
% on; % Send to recycle bin instead of permanently deleting
%delete(filename); % Delete (send to recycle bin)

global totalgain
global resetplay
global changes
global gain1
global gain2
global gain3
global gain4
global gain5
global freq1
global freq2
global freq3
global freq4
global freq5

resetplay = 3;

freq1 = 63;
freq2 = 125;
freq3 = 250;
freq4 = 500;
freq5 = 1000;
changes = 300;
assignin('base','freq1',freq1);
assignin('base','freq2',freq2);
assignin('base','freq3',freq3);
assignin('base','freq4',freq4);
assignin('base','freq5',freq5);

%bandwidth needs to be discussed, what will be the optimal number?
assignin('base','bw1',50);
assignin('base','bw2',50);
assignin('base','bw3',50);
assignin('base','bw4',50);
assignin('base','bw5',50);

set(handles.slider1,'value',0);
set(handles.slider2,'value',0);
set(handles.slider3,'value',0);
set(handles.slider4,'value',0);
set(handles.slider5,'value',0);
gain1 = get(handles.slider1,'value');
gain2 = get(handles.slider2,'value');
gain3 = get(handles.slider3,'value');
gain4 = get(handles.slider4,'value');
gain5 = get(handles.slider5,'value');
assignin('base','gain1',gain1);
assignin('base','gain2',gain2);
assignin('base','gain3',gain3);
assignin('base','gain4',gain4);
assignin('base','gain5',gain5);

totalgain = 10 - abs(gain1) - abs(gain2) - abs(gain3) - abs(gain4) - abs(gain5);
set(handles.text4,'String',gain1);
set(handles.text5,'String',gain2);
set(handles.text6,'String',gain3);
set(handles.text45,'String',gain4);
set(handles.text46,'String',gain5);
set(handles.text7,'String',totalgain);
set(handles.text32,'String',resetplay);
%set(handles.text33,'String',freq1);
%set(handles.text34,'String',freq2);
%set(handles.text35,'String',freq3);

set_param('SimulinkForEQ/Variable Bandwidth IIR Filter1','Commented','off');
set_param('SimulinkForEQ/Variable Bandwidth IIR Filter2','Commented','off');
set_param('SimulinkForEQ/Variable Bandwidth IIR Filter3','Commented','off');
set_param('SimulinkForEQ/Variable Bandwidth IIR Filter4','Commented','off');
set_param('SimulinkForEQ/Variable Bandwidth IIR Filter5','Commented','off');
sim('SimulinkForEQ');




% --- Executes on button press in PlayNext.
function PlayNext_Callback(hObject, eventdata, handles)
% hObject    handle to PlayNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global totalgain
global resetplay
global changes
global gain1
global gain2
global gain3
global gain4
global gain5
global freq1
global freq2
global freq3
global freq4
global freq5
totalgain = 10;
resetplay = resetplay - 1;
set_param('SimulinkForEQ/Variable Bandwidth IIR Filter5','Commented','off');

if resetplay < 0
    set_param('SimulinkForEQ','SimulationCommand','stop');

elseif resetplay >= 0
    if abs(gain1) == abs(gain2) && abs(gain2) == abs(gain3) && abs(gain3) == abs(gain4) && abs(gain4) == abs(gain5)
        set_param('SimulinkForEQ/Variable Bandwidth IIR Filter5','Commented','on');
        %set_param('SimulinkForEQ','SimulationCommand','update');

    elseif abs(gain1) > abs(gain2) && abs(gain1) > abs(gain3)
        freq2 = freq1;
        freq1 = freq2 - changes;
        freq3 = freq2 + changes;
        changes = changes - 50;
        set(handles.text33,'string',freq1);
        set(handles.text34,'string',freq2);
        set(handles.text35,'string',freq3);
    elseif abs(gain2) > abs(gain1) && abs(gain2) > abs(gain3)
        freq1 = freq2 - changes;
        freq3 = freq2 + changes;
        changes = changes - 50;
        set(handles.text33,'string',freq1);
        set(handles.text34,'string',freq2);
        set(handles.text35,'string',freq3);
    elseif abs(gain3) > abs(gain1) && abs(gain3) > abs(gain2)
        freq2 = freq3;
        freq1 = freq2 - changes;
        freq3 = freq2 + changes;
        changes = changes - 50;
        set(handles.text33,'string',freq1);
        set(handles.text34,'string',freq2);
        set(handles.text35,'string',freq3);
    end
    assignin('base','freq1',freq1);
    assignin('base','freq2',freq2);
    assignin('base','freq3',freq3);

    %bandwidth needs to be discussed, what will be the optimal number?
    assignin('base','bw1',50);
    assignin('base','bw2',50);
    assignin('base','bw3',50);
    assignin('base','bw4',50);
    assignin('base','bw5',50);

    set(handles.slider1,'value',0);
    set(handles.slider2,'value',0);
    set(handles.slider3,'value',0);
    gain1 = get(handles.slider1,'value');
    gain2 = get(handles.slider2,'value');
    gain3 = get(handles.slider3,'value');
    set(handles.text7, 'String',totalgain); %setting numberoftry back to 10
    set(handles.text4, 'String',gain1);
    set(handles.text5, 'String',gain2);
    set(handles.text6, 'String',gain3);
    assignin('base','gain1',gain1);
    assignin('base','gain2',gain2);
    assignin('base','gain3',gain3);
    set(handles.text32, 'String',resetplay);
    sim('SimulinkForEQ');
end




% --- Executes on button press in ResetGainButton.
function ResetGainButton_Callback(hObject, eventdata, handles)
% hObject    handle to ResetGainButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global totalgain;
global gain1
global gain2
global gain3
global gain4
global gain5

set(handles.slider1,'value',0);
set(handles.slider2,'value',0);
set(handles.slider3,'value',0);
set(handles.slider4,'value',0);
set(handles.slider5,'value',0);
gain1 = get(handles.slider1,'value');
gain2 = get(handles.slider2,'value');
gain3 = get(handles.slider3,'value');
gain4 = get(handles.slider4,'value');
gain5 = get(handles.slider5,'value');
totalgain = 10 - abs(gain1) - abs(gain2) - abs(gain3) - abs(gain4) - abs(gain5);
set(handles.text7, 'String',totalgain);
set(handles.text4, 'String',gain1);
set(handles.text5, 'String',gain2);
set(handles.text6, 'String',gain3);
set(handles.text45,'String',gain4);
set(handles.text46,'String',gain5);
assignin('base','gain1',gain1);
assignin('base','gain2',gain2);
assignin('base','gain3',gain3);
assignin('base','gain4',gain4);
assignin('base','gain5',gain5);
set_param('SimulinkForEQ','SimulationCommand','update');


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global totalgain
global gain1
global gain2
global gain3
global gain4
global gain5

gain1 = ceil(get(handles.slider1,'value') * 2)/2;
gain2 = ceil(get(handles.slider2,'value') * 2)/2;
gain3 = ceil(get(handles.slider3,'value') * 2)/2;
gain4 = ceil(get(handles.slider4,'value') * 2)/2;
gain5 = ceil(get(handles.slider5,'value') * 2)/2;

totalgain = 10 - abs(gain1) - abs(gain2) - abs(gain3) - abs(gain4) - abs(gain5);
assignin('base','gain1',gain1);
assignin('base','gain2',gain2);
assignin('base','gain3',gain3);
assignin('base','gain4',gain4);
assignin('base','gain5',gain5);
set(handles.text7, 'String',totalgain);
set(handles.text4, 'String',gain1);
assignin('base','gain1',gain1);
set_param('SimulinkForEQ','SimulationCommand','update');

if totalgain < 0
    if gain1 > 0
        gain1 = 10 - abs(gain2) - abs(gain3) - abs(gain4) - (gain5);
        assignin('base','gain1',gain1);
        assignin('base','gain2',gain2);
        assignin('base','gain3',gain3);
        assignin('base','gain4',gain4);
        assignin('base','gain5',gain5);
        set(handles.text4, 'String',gain1);
        set(handles.slider1,'value',gain1);
        set(handles.text7, 'String',0);
        set_param('SimulinkForEQ','SimulationCommand','update');
    elseif gain1 < 0
        gain1 = -10 + abs(gain2) + abs(gain3) + abs(gain4) + abs(gain5);
        assignin('base','gain1',gain1);
        assignin('base','gain2',gain2);
        assignin('base','gain3',gain3);
        assignin('base','gain4',gain4);
        assignin('base','gain5',gain5);
        set(handles.text4, 'String',gain1);
        set(handles.slider1,'value',gain1);
        set(handles.text7, 'String',0);
        set_param('SimulinkForEQ','SimulationCommand','update');
    end
end


% --- Executes during object creation, after setting all properties.
function slider1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global totalgain
global gain1
global gain2
global gain3
global gain4
global gain5

gain1 = ceil(get(handles.slider1,'value') * 2)/2;
gain2 = ceil(get(handles.slider2,'value') * 2)/2;
gain3 = ceil(get(handles.slider3,'value') * 2)/2;
gain4 = ceil(get(handles.slider4,'value') * 2)/2;
gain5 = ceil(get(handles.slider5,'value') * 2)/2;

totalgain = 10 - abs(gain1) - abs(gain2) - abs(gain3) - abs(gain4) - abs(gain5);
assignin('base','gain1',gain1);
assignin('base','gain2',gain2);
assignin('base','gain3',gain3);
assignin('base','gain4',gain4);
assignin('base','gain5',gain5);
set(handles.text7, 'String',totalgain);
set(handles.text5, 'String',gain2);
assignin('base','gain2',gain2);
set_param('SimulinkForEQ','SimulationCommand','update');

if totalgain < 0
    if gain2 > 0
        gain2 = 10 - abs(gain1) - abs(gain3) - abs(gain4) - (gain5);
        assignin('base','gain1',gain1);
        assignin('base','gain2',gain2);
        assignin('base','gain3',gain3);
        assignin('base','gain4',gain4);
        assignin('base','gain5',gain5);
        set(handles.text5, 'String',gain2);
        set(handles.slider2,'value',gain2);
        set(handles.text7, 'String',0);
        set_param('SimulinkForEQ','SimulationCommand','update');
    elseif gain2 < 0
        gain2 = -10 + abs(gain1) + abs(gain3) + abs(gain4) + abs(gain5);
        assignin('base','gain1',gain1);
        assignin('base','gain2',gain2);
        assignin('base','gain3',gain3);
        assignin('base','gain4',gain4);
        assignin('base','gain5',gain5);
        set(handles.text5, 'String',gain2);
        set(handles.slider2,'value',gain2);
        set(handles.text7, 'String',0);
        set_param('SimulinkForEQ','SimulationCommand','update');
    end
end


% --- Executes during object creation, after setting all properties.
function slider2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global totalgain
global gain1
global gain2
global gain3
global gain4
global gain5

gain1 = ceil(get(handles.slider1,'value') * 2)/2;
gain2 = ceil(get(handles.slider2,'value') * 2)/2;
gain3 = ceil(get(handles.slider3,'value') * 2)/2;
gain4 = ceil(get(handles.slider4,'value') * 2)/2;
gain5 = ceil(get(handles.slider5,'value') * 2)/2;

totalgain = 10 - abs(gain1) - abs(gain2) - abs(gain3) - abs(gain4) - abs(gain5);
assignin('base','gain1',gain1);
assignin('base','gain2',gain2);
assignin('base','gain3',gain3);
assignin('base','gain4',gain4);
assignin('base','gain5',gain5);
set(handles.text7, 'String',totalgain);
set(handles.text6, 'String',gain3);
assignin('base','gain3',gain3);
set_param('SimulinkForEQ','SimulationCommand','update');

if totalgain < 0
    if gain3 > 0
        gain3 = 10 - abs(gain1) - abs(gain2) - abs(gain4) - (gain5);
        assignin('base','gain1',gain1);
        assignin('base','gain2',gain2);
        assignin('base','gain3',gain3);
        assignin('base','gain4',gain4);
        assignin('base','gain5',gain5);
        set(handles.text6, 'String',gain3);
        set(handles.slider3,'value',gain3);
        set(handles.text7, 'String',0);
        set_param('SimulinkForEQ','SimulationCommand','update');
    elseif gain3 < 0
        gain3 = -10 + abs(gain1) + abs(gain2) + abs(gain4) + abs(gain5);
        assignin('base','gain1',gain1);
        assignin('base','gain2',gain2);
        assignin('base','gain3',gain3);
        assignin('base','gain4',gain4);
        assignin('base','gain5',gain5);
        set(handles.text6, 'String',gain3);
        set(handles.slider3,'value',gain3);
        set(handles.text7, 'String',0);
        set_param('SimulinkForEQ','SimulationCommand','update');
    end
end

% --- Executes during object creation, after setting all properties.
function slider3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global totalgain
global gain1
global gain2
global gain3
global gain4
global gain5

gain1 = ceil(get(handles.slider1,'value') * 2)/2;
gain2 = ceil(get(handles.slider2,'value') * 2)/2;
gain3 = ceil(get(handles.slider3,'value') * 2)/2;
gain4 = ceil(get(handles.slider4,'value') * 2)/2;
gain5 = ceil(get(handles.slider5,'value') * 2)/2;

totalgain = 10 - abs(gain1) - abs(gain2) - abs(gain3) - abs(gain4) - abs(gain5);
assignin('base','gain1',gain1);
assignin('base','gain2',gain2);
assignin('base','gain3',gain3);
assignin('base','gain4',gain4);
assignin('base','gain5',gain5);
set(handles.text7, 'String',totalgain);
set(handles.text45, 'String',gain4);
assignin('base','gain4',gain4);
set_param('SimulinkForEQ','SimulationCommand','update');

if totalgain < 0
    if gain4 > 0
        gain4 = 10 - abs(gain1) - abs(gain2) - abs(gain3) - (gain5);
        assignin('base','gain1',gain1);
        assignin('base','gain2',gain2);
        assignin('base','gain3',gain3);
        assignin('base','gain4',gain4);
        assignin('base','gain5',gain5);
        set(handles.text45, 'String',gain4);
        set(handles.slider4,'value',gain4);
        set(handles.text7, 'String',0);
        set_param('SimulinkForEQ','SimulationCommand','update');
    elseif gain4 < 0
        gain4 = -10 + abs(gain1) + abs(gain2) + abs(gain3) + abs(gain5);
        assignin('base','gain1',gain1);
        assignin('base','gain2',gain2);
        assignin('base','gain3',gain3);
        assignin('base','gain4',gain4);
        assignin('base','gain5',gain5);
        set(handles.text45, 'String',gain4);
        set(handles.slider4,'value',gain4);
        set(handles.text7, 'String',0);
        set_param('SimulinkForEQ','SimulationCommand','update');
    end
end

% --- Executes during object creation, after setting all properties.
function slider4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider5_Callback(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global totalgain
global gain1
global gain2
global gain3
global gain4
global gain5

gain1 = ceil(get(handles.slider1,'value') * 2)/2;
gain2 = ceil(get(handles.slider2,'value') * 2)/2;
gain3 = ceil(get(handles.slider3,'value') * 2)/2;
gain4 = ceil(get(handles.slider4,'value') * 2)/2;
gain5 = ceil(get(handles.slider5,'value') * 2)/2;

totalgain = 10 - abs(gain1) - abs(gain2) - abs(gain3) - abs(gain4) - abs(gain5);
assignin('base','gain1',gain1);
assignin('base','gain2',gain2);
assignin('base','gain3',gain3);
assignin('base','gain4',gain4);
assignin('base','gain5',gain5);
set(handles.text7, 'String',totalgain);
set(handles.text46, 'String',gain5);
assignin('base','gain5',gain5);
set_param('SimulinkForEQ','SimulationCommand','update');

if totalgain < 0
    if gain5 > 0
        gain5 = 10 - abs(gain1) - abs(gain2) - abs(gain3) - (gain4);
        assignin('base','gain1',gain1);
        assignin('base','gain2',gain2);
        assignin('base','gain3',gain3);
        assignin('base','gain4',gain4);
        assignin('base','gain5',gain5);
        set(handles.text46, 'String',gain5);
        set(handles.slider5,'value',gain5);
        set(handles.text7, 'String',0);
        set_param('SimulinkForEQ','SimulationCommand','update');
    elseif gain5 < 0
        gain5 = -10 + abs(gain1) + abs(gain2) + abs(gain3) + abs(gain5);
        assignin('base','gain1',gain1);
        assignin('base','gain2',gain2);
        assignin('base','gain3',gain3);
        assignin('base','gain4',gain4);
        assignin('base','gain5',gain5);
        set(handles.text46, 'String',gain5);
        set(handles.slider5,'value',gain5);
        set(handles.text7, 'String',0);
        set_param('SimulinkForEQ','SimulationCommand','update');
    end
end



% --- Executes during object creation, after setting all properties.
function slider5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in PauseButton.
function PauseButton_Callback(~, eventdata, handles)
% hObject    handle to PauseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in StopButton.
function StopButton_Callback(hObject, eventdata, handles)
% hObject    handle to StopButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set_param('SimulinkForEQ','SimulationCommand','stop');



% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over slider1.
function slider1_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function text8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in ResetButton.
function ResetButton_Callback(hObject, eventdata, handles)
% hObject    handle to ResetButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes on button press in SubmitButton.
function SubmitButton_Callback(hObject, eventdata, handles)
% hObject    handle to SubmitButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global freq1
global freq2
global freq3
global freq4
global freq5
set_param('SimulinkForEQ','SimulationCommand','stop');

gain1 = str2double(get(handles.text4,'string')); %gain is obtained as a whole value, thus getting hanldes from text field but not slider
gain2 = str2double(get(handles.text5,'string'));
gain3 = str2double(get(handles.text6,'string'));
gain4 = str2double(get(handles.text45,'string'));
gain5 = str2double(get(handles.text46,'string'));

T = ["Frequency 1" "Frequency 2" "Frequency 3" "Frequency 4" "Frequency 5" ; ...
    freq1 freq2 freq3 freq4 freq5 ; ...
    "Gain 1" "Gain 2" "Gain 3" "Gain 4" "Gain 5" ; ...
    gain1 gain2 gain3 gain4 gain5];

%initial delete and recycle of excel file in start button
filename = 'mydata.xlsx';
writematrix(T,filename,"WriteMode","append");


% --- Executes on button press in CloseButton.
function CloseButton_Callback(hObject, eventdata, handles)
% hObject    handle to CloseButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set_param('SimulinkForEQ','SimulationCommand','stop');
clc;
clear;
close;

% --- Executes during object deletion, before destroying properties.
function figure1_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
