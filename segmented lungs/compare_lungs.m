clear all, close all, clc
%% Loading all the mat files 

dirinf = dir('*.mat');
nfiles = length(dirinf);
for n = 1:nfiles
  infile = dirinf(n).name; 
  load(infile) 
  infile = infile(1:end-4);
end
%% Catagorizing segmented lungs 
lungs = {lungT0 ,lungT10 ,lungT20 , lungT30, lungT40, lungT50,lungT60,lungT70,lungT80,lungT90};
lungscor = {  lungcorT0, lungcorT10,lungcorT20,lungcorT30,lungcorT40,lungcorT50,lungcorT60,lungcorT70,lungcorT80,lungcorT90};
lungssag = {  lungSagT0,lungSagT10,lungSagT20,lungSagT30,lungSagT40,lungSagT50,lungSagT60,lungSagT70,lungSagT80,lungSagT90, };
lungswsp = {lungT0wsp,lungT10wsp,lungT20wsp,lungT30wsp,lungT40wsp,lungT50wsp,lungT60wsp,lungT70wsp,lungT80wsp,lungT90wsp };

% lungT0 = Segmented lung from "axial" view. @T0 and.... 
% lungcorT0 = Segmented lung from "coronal" view. @T0 and.... 
% lungSagT0 = Segmented lung from "sagittal" view.   @T0 and.... 
% lungT0wsp = Segmented lung with salt & peper noise.Segmented lung from "sagittal" view.  @T0 and.... 

%% Comparing 2 whole lungs with contours 
for i =1:76
    imcontour(lungT40(:,:,i),2,' m'),grid on, title('Contours')
    hold on;
    imcontour(lungT90(:,:,i),2,' b'),grid on, title('Contours')
    hold on;
end
%% comparing slice 20 within the range of time interval lungs 
i=20

    imcontour(lungT0(:,:,i),2,' m'),grid on, title('Contours'),
    hold on;
    imcontour(lungT10(:,:,i),2,' b'),grid on, title('Contours')
    hold on;
    imcontour(lungT20(:,:,i),2,' r'),grid on, title('Contours')
    hold on;
    imcontour(lungT30(:,:,i),2,' g'),grid on, title('Contours')
    hold on;
    imcontour(lungT70(:,:,i),2,'c '),grid on, title('Contours')
    hold on;
    imcontour(lungT80(:,:,i),2,'y '),grid on, title('Contours')
    hold on;
    imcontour(lungT90(:,:,i),2,' k'),grid on, title('Contours')
    legend ('lungT0','lungT10','lungT20','lungT30','lungT40','lungT50','lungT60')

    %% comparing 2 lungs 
i=25

    imcontour(lungT0(:,:,i),2,' m'),grid on, title('Contours slice 25'),
    hold on;
    imcontour(lungT50(:,:,i),2,' b'),grid on, title('Contours slice 25')
    hold on;
    legend ('lungT0','lungT50')
%% Comparing 2 lungs in a 3D plane

figure;
p = patch(isosurface((int16(lungT0))));
p.FaceColor = 'red';
p.EdgeColor = 'none';
daspect([1/(76*0.976562 ),1/(76*0.976562),1/(76*2.5)]);
camlight
grid on
lighting phong

hold on;
p = patch(isosurface((int16(lungT50))));
p.FaceColor = 'green';
p.EdgeColor = 'none';
daspect([1/(76*0.976562 ),1/(76*0.976562),1/(76*2.5)]);
camlight
grid on
lighting phong


%% calulating volume and the area of the lungs
lungs = {lungT0 ,lungT10 ,lungT20 , lungT30, lungT40, lungT50,lungT60,lungT70,lungT80,lungT90};
lungscor = {  lungcorT0, lungcorT10,lungcorT20,lungcorT30,lungcorT40,lungcorT50,lungcorT60,lungcorT70,lungcorT80,lungcorT90};
lungssag = {  lungSagT0,lungSagT10,lungSagT20,lungSagT30,lungSagT40,lungSagT50,lungSagT60,lungSagT70,lungSagT80,lungSagT90, };

vollungs = [];
arealungs=[];
%%
for i = 1:10
    a = sum(sum(sum(lungssag{i})));
    voxel = 0.976562 * 0.976562 * 2.5;
    vollungsag(i) = (voxel *a * 10^-4)
end
%%
for i = 1:10
    ar = sum(sum(sum(lungs{i})));
    voxelar = 0.976562 * 0.976562 ;
    arealungs(i) = (voxelar *ar * 10^-4)
end

