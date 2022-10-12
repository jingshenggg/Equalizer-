function varargout = Equalizer(varargin)
% Equalizer MATLAB code for Equalizer.fig
%      Equalizer, by itself, creates a new Equalizer or raises the existing
%      singleton*.
%
%      H = Equalizer returns the handle to a new Equalizer or the handle to
%      the existing singleton*.
%
%      Equalizer('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in Equalizer.M with the given input arguments.
%
%      Equalizer('Property','Value',...) creates a new Equalizer or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Equalizer_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Equalizer_OpeningFcn via varargin. 
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
% Edit the above text to modify the response to help Equalizer

% Last Modified by GUIDE v2.5 13-Apr-2022 11:37:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Equalizer_OpeningFcn, ...
                   'gui_OutputFcn',  @Equalizer_OutputFcn, ...
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


% --- Executes just before Equalizer is made visible.
function Equalizer_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Equalizer (see VARARGIN)

% Choose default command line output for Equalizer
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Equalizer wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = Equalizer_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in Initialize.
function Initialize_Callback(~, ~, handles)
set(handles.PlayButton,'Enable','on');
set(handles.Initialize,'Enable','off');
clc;
% hObject    handle to initialize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global i songs totaltrack rounds songFolder
rounds = 1;
assignin('base','rounds',rounds);
totaltrack = 2;
songFolder = [pwd '\SongFolder\'];
songList = dir([songFolder '*.wav']);
f = fieldnames(songList);
ii = 1;
songListFilter = struct(f{:});
for j = 1:1:length(songList)
    if ~strcmp(songList(j).name, 'whitenoise.wav')
        songListFilter(ii).name = songList(j).name;
        songListFilter(ii).date = songList(j).date;
        songListFilter(ii).isdir = songList(j).isdir;
        ii = ii + 1;
    end
end
songListFilter = songListFilter(randperm(length(songListFilter)))'; %randomise
%while length(songListFilter) < totaltrack
%    songListFilter = [songListFilter; songListFilter];
%end
songs = {};
songs{1} = [songFolder 'whitenoise.wav'];
for j = 1:1:totaltrack
    songs{j+1} = [songFolder songListFilter(j).name]; 
end
songs{j+2} = [songFolder 'whitenoise.wav'];
i = 1;
set_param('fifteenbands/From Multimedia File','Filename',songs{i});
set(handles.instruction,'String','System has been initialized, click ''Play'' to start.');



% --- Executes on button press in PlayButton.
function PlayButton_Callback(~, ~, handles)
% hObject    handle to PlayButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global gainleft gainlimit rounds i
global gain1 gain2 gain3 gain4 gain5 gain6 gain7 gain8 gain9 gain10 gain11 gain12
global freq1 freq2 freq3 freq4
set(handles.StopButton,'BackgroundColor',[0.94 0.94 0.94]);
set(handles.PlayButton,'Enable','off');
set(handles.StopButton,'Enable','on');
set(handles.ResetGainButton,'Enable','on');

if rounds == 1
    freq1 = 125;
    freq2 = 250;
    freq3 = 500;
    freq4 = 1000;
    gainlimit = 15;
    set(handles.roundnumber,'String',rounds);
    set(handles.songnumber,'String',i);
    set(handles.slider1,'Enable','on');
    set(handles.slider2,'Enable','on');
    set(handles.slider3,'Enable','on');
    set(handles.slider4,'Enable','on');
    set(handles.slider5,'Enable','off');
    set(handles.slider6,'Enable','off');
    set(handles.slider7,'Enable','off');
    set(handles.slider8,'Enable','off');
    set(handles.slider9,'Enable','off');
    set(handles.slider10,'Enable','off');
    set(handles.slider11,'Enable','off');
    set(handles.slider12,'Enable','off');

    assignin('base','freq1',freq1);
    assignin('base','freq2',freq2);
    assignin('base','freq3',freq3);
    assignin('base','freq4',freq4);

    set(handles.text110,'String','125Hz');
    set(handles.text111,'String','250Hz');
    set(handles.text112,'String','500Hz');
    set(handles.text113,'String','1000Hz');
    set(handles.text114,'String','');
    set(handles.text115,'String','');
    set(handles.text116,'String','');
    set(handles.text117,'String','');
    set(handles.text118,'String','');
    set(handles.text119,'String','');
    set(handles.text120,'String','');
    set(handles.text121,'String','');

    assignin('base','bw1',100);
    assignin('base','bw2',210);
    assignin('base','bw3',400);
    assignin('base','bw4',700);

    set(handles.slider1,'value',0);
    set(handles.slider2,'value',0);
    set(handles.slider3,'value',0);
    set(handles.slider4,'value',0);

    gain1 = get(handles.slider1,'value');
    gain2 = get(handles.slider2,'value');
    gain3 = get(handles.slider3,'value');
    gain4 = get(handles.slider4,'value');

    assignin('base','gain1',gain1);
    assignin('base','gain2',gain2);
    assignin('base','gain3',gain3);
    assignin('base','gain4',gain4);

    gainleft = gainlimit + gain1 + gain2 + gain3 + gain4;
    set(handles.text4,'String',gain1);
    set(handles.text5,'String',gain2);
    set(handles.text6,'String',gain3);
    set(handles.text45,'String',gain4);
    set(handles.gainleft,'String',gainleft);
    set(handles.instruction,'String','Song has started. Please only use the first 4 sliders from the left. Click ''Stop'' when finish adjusting.');
    set(handles.text46,'String','');
    set(handles.text59,'String','');
    set(handles.text60,'String','');
    set(handles.text61,'String','');
    set(handles.text62,'String','');
    set(handles.text63,'String','');
    set(handles.text64,'String','');
    set(handles.text65,'String','');

    set_param('fifteenbands/Variable Bandwidth IIR Filter5','Commented','on');
    set_param('fifteenbands/Variable Bandwidth IIR Filter6','Commented','on');
    set_param('fifteenbands/Variable Bandwidth IIR Filter7','Commented','on');
    set_param('fifteenbands/Variable Bandwidth IIR Filter8','Commented','on');
    set_param('fifteenbands/Variable Bandwidth IIR Filter9','Commented','on');
    set_param('fifteenbands/Variable Bandwidth IIR Filter10','Commented','on');
    set_param('fifteenbands/Variable Bandwidth IIR Filter11','Commented','on');
    set_param('fifteenbands/Variable Bandwidth IIR Filter12','Commented','on');
    set_param('fifteenbands/dB Gain5','Commented','on');
    set_param('fifteenbands/dB Gain6','Commented','on');
    set_param('fifteenbands/dB Gain7','Commented','on');
    set_param('fifteenbands/dB Gain8','Commented','on');
    set_param('fifteenbands/dB Gain9','Commented','on');
    set_param('fifteenbands/dB Gain10','Commented','on');
    set_param('fifteenbands/dB Gain11','Commented','on');
    set_param('fifteenbands/dB Gain12','Commented','on');
    set_param('fifteenbands/Subtract5','Commented','on');
    set_param('fifteenbands/Subtract6','Commented','on');
    set_param('fifteenbands/Subtract7','Commented','on');
    set_param('fifteenbands/Subtract8','Commented','on');
    set_param('fifteenbands/Subtract9','Commented','on');
    set_param('fifteenbands/Subtract10','Commented','on');
    set_param('fifteenbands/Subtract11','Commented','on');
    set_param('fifteenbands/Subtract12','Commented','on');
    sim('fifteenbands');
elseif rounds == 2
    set(handles.instruction,'String','Song is repeated. Click ''Stop'' when finish adjusting.');

    set(handles.slider1,'value',0);
    set(handles.slider2,'value',0);
    set(handles.slider3,'value',0);
    set(handles.slider4,'value',0);
    set(handles.slider5,'value',0);
    set(handles.slider6,'value',0);
    set(handles.slider7,'value',0);
    set(handles.slider8,'value',0);
    set(handles.slider9,'value',0);
    set(handles.slider10,'value',0);
    set(handles.slider11,'value',0);
    set(handles.slider12,'value',0);

    gain1 = get(handles.slider1,'value');
    gain2 = get(handles.slider2,'value');
    gain3 = get(handles.slider3,'value');
    gain4 = get(handles.slider4,'value');
    gain5 = get(handles.slider5,'value');
    gain6 = get(handles.slider6,'value');
    gain7 = get(handles.slider7,'value');
    gain8 = get(handles.slider8,'value');
    gain9 = get(handles.slider9,'value');
    gain10 = get(handles.slider10,'value');
    gain11 = get(handles.slider11,'value');
    gain12 = get(handles.slider12,'value');

    gainleft = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
    set(handles.gainleft, 'String',gainleft);
    set(handles.text4, 'String',gain1);
    set(handles.text5, 'String',gain2);
    set(handles.text6, 'String',gain3);
    set(handles.text45,'String',gain4);
    set(handles.text46,'String',gain5);
    set(handles.text59,'String',gain6);
    set(handles.text60,'String',gain7);
    set(handles.text61,'String',gain8);
    set(handles.text62,'String',gain9);
    set(handles.text63,'String',gain10);
    set(handles.text64,'String',gain11);
    set(handles.text65,'String',gain12);

    assignin('base','gain1',gain1);
    assignin('base','gain2',gain2);
    assignin('base','gain3',gain3);
    assignin('base','gain4',gain4);
    assignin('base','gain5',gain5);
    assignin('base','gain6',gain6);
    assignin('base','gain7',gain7);
    assignin('base','gain8',gain8);
    assignin('base','gain9',gain9);
    assignin('base','gain10',gain10);
    assignin('base','gain11',gain11);
    assignin('base','gain12',gain12);
    sim('fifteenbands');
end

% --- Executes on button press in ResetGainButton.
function ResetGainButton_Callback(hObject, eventdata, handles)
% hObject    handle to ResetGainButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global gainleft
global rounds
global gainlimit
global gain1 gain2 gain3 gain4 gain5 gain6 gain7 gain8 gain9 gain10 gain11 gain12 

set(handles.slider1,'value',0);
set(handles.slider2,'value',0);
set(handles.slider3,'value',0);
set(handles.slider4,'value',0);
gain1 = get(handles.slider1,'value');
gain2 = get(handles.slider2,'value');
gain3 = get(handles.slider3,'value');
gain4 = get(handles.slider4,'value');
gainleft = gainlimit + gain1 + gain2 + gain3 + gain4;
set(handles.gainleft, 'String',gainleft);
set(handles.text4, 'String',gain1);
set(handles.text5, 'String',gain2);
set(handles.text6, 'String',gain3);
set(handles.text45,'String',gain4);
assignin('base','gain1',gain1);
assignin('base','gain2',gain2);
assignin('base','gain3',gain3);
assignin('base','gain4',gain4);
set_param('fifteenbands','SimulationCommand','update');

if rounds == 2
    set(handles.slider1,'value',0);
    set(handles.slider2,'value',0);
    set(handles.slider3,'value',0);
    set(handles.slider4,'value',0);
    set(handles.slider5,'value',0);
    set(handles.slider6,'value',0);
    set(handles.slider7,'value',0);
    set(handles.slider8,'value',0);
    set(handles.slider9,'value',0);
    set(handles.slider10,'value',0);
    set(handles.slider11,'value',0);
    set(handles.slider12,'value',0);

    gain1 = get(handles.slider1,'value');
    gain2 = get(handles.slider2,'value');
    gain3 = get(handles.slider3,'value');
    gain4 = get(handles.slider4,'value');
    gain5 = get(handles.slider5,'value');
    gain6 = get(handles.slider6,'value');
    gain7 = get(handles.slider7,'value');
    gain8 = get(handles.slider8,'value');
    gain9 = get(handles.slider9,'value');
    gain10 = get(handles.slider10,'value');
    gain11 = get(handles.slider11,'value');
    gain12 = get(handles.slider12,'value');

    gainleft = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
    set(handles.gainleft, 'String',gainleft);
    set(handles.text4, 'String',gain1);
    set(handles.text5, 'String',gain2);
    set(handles.text6, 'String',gain3);
    set(handles.text45,'String',gain4);
    set(handles.text46,'String',gain5);
    set(handles.text59,'String',gain6);
    set(handles.text60,'String',gain7);
    set(handles.text61,'String',gain8);
    set(handles.text62,'String',gain9);
    set(handles.text63,'String',gain10);
    set(handles.text64,'String',gain11);
    set(handles.text65,'String',gain12);

    assignin('base','gain1',gain1);
    assignin('base','gain2',gain2);
    assignin('base','gain3',gain3);
    assignin('base','gain4',gain4);
    assignin('base','gain5',gain5);
    assignin('base','gain6',gain6);
    assignin('base','gain7',gain7);
    assignin('base','gain8',gain8);
    assignin('base','gain9',gain9);
    assignin('base','gain10',gain10);
    assignin('base','gain11',gain11);
    assignin('base','gain12',gain12);
    set_param('fifteenbands','SimulationCommand','update');
end


function edit1_Callback(~, ~, ~)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function edit2_Callback(~, ~, ~)

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function edit3_Callback(~, ~, ~)

% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider1_Callback(~, ~, handles)
% hObject    handle to slider1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global gainleft
global gain1 gain2 gain3 gain4 gain5 gain6 gain7 gain8 gain9 gain10 gain11 gain12
global rounds
global gainlimit
gain1 = round(get(handles.slider1,'value'));

if rounds == 1
    gainleft = gainlimit + gain1 + gain2 + gain3 + gain4;
    assignin('base','gainleft',gainleft);
    if gainleft > gainlimit
        assignin('base','gain1',gain1);
        set(handles.gainleft, 'String',gainlimit);
        set(handles.text4, 'String',gain1);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gainleft <= gainlimit && gainleft >= 0
        assignin('base','gain1',gain1);
        set(handles.gainleft, 'String',gainleft);
        set(handles.text4, 'String',gain1);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gainleft < 0
        if gain1 >= 0
            gain1 = gainlimit + gain2 + gain3 + gain4;
            gain1 = -gain1;
            assignin('base','gain1',gain1);
            set(handles.text4, 'String',gain1);
            set(handles.slider1,'value',gain1);
            set(handles.gainleft, 'String',0);
            set_param('fifteenbands','SimulationCommand','update');
        elseif gain1 < 0
            gain1 = gainlimit + gain2 + gain3 + gain4;
            gain1 = -gain1;
            assignin('base','gain1',gain1);
            set(handles.text4, 'String',gain1);
            set(handles.slider1,'value',gain1);
            set(handles.gainleft, 'String',0);
            set_param('fifteenbands','SimulationCommand','update');
        end
    end
elseif rounds > 1
    gainleft = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
    if gainleft > gainlimit
        assignin('base','gain1',gain1);
        set(handles.gainleft, 'String',gainlimit);
        set(handles.text4, 'String',gain1);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gainleft <= gainlimit && gainleft >= 0
        assignin('base','gain1',gain1);
        set(handles.gainleft, 'String',gainleft);
        set(handles.text4, 'String',gain1);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gainleft < 0
        if gain1 >= 0
            gain1 = gainlimit + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
            gain1 = -gain1;
            assignin('base','gain1',gain1);
            set(handles.text4, 'String',gain1);
            set(handles.slider1,'value',gain1);
            set(handles.gainleft, 'String',0);
            set_param('fifteenbands','SimulationCommand','update');
        elseif gain1 < 0
            gain1 = gainlimit + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
            gain1 = -gain1;
            assignin('base','gain1',gain1);
            set(handles.text4, 'String',gain1);
            set(handles.slider1,'value',gain1);
            set(handles.gainleft, 'String',0);
            set_param('fifteenbands','SimulationCommand','update');
        end
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

global gainleft
global rounds
global gainlimit
global gain1 gain2 gain3 gain4 gain5 gain6 gain7 gain8 gain9 gain10 gain11 gain12
gain2 = round(get(handles.slider2,'value'));

if rounds == 1
    gainleft = gainlimit + gain1 + gain2 + gain3 + gain4;
    if gainleft > gainlimit
        assignin('base','gain2',gain2);
        set(handles.text5, 'String',gain2);
        set(handles.gainleft, 'String',gainlimit);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gainleft <= gainlimit && gainleft >= 0
        assignin('base','gain2',gain2);
        set(handles.gainleft,'String',gainleft);
        set(handles.text5,'String',gain2);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gainleft < 0
        if gain2 >= 0
            gain2 = gainlimit + gain1 + gain3 + gain4;
            gain2 = -gain2;
            assignin('base','gain2',gain2);
            set(handles.text5, 'String',gain2);
            set(handles.slider2,'value',gain2);
            set(handles.gainleft,'String',0);
            set_param('fifteenbands','SimulationCommand','update');
        elseif gain2 < 0
            gain2 = gainlimit + gain1 + gain3 + gain4;
            gain2 = -gain2;
            assignin('base','gain2',gain2);
            set(handles.text5,'String',gain2);
            set(handles.slider2,'value',gain2);
            set(handles.gainleft,'String',0);
            set_param('fifteenbands','SimulationCommand','update');
        end
    end
elseif rounds > 1

    gainleft = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
    if gainleft > gainlimit
        assignin('base','gain2',gain2);
        set(handles.gainleft,'String',gainlimit);
        set(handles.text5,'String',gain2);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gainleft <= gainlimit && gainleft >= 0
        assignin('base','gain2',gain2);
        set(handles.gainleft,'String',gainleft);
        set(handles.text5,'String',gain2);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gainleft < 0
        if gain2 >= 0
            gain2 = gainlimit + gain1 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
            gain2 = -gain2;
            assignin('base','gain2',gain2);
            set(handles.text5,'String',gain2);
            set(handles.slider2,'value',gain2);
            set(handles.gainleft, 'String',0);
            set_param('fifteenbands','SimulationCommand','update');
        elseif gain2 < 0
            gain2 = gainlimit + gain1 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
            gain2 = -gain2;
            assignin('base','gain2',gain2);
            set(handles.text5,'String',gain2);
            set(handles.slider2,'value',gain2);
            set(handles.gainleft,'String',0);
            set_param('fifteenbands','SimulationCommand','update');
        end
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

global gainleft
global rounds
global gainlimit
global gain1 gain2 gain3 gain4 gain5 gain6 gain7 gain8 gain9 gain10 gain11 gain12
gain3 = round(get(handles.slider3,'value'));

if rounds == 1
    gainleft = gainlimit + gain1 + gain2 + gain3 + gain4;
    if gainleft > gainlimit
        assignin('base','gain3',gain3);
        set(handles.text6,'String',gain3);
        set(handles.gainleft,'String',gainlimit);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gainleft <= gainlimit && gainleft >= 0
        assignin('base','gain3',gain3);
        set(handles.gainleft,'String',gainleft);
        set(handles.text6,'String',gain3);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gainleft < 0
        if gain3 >= 0
            gain3 = gainlimit + gain1 + gain2 + gain4;
            gain3 = -gain3;
            assignin('base','gain3',gain3);
            set(handles.text6,'String',gain3);
            set(handles.slider3,'value',gain3);
            set(handles.gainleft,'String',0);
            set_param('fifteenbands','SimulationCommand','update');
        elseif gain3 < 0
            gain3 = gainlimit + gain1 + gain2 + gain4;
            gain3 = -gain3;
            assignin('base','gain3',gain3);
            set(handles.text6,'String',gain3);
            set(handles.slider3,'value',gain3);
            set(handles.gainleft,'String',0);
            set_param('fifteenbands','SimulationCommand','update');
        end
    end
elseif rounds > 1
    gainleft = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
    if gainleft > gainlimit
        assignin('base','gain3',gain3);
        set(handles.gainleft,'String',gainlimit);
        set(handles.text6,'String',gain3);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gainleft <= gainlimit && gainleft >= 0
        assignin('base','gain3',gain3);
        set(handles.gainleft,'String',gainleft);
        set(handles.text6,'String',gain3);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gainleft < 0
        if gain3 >= 0
            gain3 = gainlimit + gain1 + gain2 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
            gain3 = -gain3;
            assignin('base','gain3',gain3);
            set(handles.text6,'String',gain3);
            set(handles.slider3,'value',gain2);
            set(handles.gainleft,'String',0);
            set_param('fifteenbands','SimulationCommand','update');
        elseif gain3 < 0
            gain3 = gainlimit + gain1 + gain2 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
            gain3 = -gain3;
            assignin('base','gain3',gain3);
            set(handles.text6,'String',gain3);
            set(handles.slider3,'value',gain3);
            set(handles.gainleft,'String',0);
            set_param('fifteenbands','SimulationCommand','update');
        end
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

global gainleft
global rounds
global gainlimit
global gain1 gain2 gain3 gain4 gain5 gain6 gain7 gain8 gain9 gain10 gain11 gain12
gain4 = round(get(handles.slider4,'value'));

if rounds == 1
    gainleft = gainlimit + gain1 + gain2 + gain3 + gain4;
    if gainleft > gainlimit
        assignin('base','gain4',gain4);
        set(handles.text45,'String',gain4);
        set(handles.gainleft,'String',gainlimit);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gainleft <= gainlimit && gainleft >= 0
        assignin('base','gain4',gain4);
        set(handles.gainleft,'String',gainleft);
        set(handles.text45,'String',gain4);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gainleft < 0
        if gain4 >= 0
            gain4 = gainlimit + gain1 + gain2 + gain3;
            gain4 = -gain4;
            assignin('base','gain4',gain4);
            set(handles.text45,'String',gain4);
            set(handles.slider4,'value',gain4);
            set(handles.gainleft,'String',0);
            set_param('fifteenbands','SimulationCommand','update');
        elseif gain4 < 0
            gain4 = gainlimit + gain1 + gain2 + gain3;
            gain4 = -gain4;
            assignin('base','gain4',gain4);
            set(handles.text45,'String',gain4);
            set(handles.slider4,'value',gain4);
            set(handles.gainleft,'String',0);
            set_param('fifteenbands','SimulationCommand','update');
        end
    end
elseif rounds > 1

    gainleft = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
    if gainleft > 15
        assignin('base','gain4',gain4);
        set(handles.gainleft,'String',gainlimit);
        set(handles.text45,'String',gain4);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gainleft <= gainlimit && gainleft >= 0
        assignin('base','gain4',gain4);
        set(handles.gainleft,'String',gainleft);
        set(handles.text45,'String',gain4);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gainleft < 0
        if gain4 >= 0
            gain4 = gainlimit + gain1 + gain2 + gain3 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
            gain4 = -gain4;
            assignin('base','gain4',gain34);
            set(handles.text45,'String',gain4);
            set(handles.slider4,'value',gain4);
            set(handles.gainleft,'String',0);
            set_param('fifteenbands','SimulationCommand','update');
        elseif gain4 < 0
            gain4 = gainlimit + gain1 + gain2 + gain3 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
            gain4 = -gain4;
            assignin('base','gain4',gain4);
            set(handles.text45,'String',gain4);
            set(handles.slider4,'value',gain4);
            set(handles.gainleft,'String',0);
            set_param('fifteenbands','SimulationCommand','update');
        end
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

global gainleft
global gainlimit
global gain1 gain2 gain3 gain4 gain5 gain6 gain7 gain8 gain9 gain10 gain11 gain12
gain5 = round(get(handles.slider5,'value'));

gainleft = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
if gainleft > gainlimit
    assignin('base','gain5',gain5);
    set(handles.gainleft,'String',gainlimit);
    set(handles.text46,'String',gain5);
    set_param('fifteenbands','SimulationCommand','update');
elseif gainleft <= gainlimit && gainleft >= 0
    assignin('base','gain5',gain5);
    set(handles.gainleft,'String',gainleft);
    set(handles.text46,'String',gain5);
    set_param('fifteenbands','SimulationCommand','update');
elseif gainleft < 0
    if gain5 >= 0
        gain5 = gainlimit + gain1 + gain2 + gain3 + gain4 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
        gain5 = -gain5;
        assignin('base','gain5',gain5);
        set(handles.text46,'String',gain5);
        set(handles.slider5,'value',gain5);
        set(handles.gainleft,'String',0);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gain5 < 0
        gain5 = gainlimit + gain1 + gain2 + gain3 + gain4 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
        gain5 = -gain5;
        assignin('base','gain5',gain5);
        set(handles.text46,'String',gain5);
        set(handles.slider5,'value',gain5);
        set(handles.gainleft,'String',0);
        set_param('fifteenbands','SimulationCommand','update');
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


% --- Executes on slider movement.
function slider6_Callback(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global gainleft
global gainlimit
global gain1 gain2 gain3 gain4 gain5 gain6 gain7 gain8 gain9 gain10 gain11 gain12
gain6 = round(get(handles.slider6,'value'));

gainleft = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
if gainleft > gainlimit
    assignin('base','gain6',gain6);
    set(handles.gainleft,'String',gainlimit);
    set(handles.text59,'String',gain6);
    set_param('fifteenbands','SimulationCommand','update');
elseif gainleft <= gainlimit && gainleft >= 0
    assignin('base','gain6',gain6);
    set(handles.gainleft,'String',gainleft);
    set(handles.text59,'String',gain6); 
    set_param('fifteenbands','SimulationCommand','update');
elseif gainleft < 0
    if gain6 >= 0
        gain6 = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
        gain6 = -gain6;
        assignin('base','gain6',gain6);
        set(handles.text59,'String',gain6);
        set(handles.slider6,'value',gain6);
        set(handles.gainleft,'String',0);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gain6 < 0
        gain6 = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
        gain6 = -gain6;
        assignin('base','gain6',gain6);
        set(handles.text59,'String',gain6);
        set(handles.slider6,'value',gain6);
        set(handles.gainleft,'String',0);
        set_param('fifteenbands','SimulationCommand','update');
    end
end


% --- Executes during object creation, after setting all properties.
function slider6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider7_Callback(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global gainleft
global gainlimit
global gain1 gain2 gain3 gain4 gain5 gain6 gain7 gain8 gain9 gain10 gain11 gain12
gain7 = round(get(handles.slider7,'value'));

gainleft = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
if gainleft > gainlimit
    assignin('base','gain7',gain7);
    set(handles.gainleft,'String',gainlimit);
    set(handles.text60,'String',gain7);
    set_param('fifteenbands','SimulationCommand','update');
elseif gainleft <= gainlimit && gainleft >= 0
    assignin('base','gain7',gain7);
    set(handles.gainleft,'String',gainleft);
    set(handles.text60,'String',gain7);
    set_param('fifteenbands','SimulationCommand','update');
elseif gainleft < 0
    if gain7 >= 0
        gain7 = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain8 + gain9 + gain10 + gain11 + gain12;
        gain7 = -gain7;
        assignin('base','gain7',gain7);
        set(handles.text60,'String',gain7);
        set(handles.slider7,'value',gain7);
        set(handles.gainleft,'String',0);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gain7 < 0
        gain7 = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain8 + gain9 + gain10 + gain11 + gain12;
        gain7 = -gain7;
        assignin('base','gain7',gain7);
        set(handles.text60,'String',gain7);
        set(handles.slider7,'value',gain7);
        set(handles.gainleft,'String',0);
        set_param('fifteenbands','SimulationCommand','update');
    end
end


% --- Executes during object creation, after setting all properties.
function slider7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider8_Callback(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global gainleft
global gainlimit
global gain1 gain2 gain3 gain4 gain5 gain6 gain7 gain8 gain9 gain10 gain11 gain12
gain8 = round(get(handles.slider8,'value'));

gainleft = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
if gainleft > gainlimit
    assignin('base','gain8',gain8);
    set(handles.gainleft,'String',gainlimit);
    set(handles.text61,'String',gain8);
    set_param('fifteenbands','SimulationCommand','update');
elseif gainleft <= gainlimit && gainleft >= 0
    assignin('base','gain8',gain8);
    set(handles.gainleft,'String',gainleft);
    set(handles.text61,'String',gain8);
    set_param('fifteenbands','SimulationCommand','update');
elseif gainleft < 0
    if gain8 >= 0
        gain8 = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain9 + gain10 + gain11 + gain12;
        gain8 = -gain8;
        assignin('base','gain8',gain8);
        set(handles.text61,'String',gain8);
        set(handles.slider8,'value',gain8);
        set(handles.gainleft,'String',0);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gain8 < 0
        gain8 = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain9 + gain10 + gain11 + gain12;
        gain8 = -gain8;
        assignin('base','gain8',gain8);
        set(handles.text61,'String',gain8);
        set(handles.slider8,'value',gain8);
        set(handles.gainleft,'String',0);
        set_param('fifteenbands','SimulationCommand','update');
    end
end


% --- Executes during object creation, after setting all properties.
function slider8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider9_Callback(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global gainleft
global gainlimit
global gain1 gain2 gain3 gain4 gain5 gain6 gain7 gain8 gain9 gain10 gain11 gain12
gain9 = round(get(handles.slider9,'value'));

gainleft = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
if gainleft > gainlimit
    assignin('base','gain9',gain9);
    set(handles.gainleft,'String',gainlimit);
    set(handles.text62,'String',gain9);
    set_param('fifteenbands','SimulationCommand','update');
elseif gainleft <= gainlimit && gainleft >= 0
    assignin('base','gain9',gain9);
    set(handles.gainleft,'String',gainleft);
    set(handles.text62,'String',gain9);
    set_param('fifteenbands','SimulationCommand','update');
elseif gainleft < 0
    if gain9 >= 0
        gain9 = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain10 + gain11 + gain12;
        gain9 = -gain9;
        assignin('base','gain9',gain9);
        set(handles.text62,'String',gain9);
        set(handles.slider9,'value',gain9);
        set(handles.gainleft,'String',0);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gain9 < 0
        gain9 = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain10 + gain11 + gain12;
        gain9 = -gain9;
        assignin('base','gain9',gain9);
        set(handles.text62,'String',gain9);
        set(handles.slider9,'value',gain9);
        set(handles.gainleft,'String',0);
        set_param('fifteenbands','SimulationCommand','update');
    end
end


% --- Executes during object creation, after setting all properties.
function slider9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider10_Callback(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global gainleft
global gainlimit
global gain1 gain2 gain3 gain4 gain5 gain6 gain7 gain8 gain9 gain10 gain11 gain12
gain10 = round(get(handles.slider10,'value'));

gainleft = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
if gainleft > gainlimit
    assignin('base','gain10',gain10);
    set(handles.gainleft,'String',gainlimit);
    set(handles.text63,'String',gain10);
    set_param('fifteenbands','SimulationCommand','update');
elseif gainleft <= gainlimit && gainleft >= 0
    assignin('base','gain10',gain10);
    set(handles.gainleft,'String',gainleft);
    set(handles.text63,'String',gain10);
    set_param('fifteenbands','SimulationCommand','update');
elseif gainleft < 0
    if gain10 >= 0
        gain10 = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain11 + gain12;
        gain10 = -gain10;
        assignin('base','gain10',gain10);
        set(handles.text63,'String',gain10);
        set(handles.slider10,'value',gain10);
        set(handles.gainleft,'String',0);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gain10 < 0
        gain10 = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain11 + gain12;
        gain10 = -gain10;
        assignin('base','gain10',gain10);
        set(handles.text63,'String',gain10);
        set(handles.slider10,'value',gain10);
        set(handles.gainleft,'String',0);
        set_param('fifteenbands','SimulationCommand','update');
    end
end


% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider11_Callback(hObject, eventdata, handles)
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global gainleft
global gainlimit
global gain1 gain2 gain3 gain4 gain5 gain6 gain7 gain8 gain9 gain10 gain11 gain12
gain11 = round(get(handles.slider11,'value'));

gainleft = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
if gainleft > 15
    assignin('base','gain11',gain11);
    set(handles.gainleft,'String',gainlimit);
    set(handles.text64,'String',gain11);
    set_param('fifteenbands','SimulationCommand','update');
elseif gainleft <= gainlimit && gainleft >= 0
    assignin('base','gain11',gain11);
    set(handles.gainleft,'String',gainleft);
    set(handles.text64,'String',gain11);
    set_param('fifteenbands','SimulationCommand','update');
elseif gainleft < 0
    if gain11 >= 0
        gain11 = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain12;
        gain11 = -gain11;
        assignin('base','gain11',gain11);
        set(handles.text64,'String',gain11);
        set(handles.slider11,'value',gain11);
        set(handles.gainleft,'String',0);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gain11 < 0
        gain11 = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain12;
        gain11 = -gain11;
        assignin('base','gain11',gain11);
        set(handles.text64,'String',gain11);
        set(handles.slider11,'value',gain11);
        set(handles.gainleft,'String',0);
        set_param('fifteenbands','SimulationCommand','update');
    end
end


% --- Executes during object creation, after setting all properties.
function slider11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function slider12_Callback(hObject, eventdata, handles)
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider

global gainleft
global gainlimit
global gain1 gain2 gain3 gain4 gain5 gain6 gain7 gain8 gain9 gain10 gain11 gain12
gain12 = round(get(handles.slider12,'value'));

gainleft = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11 + gain12;
if gainleft > gainlimit
    assignin('base','gain12',gain12);
    set(handles.gainleft,'String',gainlimit);
    set(handles.text65,'String',gain12);
    set_param('fifteenbands','SimulationCommand','update');
elseif gainleft <= gainlimit && gainleft >= 0
    assignin('base','gain12',gain12);
    set(handles.gainleft,'String',gainleft);
    set(handles.text65,'String',gain12);
    set_param('fifteenbands','SimulationCommand','update');
elseif gainleft < 0
    if gain12 >= 0
        gain12 = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11;
        gain12 = -gain12;
        assignin('base','gain12',gain12);
        set(handles.text65,'String',gain12);
        set(handles.slider12,'value',gain12);
        set(handles.gainleft,'String',0);
        set_param('fifteenbands','SimulationCommand','update');
    elseif gain12 < 0
        gain12 = gainlimit + gain1 + gain2 + gain3 + gain4 + gain5 + gain6 + gain7 + gain8 + gain9 + gain10 + gain11;
        gain12 = -gain12;
        assignin('base','gain12',gain12);
        set(handles.text65,'String',gain12);
        set(handles.slider12,'value',gain12);
        set(handles.gainleft,'String',0);
        set_param('fifteenbands','SimulationCommand','update');
    end
end


% --- Executes during object creation, after setting all properties.
function slider12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function slider13_Callback(~, ~, ~)
function slider13_CreateFcn(hObject, ~, ~)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider14_Callback(~, ~, ~)
function slider14_CreateFcn(hObject, ~, ~)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

function slider15_Callback(~, ~, ~)
function slider15_CreateFcn(hObject, ~, ~)
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end

% --- Executes on button press in PauseButton.
function PauseButton_Callback(~, ~, ~)

% --- Executes on button press in StopButton.
function StopButton_Callback(hObject, eventdata, handles)
% hObject    handle to StopButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.StopButton,'BackgroundColor','yellow');
set(handles.PlayButton,'Enable','on');
set(handles.SubmitButton,'Enable','on');
set(handles.ResetGainButton,'Enable','off');
set(handles.instruction,'String','Song is stopped, click ''Submit'' to submit the result or ''Play to repeat the song''.');
set_param('fifteenbands','SimulationCommand','stop');

% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over slider1.
function slider1_ButtonDownFcn(~, ~, ~)

% --- Executes during object creation, after setting all properties.
function text8_CreateFcn(~, ~, ~)

% --- Executes on button press in ResetButton.
function ResetButton_Callback(~, ~, ~)

% --- Executes on button press in SubmitButton.
function SubmitButton_Callback(~, ~, handles)

set(handles.StopButton,'BackgroundColor',[0.94 0.94 0.94]);
set(handles.PlayButton,'Enable','off');
set(handles.ResetGainButton,'Enable','on');
set(handles.SubmitButton,'Enable','off');

global rounds i songs gainleft gainlimit totalsongs songFolder
global gain1 gain2 gain3 gain4 gain5 gain6 gain7 gain8 gain9 gain10 gain11 gain12 
global freq1 freq2 freq3 freq4 freq5 freq6 freq7 freq8 freq9 freq10 freq11 freq12 

totalsongs = 4; %total number of songs include 1st whitenoise and last whitenoise.
name = get(handles.name,'string');

if rounds == 1
    rounds = rounds + 1;
    assignin('base','rounds',rounds);
    set(handles.roundnumber,'String',rounds);
    [~,B,b] = fileparts(songs{i});
    B = [B b];
    C = {name gain1 gain2 gain3 gain4};
    D = cat(2,{datetime},B,C);
    filename = 'mydata.xlsx';
    writecell(D,filename,'Sheet',1,"WriteMode","append");
    set_param('fifteenbands','SimulationCommand','stop');

    set(handles.slider1,'Enable','off');
    set(handles.slider2,'Enable','off');
    set(handles.slider3,'Enable','off');
    set(handles.slider4,'Enable','off');
    set(handles.slider5,'Enable','off');
    set(handles.slider6,'Enable','off');
    set(handles.slider7,'Enable','off');
    set(handles.slider8,'Enable','off');
    set(handles.slider9,'Enable','off');
    set(handles.slider10,'Enable','off');
    set(handles.slider11,'Enable','off');
    set(handles.slider12,'Enable','off');
    set_param('fifteenbands/Variable Bandwidth IIR Filter5','Commented','off');
    set_param('fifteenbands/Variable Bandwidth IIR Filter6','Commented','off');
    set_param('fifteenbands/Variable Bandwidth IIR Filter7','Commented','off');
    set_param('fifteenbands/Variable Bandwidth IIR Filter8','Commented','off');
    set_param('fifteenbands/Variable Bandwidth IIR Filter9','Commented','off');
    set_param('fifteenbands/Variable Bandwidth IIR Filter10','Commented','off');
    set_param('fifteenbands/Variable Bandwidth IIR Filter11','Commented','off');
    set_param('fifteenbands/Variable Bandwidth IIR Filter12','Commented','off');
    set_param('fifteenbands/dB Gain5','Commented','off');
    set_param('fifteenbands/dB Gain6','Commented','off');
    set_param('fifteenbands/dB Gain7','Commented','off');
    set_param('fifteenbands/dB Gain8','Commented','off');
    set_param('fifteenbands/dB Gain9','Commented','off');
    set_param('fifteenbands/dB Gain10','Commented','off');
    set_param('fifteenbands/dB Gain11','Commented','off');
    set_param('fifteenbands/dB Gain12','Commented','off');
    set_param('fifteenbands/Subtract5','Commented','off');
    set_param('fifteenbands/Subtract6','Commented','off');
    set_param('fifteenbands/Subtract7','Commented','off');
    set_param('fifteenbands/Subtract8','Commented','off');
    set_param('fifteenbands/Subtract9','Commented','off') ;
    set_param('fifteenbands/Subtract10','Commented','off');
    set_param('fifteenbands/Subtract11','Commented','off');
    set_param('fifteenbands/Subtract12','Commented','off');

    freq1 = 100;
    freq2 = 125;
    freq3 = 160;
    freq4 = 200;
    freq5 = 250;
    freq6 = 315;
    freq7 = 400;
    freq8 = 500;
    freq9 = 630;
    freq10 = 800;
    freq11 = 1000;
    freq12 = 1250;
    gainleft = 15;

    assignin('base','freq1',freq1);
    assignin('base','freq2',freq2);
    assignin('base','freq3',freq3);
    assignin('base','freq4',freq4);
    assignin('base','freq5',freq5);
    assignin('base','freq6',freq6);
    assignin('base','freq7',freq7);
    assignin('base','freq8',freq8);
    assignin('base','freq9',freq9);
    assignin('base','freq10',freq10);
    assignin('base','freq11',freq11);
    assignin('base','freq12',freq12);

    assignin('base','bw1',10);
    assignin('base','bw2',15);
    assignin('base','bw3',18);
    assignin('base','bw4',25);
    assignin('base','bw5',30);
    assignin('base','bw6',38);
    assignin('base','bw7',45);
    assignin('base','bw8',60);
    assignin('base','bw9',72);
    assignin('base','bw10',91);
    assignin('base','bw11',110);
    assignin('base','bw12',130);
    set(handles.text110,'String','100Hz');
    set(handles.text111,'String','125Hz');
    set(handles.text112,'String','160Hz');
    set(handles.text113,'String','200Hz');
    set(handles.text114,'String','250Hz');
    set(handles.text115,'String','315Hz');
    set(handles.text116,'String','400Hz');
    set(handles.text117,'String','500Hz');
    set(handles.text118,'String','630Hz');
    set(handles.text119,'String','800Hz');
    set(handles.text120,'String','1000Hz');
    set(handles.text121,'String','1250Hz');
    set(handles.text4,'String',0);
    set(handles.text5,'String',0);
    set(handles.text6,'String',0);
    set(handles.text45,'String',0);
    set(handles.text46,'String',0);
    set(handles.text59,'String',0);
    set(handles.text60,'String',0);
    set(handles.text61,'String',0);
    set(handles.text62,'String',0);
    set(handles.text63,'String',0);
    set(handles.text64,'String',0);
    set(handles.text65,'String',0);
    set(handles.gainleft,'String',gainleft);

    if ((gain1 < 0) && (gain2 < 0) && (gain3 < 0)  && (gain4 < 0 )) || ((gain1 == gain2) && (gain1 == gain3) && (gain1 == gain4))
        set(handles.slider1,'Enable','on');
        set(handles.slider2,'Enable','on');
        set(handles.slider3,'Enable','on');
        set(handles.slider1,'value',0);
        set(handles.slider2,'value',0);
        set(handles.slider3,'value',0);
        set(handles.slider4,'Enable','on');
        set(handles.slider5,'Enable','on');
        set(handles.slider6,'Enable','on');
        set(handles.slider4,'value',0);
        set(handles.slider5,'value',0);
        set(handles.slider6,'value',0);
        set(handles.slider7,'Enable','on');
        set(handles.slider8,'Enable','on');
        set(handles.slider9,'Enable','on');
        set(handles.slider7,'value',0);
        set(handles.slider8,'value',0);
        set(handles.slider9,'value',0);
        set(handles.slider10,'Enable','on');
        set(handles.slider11,'Enable','on');
        set(handles.slider12,'Enable','on');
        set(handles.slider10,'value',0);
        set(handles.slider11,'value',0);
        set(handles.slider12,'value',0);
        set(handles.instruction,'String','Result of Round 1 has been submitted, please proceed to Round 2. Click ''Stop'' when finish adjusting. All sliders are available to adjust.');
    elseif gain1 < 0 && gain2 < 0 && gain3 < 0
        set(handles.slider1,'Enable','on');
        set(handles.slider2,'Enable','on');
        set(handles.slider3,'Enable','on');
        set(handles.slider1,'value',0);
        set(handles.slider2,'value',0);
        set(handles.slider3,'value',0);
        set(handles.slider4,'Enable','on');
        set(handles.slider5,'Enable','on');
        set(handles.slider6,'Enable','on');
        set(handles.slider4,'value',0);
        set(handles.slider5,'value',0);
        set(handles.slider6,'value',0);
        set(handles.slider7,'Enable','on');
        set(handles.slider8,'Enable','on');
        set(handles.slider9,'Enable','on');
        set(handles.slider7,'value',0);
        set(handles.slider8,'value',0);
        set(handles.slider9,'value',0);
        set(handles.instruction,'String','Result of Round 1 has been submitted, please proceed to Round 2. Click ''Stop'' when finish adjusting. Use slider 1,2,3,4,5,6,7,8,9');
    elseif gain1 < 0 && gain2 < 0 && gain4 < 0
        set(handles.slider1,'Enable','on');
        set(handles.slider2,'Enable','on');
        set(handles.slider3,'Enable','on');
        set(handles.slider1,'value',0);
        set(handles.slider2,'value',0);
        set(handles.slider3,'value',0);
        set(handles.slider4,'Enable','on');
        set(handles.slider5,'Enable','on');
        set(handles.slider6,'Enable','on');
        set(handles.slider4,'value',0);
        set(handles.slider5,'value',0);
        set(handles.slider6,'value',0);
        set(handles.slider10,'Enable','on');
        set(handles.slider11,'Enable','on');
        set(handles.slider12,'Enable','on');
        set(handles.slider10,'value',0);
        set(handles.slider11,'value',0);
        set(handles.slider12,'value',0);
        set(handles.instruction,'String','Result of Round 1 has been submitted, please proceed to Round 2. Click ''Stop'' when finish adjusting. Use slider 1,2,3,4,5,6,10,11,12');
    elseif gain1 < 0 && gain3 < 0 && gain4 < 0
        set(handles.slider1,'Enable','on');
        set(handles.slider2,'Enable','on');
        set(handles.slider3,'Enable','on');
        set(handles.slider1,'value',0);
        set(handles.slider2,'value',0);
        set(handles.slider3,'value',0);
        set(handles.slider7,'Enable','on');
        set(handles.slider8,'Enable','on');
        set(handles.slider9,'Enable','on');
        set(handles.slider7,'value',0);
        set(handles.slider8,'value',0);
        set(handles.slider9,'value',0);
        set(handles.slider10,'Enable','on');
        set(handles.slider11,'Enable','on');
        set(handles.slider12,'Enable','on');
        set(handles.slider10,'value',0);
        set(handles.slider11,'value',0);
        set(handles.slider12,'value',0);
        set(handles.instruction,'String','Result of Round 1 has been submitted, please proceed to Round 2. Click ''Stop'' when finish adjusting. Use slider 1,2,3,7,8,9,10,11,12');
    elseif gain2 < 0 && gain3 < 0 && gain4 < 0
        set(handles.slider4,'Enable','on');
        set(handles.slider5,'Enable','on');
        set(handles.slider6,'Enable','on');
        set(handles.slider4,'value',0);
        set(handles.slider5,'value',0);
        set(handles.slider6,'value',0);
        set(handles.slider7,'Enable','on');
        set(handles.slider8,'Enable','on');
        set(handles.slider9,'Enable','on');
        set(handles.slider7,'value',0);
        set(handles.slider8,'value',0);
        set(handles.slider9,'value',0);
        set(handles.slider10,'Enable','on');
        set(handles.slider11,'Enable','on');
        set(handles.slider12,'Enable','on');
        set(handles.slider10,'value',0);
        set(handles.slider11,'value',0);
        set(handles.slider12,'value',0);
        set(handles.instruction,'String','Result of Round 1 has been submitted, please proceed to Round 2. Click ''Stop'' when finish adjusting. Use slider 4,5,6,7,8,9,10,11,12');
    elseif gain1 < 0 && gain2 < 0
        set(handles.slider1,'Enable','on');
        set(handles.slider2,'Enable','on');
        set(handles.slider3,'Enable','on');
        set(handles.slider1,'value',0);
        set(handles.slider2,'value',0);
        set(handles.slider3,'value',0);
        set(handles.slider4,'Enable','on');
        set(handles.slider5,'Enable','on');
        set(handles.slider6,'Enable','on');
        set(handles.slider4,'value',0);
        set(handles.slider5,'value',0);
        set(handles.slider6,'value',0);
        set(handles.instruction,'String','Result of Round 1 has been submitted, please proceed to Round 2. Click ''Stop'' when finish adjusting. Use slider 1,2,3,4,5,6');
    elseif gain1 < 0 && gain3 < 0
        set(handles.slider1,'Enable','on');
        set(handles.slider2,'Enable','on');
        set(handles.slider3,'Enable','on');
        set(handles.slider1,'value',0);
        set(handles.slider2,'value',0);
        set(handles.slider3,'value',0);
        set(handles.slider7,'Enable','on');
        set(handles.slider8,'Enable','on');
        set(handles.slider9,'Enable','on');
        set(handles.slider7,'value',0);
        set(handles.slider8,'value',0);
        set(handles.slider9,'value',0);
        set(handles.instruction,'String','Result of Round 1 has been submitted, please proceed to Round 2. Click ''Stop'' when finish adjusting. Use slider 1,2,3,7,8,9');
    elseif gain1 < 0 && gain4 <0
        set(handles.slider1,'Enable','on');
        set(handles.slider2,'Enable','on');
        set(handles.slider3,'Enable','on');
        set(handles.slider1,'value',0);
        set(handles.slider2,'value',0);
        set(handles.slider3,'value',0);
        set(handles.slider10,'Enable','on');
        set(handles.slider11,'Enable','on');
        set(handles.slider12,'Enable','on');
        set(handles.slider10,'value',0);
        set(handles.slider11,'value',0);
        set(handles.slider12,'value',0);
        set(handles.instruction,'String','Result of Round 1 has been submitted, please proceed to Round 2. Click ''Stop'' when finish adjusting. Use slider 1,2,3,10,11,12');
    elseif gain2 < 0 && gain3 < 0
        set(handles.slider4,'Enable','on');
        set(handles.slider5,'Enable','on');
        set(handles.slider6,'Enable','on');
        set(handles.slider4,'value',0);
        set(handles.slider5,'value',0);
        set(handles.slider6,'value',0);
        set(handles.slider7,'Enable','on');
        set(handles.slider8,'Enable','on');
        set(handles.slider9,'Enable','on');
        set(handles.slider7,'value',0);
        set(handles.slider8,'value',0);
        set(handles.slider9,'value',0);
        set(handles.instruction,'String','Result of Round 1 has been submitted, please proceed to Round 2. Click ''Stop'' when finish adjusting. Use slider 4,5,6,7,8,9');
    elseif gain2 < 0 && gain4 < 0
        set(handles.slider4,'Enable','on');
        set(handles.slider5,'Enable','on');
        set(handles.slider6,'Enable','on');
        set(handles.slider4,'value',0);
        set(handles.slider5,'value',0);
        set(handles.slider6,'value',0);
        set(handles.slider10,'Enable','on');
        set(handles.slider11,'Enable','on');
        set(handles.slider12,'Enable','on');
        set(handles.slider10,'value',0);
        set(handles.slider11,'value',0);
        set(handles.slider12,'value',0);
        set(handles.instruction,'String','Result of Round 1 has been submitted, please proceed to Round 2. Click ''Stop'' when finish adjusting. Use slider 4,5,6,10,11,12');
    elseif gain3 < 0 && gain4 < 0
        set(handles.slider7,'Enable','on');
        set(handles.slider8,'Enable','on');
        set(handles.slider9,'Enable','on');
        set(handles.slider7,'value',0);
        set(handles.slider8,'value',0);
        set(handles.slider9,'value',0);
        set(handles.slider10,'Enable','on');
        set(handles.slider11,'Enable','on');
        set(handles.slider12,'Enable','on');
        set(handles.slider10,'value',0);
        set(handles.slider11,'value',0);
        set(handles.slider12,'value',0);
        set(handles.instruction,'String','Result of Round 1 has been submitted, please proceed to Round 2. Click ''Stop'' when finish adjusting. Use slider 7,8,9,10,11,12');
    elseif gain1 < 0
        set(handles.slider1,'Enable','on');
        set(handles.slider2,'Enable','on');
        set(handles.slider3,'Enable','on');
        set(handles.slider1,'value',0);
        set(handles.slider2,'value',0);
        set(handles.slider3,'value',0);
        set(handles.instruction,'String','Result of Round 1 has been submitted, please proceed to Round 2. Click ''Stop'' when finish adjusting. Use slider 1,2,3');
    elseif gain2 < 0
        set(handles.slider4,'Enable','on');
        set(handles.slider5,'Enable','on');
        set(handles.slider6,'Enable','on');
        set(handles.slider4,'value',0);
        set(handles.slider5,'value',0);
        set(handles.slider6,'value',0);
        set(handles.instruction,'String','Result of Round 1 has been submitted, please proceed to Round 2. Click ''Stop'' when finish adjusting. Use slider 4,5,6');
    elseif gain3 < 0
        set(handles.slider7,'Enable','on');
        set(handles.slider8,'Enable','on');
        set(handles.slider9,'Enable','on');
        set(handles.slider7,'value',0);
        set(handles.slider8,'value',0);
        set(handles.slider9,'value',0);
        set(handles.instruction,'String','Result of Round 1 has been submitted, please proceed to Round 2. Click ''Stop'' when finish adjusting. Use slider 7,8,9');
    elseif gain4 < 0
        set(handles.slider10,'Enable','on');
        set(handles.slider11,'Enable','on');
        set(handles.slider12,'Enable','on');
        set(handles.slider10,'value',0);
        set(handles.slider11,'value',0);
        set(handles.slider12,'value',0);
        set(handles.instruction,'String','Result of Round 1 has been submitted, please proceed to Round 2. Click ''Stop'' when finish adjusting. Use slider 10,11,12');
    end
    gain1 = 0;
    gain2 = 0;
    gain3 = 0;
    gain4 = 0;
    gain5 = 0;
    gain6 = 0;
    gain7 = 0;
    gain8 = 0;
    gain9 = 0;
    gain10 = 0;
    gain11 = 0;
    gain12 = 0;
    assignin('base','gain1',gain1);
    assignin('base','gain2',gain2);
    assignin('base','gain3',gain3);
    assignin('base','gain4',gain4);
    assignin('base','gain5',gain5);
    assignin('base','gain6',gain6);
    assignin('base','gain7',gain7);
    assignin('base','gain8',gain8);
    assignin('base','gain9',gain9);
    assignin('base','gain10',gain10);
    assignin('base','gain11',gain11);
    assignin('base','gain12',gain12);
    sim('fifteenbands');
elseif rounds == 2
    gain5 = get(handles.text46,'string');
    gain6 = get(handles.text59,'string');
    gain7 = get(handles.text60,'string');
    gain8 = get(handles.text61,'string');
    gain9 = get(handles.text62,'string');
    gain10 = get(handles.text63,'string');
    gain11 = get(handles.text64,'string');
    gain12 = get(handles.text65,'string');
    rounds = rounds - 1;
    assignin('base','rounds',rounds);
   
    if strcmp(handles.slider1.Enable, 'on') && ...
            strcmp(handles.slider4.Enable, 'on') && ...
            strcmp(handles.slider7.Enable, 'on') && ...
            strcmp(handles.slider10.Enable, 'on')
        C = {name gain1 gain2 gain3 gain4 gain5 gain6 gain7 gain8 gain9 gain10 gain11 gain12};
    elseif strcmp(handles.slider1.Enable, 'on') && ...
            strcmp(handles.slider4.Enable, 'on') && ...
            strcmp(handles.slider7.Enable, 'on')
        C = {name gain1 gain2 gain3 gain4 gain5 gain6 gain7 gain8 gain9 "-" "-" "-"};
    elseif strcmp(handles.slider4.Enable, 'on') && ...
            strcmp(handles.slider7.Enable, 'on') && ...
            strcmp(handles.slider10.Enable, 'on')
        C = {name "-" "-" "-" gain4 gain5 gain6 gain7 gain8 gain9 gain10 gain11 gain12};
    elseif strcmp(handles.slider1.Enable, 'on') && ...
            strcmp(handles.slider4.Enable, 'on') && ...
            strcmp(handles.slider10.Enable, 'on')
        C = {name gain1 gain2 gain3 gain4 gain5 gain6 "-" "-" "-" gain10 gain11 gain12};
    elseif strcmp(handles.slider1.Enable, 'on') && ...
            strcmp(handles.slider7.Enable, 'on') && ...
            strcmp(handles.slider10.Enable, 'on')
        C = {name gain1 gain2 gain3 "-" "-" "-" gain7 gain8 gain9 gain10 gain11 gain12};
    elseif strcmp(handles.slider1.Enable, 'on') && ...
            strcmp(handles.slider4.Enable, 'on')
        C = {name gain1 gain2 gain3 gain4 gain5 gain6 "-" "-" "-" "-" "-" "-"};
    elseif strcmp(handles.slider1.Enable, 'on') && ...
            strcmp(handles.slider7.Enable, 'on')
        C = {name gain1 gain2 gain3 "-" "-" "-" gain7 gain8 gain9 "-" "-" "-"};
    elseif strcmp(handles.slider1.Enable, 'on') && ...
            strcmp(handles.slider10.Enable, 'on')
        C = {name gain1 gain2 gain3 "-" "-" "-" "-" "-" "-" gain10 gain11 gain12};
    elseif strcmp(handles.slider4.Enable, 'on') && ...
            strcmp(handles.slider7.Enable, 'on')
        C = {name "-" "-" "-" gain4 gain5 gain6 gain7 gain8 gain9 "-" "-" "-"};
    elseif strcmp(handles.slider4.Enable, 'on') && ...
            strcmp(handles.slider10.Enable, 'on')
        C = {name "-" "-" "-" gain4 gain5 gain6 "-" "-" "-" gain10 gain11 gain12};
    elseif strcmp(handles.slider7.Enable, 'on') && ...
            strcmp(handles.slider10.Enable, 'on')
        C = {name "-" "-" "-" "-" "-" "-" gain7 gain8 gain9 gain10 gain11 gain12};
    elseif strcmp(handles.slider1.Enable, 'on')
        C = {name gain1 gain2 gain3 "-" "-" "-" "-" "-" "-" "-" "-" "-"};
    elseif strcmp(handles.slider4.Enable, 'on')
        C = {name "-" "-" "-" gain4 gain5 gain6 "-" "-" "-" "-" "-" "-"};
    elseif strcmp(handles.slider7.Enable, 'on')
        C = {name "-" "-" "-" "-" "-" "-" gain7 gain8 gain9 "-" "-" "-"};
    elseif strcmp(handles.slider10.Enable, 'on')
        C = {name "-" "-" "-" "-" "-" "-" "-" "-" "-" gain10 gain11 gain12};
    end
    [~,B,b] = fileparts(songs{i});
    B = [B b];
    D = cat(2,{datetime},B,C);
    filename = 'mydata.xlsx';
    writecell(D,filename,'Sheet',2,"WriteMode","append");

    if i == totalsongs
        set(handles.instruction,'String','You have completed the experiment, thank you.');
        msgbox("The experiment has been completed","Success");
        set(handles.PlayButton,'Enable','off');
        set(handles.Initialize,'Enable','off');
        set(handles.ResetGainButton,'Enable','off');
        set(handles.StopButton,'Enable','off');
        set(handles.SubmitButton,'Enable','off');
    elseif i <= totalsongs
        set(handles.instruction,'String','Result of Round 2 has been submitted. Please proceed to Round 1 of the next song and only use the first 4 sliders from the left. Click ''Stop'' when finish adjusting.');
        i = i + 1;
        set_param('fifteenbands/From Multimedia File','Filename',songs{i});
        %playing the next song
        rounds = 1;
        assignin('base','rounds',rounds);
        freq1 = 125;
        freq2 = 250;
        freq3 = 500;
        freq4 = 1000;
        gainlimit = 15;
        set(handles.roundnumber,'String',rounds);
        set(handles.songnumber,'String',i);
        set(handles.slider1,'Enable','on');
        set(handles.slider2,'Enable','on');
        set(handles.slider3,'Enable','on');
        set(handles.slider4,'Enable','on');
        set(handles.slider5,'Enable','off');
        set(handles.slider6,'Enable','off');
        set(handles.slider7,'Enable','off');
        set(handles.slider8,'Enable','off');
        set(handles.slider9,'Enable','off');
        set(handles.slider10,'Enable','off');
        set(handles.slider11,'Enable','off');
        set(handles.slider12,'Enable','off');

        assignin('base','freq1',freq1);
        assignin('base','freq2',freq2);
        assignin('base','freq3',freq3);
        assignin('base','freq4',freq4);

        set(handles.text110,'String','125Hz');
        set(handles.text111,'String','250Hz');
        set(handles.text112,'String','500Hz');
        set(handles.text113,'String','1000Hz');
        set(handles.text114,'String','');
        set(handles.text115,'String','');
        set(handles.text116,'String','');
        set(handles.text117,'String','');
        set(handles.text118,'String','');
        set(handles.text119,'String','');
        set(handles.text120,'String','');
        set(handles.text121,'String','');

        assignin('base','bw1',100);
        assignin('base','bw2',210);
        assignin('base','bw3',400);
        assignin('base','bw4',700);

        set(handles.slider1,'value',0);
        set(handles.slider2,'value',0);
        set(handles.slider3,'value',0);
        set(handles.slider4,'value',0);

        gain1 = get(handles.slider1,'value');
        gain2 = get(handles.slider2,'value');
        gain3 = get(handles.slider3,'value');
        gain4 = get(handles.slider4,'value');

        assignin('base','gain1',gain1);
        assignin('base','gain2',gain2);
        assignin('base','gain3',gain3);
        assignin('base','gain4',gain4);

        gainleft = gainlimit + gain1 + gain2 + gain3 + gain4;
        set(handles.text4,'String',gain1);
        set(handles.text5,'String',gain2);
        set(handles.text6,'String',gain3);
        set(handles.text45,'String',gain4);
        set(handles.gainleft,'String',gainleft);
        set(handles.text46,'String','');
        set(handles.text59,'String','');
        set(handles.text60,'String','');
        set(handles.text61,'String','');
        set(handles.text62,'String','');
        set(handles.text63,'String','');
        set(handles.text64,'String','');
        set(handles.text65,'String','');

        set_param('fifteenbands/Variable Bandwidth IIR Filter5','Commented','on');
        set_param('fifteenbands/Variable Bandwidth IIR Filter6','Commented','on');
        set_param('fifteenbands/Variable Bandwidth IIR Filter7','Commented','on');
        set_param('fifteenbands/Variable Bandwidth IIR Filter8','Commented','on');
        set_param('fifteenbands/Variable Bandwidth IIR Filter9','Commented','on');
        set_param('fifteenbands/Variable Bandwidth IIR Filter10','Commented','on');
        set_param('fifteenbands/Variable Bandwidth IIR Filter11','Commented','on');
        set_param('fifteenbands/Variable Bandwidth IIR Filter12','Commented','on');
        set_param('fifteenbands/dB Gain5','Commented','on');
        set_param('fifteenbands/dB Gain6','Commented','on');
        set_param('fifteenbands/dB Gain7','Commented','on');
        set_param('fifteenbands/dB Gain8','Commented','on');
        set_param('fifteenbands/dB Gain9','Commented','on');
        set_param('fifteenbands/dB Gain10','Commented','on');
        set_param('fifteenbands/dB Gain11','Commented','on');
        set_param('fifteenbands/dB Gain12','Commented','on');
        set_param('fifteenbands/Subtract5','Commented','on');
        set_param('fifteenbands/Subtract6','Commented','on');
        set_param('fifteenbands/Subtract7','Commented','on');
        set_param('fifteenbands/Subtract8','Commented','on');
        set_param('fifteenbands/Subtract9','Commented','on');
        set_param('fifteenbands/Subtract10','Commented','on');
        set_param('fifteenbands/Subtract11','Commented','on');
        set_param('fifteenbands/Subtract12','Commented','on');
        sim('fifteenbands');
    end
end

% --- Executes on button press in CloseButton.
function CloseButton_Callback(~, ~, ~)
set_param('fifteenbands','SimulationCommand','stop');
close;

function text59_CreateFcn(~, ~, ~)
function figure1_DeleteFcn(~, ~, ~)
function name_Callback(~, ~, ~)
function name_CreateFcn(hObject, ~, ~)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function PlayButton_ButtonDownFcn(~, ~, ~)
function PlayButton_KeyPressFcn(~, ~, ~) 
function initialize_Callback(~, ~, ~)
