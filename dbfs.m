clear; clc; close all;
songFolder = [pwd '\SongFolder\'];

%transferring excel data to matlab, making '-' as 0 so that simulink model
%can detect the values to run the gain
matrix = readmatrix('mydata.xlsx','Sheet',2);
cell = readcell('mydata.xlsx','Sheet',2);%readtable or readcell?
songtitle = cell(2:end,2);
gainData = matrix(2:end,4:15);
gainData(isnan(gainData)) = 0;
sizeofgainData = size(gainData);

%loop to run the results of dbfs before and dbfs after
for y = 1:1:sizeofgainData(1) 
    gain1 = gainData(y,1);
    gain2 = gainData(y,2);
    gain3 = gainData(y,3);
    gain4 = gainData(y,4);
    gain5 = gainData(y,5);
    gain6 = gainData(y,6);
    gain7 = gainData(y,7);
    gain8 = gainData(y,8);
    gain9 = gainData(y,8);
    gain10 = gainData(y,10);
    gain11 = gainData(y,11);
    gain12 = gainData(y,12);
    if strcmp(songtitle(y),'whitenoise.wav')
        [a,fs] = audioread([songFolder 'whitenoise.wav']);
        dbfsbef(y,:) = 20*log10(rms(a(:,1)) * sqrt(2));
        set_param('fordbfs/From Multimedia File','Filename',[songFolder 'whitenoise.wav']);
        set_param('fordbfs/To Multimedia File','Filename',[songFolder int2str(y) 'whitenoise.wav']);
        info = audioinfo([songFolder 'whitenoise.wav']);
        duration = num2str(info.Duration);
        set_param('fordbfs', 'StopTime', duration);
        sim('fordbfs');
        pause(2.0);
        [x,Fs] = audioread([songFolder int2str(y) 'whitenoise.wav']);
        dbfsaft(y,:) = 20*log10(rms(x(:,1)) * sqrt(2));
    elseif strcmp(songtitle(y),'car.wav')
        [a,fs] = audioread([songFolder 'car.wav']);
        dbfsbef(y,:) = 20*log10(rms(a(:,1)) * sqrt(2));
        set_param('fordbfs/From Multimedia File','Filename',[songFolder 'car.wav']);
        set_param('fordbfs/To Multimedia File','Filename',[songFolder int2str(y) 'car.wav']);
        info = audioinfo([songFolder 'car.wav']);
        duration = num2str(info.Duration);
        set_param('fordbfs', 'StopTime', duration);
        sim('fordbfs');
        [x,Fs] = audioread([songFolder int2str(y) 'car.wav']);
        dbfsaft(y,:) = 20*log10(rms(x(:,1)) * sqrt(2));
    elseif strcmp(songtitle(y),'plane.wav')
        [a,fs] = audioread([songFolder 'plane.wav']);
        dbfsbef(y,:) = 20*log10(rms(a(:,1)) * sqrt(2));
        set_param('fordbfs/From Multimedia File','Filename',[songFolder 'plane.wav']);
        set_param('fordbfs/To Multimedia File','Filename',[songFolder int2str(y) 'plane.wav']);
        info = audioinfo([songFolder 'plane.wav']);
        duration = num2str(info.Duration);
        set_param('fordbfs', 'StopTime', duration);
        sim('fordbfs');
        [x,Fs] = audioread([songFolder int2str(y) 'plane.wav']);
        dbfsaft(y,:) = 20*log10(rms(x(:,1)) * sqrt(2));
    end
end

%To compute in excel
dbfstotal = cat(2,dbfsbef,dbfsaft);
writematrix(dbfstotal,'mydata.xlsx','Sheet',2,'Range','P2:Q20');
winopen('mydata.xlsx');

