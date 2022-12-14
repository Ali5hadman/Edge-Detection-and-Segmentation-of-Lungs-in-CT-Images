clear all, close all, clc
%% X & Y cordinates that are used to segment the lungs!
load('XY.mat')
load('XYcor.mat')
load('XYsag.mat')
load('XYwsp.mat')
%% Getting the volume and Binarizing 
readDCMfolder();  
vol = ans;
D= vol;
d= uint8(D);
map = colormap('gray');
close all;

I_max = max(max(D(:,:,25)));
for i= 1:136
    D_bin(:,:,i) = imbinarize(D(:,:,i), I_max/3);
end
%% Sperating the slices that includes the lungs
i = 1:76;
lungs = D_bin(:,:,i);
%% Croping the image 
lungs = imcomplement(lungs); %% Inverting the lungs from black to white for selection 
for i = 1:76
    temp = imcrop(lungs(:,:,i),[128.5 136.5 292 223]);
    BW2 = imfill(temp, 'holes'); 
    lungz(:,:,i) = BW2;
end
%% Can be uncommented if new XY cordinated need to be set 
sliceViewer(lungz);
%[X,Y] = getpts;

%% Separating the lung
for i = 1:76
    BW3 = bwselect(lungz(:,:,i),X,Y);
    lungT00(:,:,i) = BW3;
end
%% Viewing the segmented lung! 
volshow(lungT00)


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SEGMENTATION FROM SAGITTAL POINT OF VIEW
% Transforming the image:
for i = 1:512
        temp=D_bin(i,:,:);
        tempSize=size(temp);
        tempX=tempSize(2);
        tempy=tempSize(3);
        tempreshaped=reshape(temp,[tempX tempy]);
        temprot=imrotate(tempreshaped,90);
        lungSagall(:,:,i)=temprot;
end
%% Inverting the image and separating the slices with the lungs 
lungSagall = imcomplement(lungSagall);
i = 135:324
lungSag(:,:,i-134) =imfill( lungSagall(:,:,i),'holes');

%% Can be uncommented if new XY cordinated need to be set 
sliceViewer(lungSag);
%[Xsag,Ysag] = getpts;

%% Separating the lung
for i = 1:190
    lungSagT00(:,:,i) = bwselect(lungSag(:,:,i),Xsag,Ysag);
end
%% Viewing the segmented lung! 
volshow(lungSagT00) 

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SEGMENTATION FROM CORONAL POINT OF VIEW
% % Transforming the image:
for i = 1:512
        temp=D_bin(:,i,:);
        tempSize=size(temp);
        tempX=tempSize(1);
        tempy=tempSize(3);
        tempreshaped=reshape(temp,[tempX tempy]);
        temprot=imrotate(tempreshaped,90);
        D_bincor(:,:,i)=temprot;
end

%% Inverting the image and separating the slices with the lungs 
D_bincor = imcomplement(D_bincor);
i = 130:417;
lungcor(:,:,i-129) =imfill( D_bincor(:,:,i),'holes');

%% Can be uncommented if new XY cordinated need to be set 
sliceViewer(lungcor);
%[Xcor,Ycor] = getpts;

%% Separating the lung
for i = 1:288
    lungcorT00(:,:,i) = bwselect(lungcor(:,:,i),Xcor,Ycor);
end

%% Viewing the segmented lung! 
volshow(lungcorT00) 

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SALT & PEPER
% separating the slices that include the lungs
i = 1:76;
addnoise = D(:,:,i);
%% Changing the format of the image and adding noise
addnoise = uint8(addnoise);
for i=1:76
    J = imnoise(addnoise(:,:,i),'salt & pepper');
    lungsWSP(:,:,i) = J;
end

%% Binarizing the noisy image 
I_max = max(max(lungsWSP(:,:,25)));
for i= 1:76
    lungsWSP_bin(:,:,i) = imbinarize(lungsWSP(:,:,i), 'adaptive');
end

%% %% Croping the image 
for i = 1:76
     lungzWSP(:,:,i) = imcrop(lungsWSP_bin(:,:,i),[128.5 136.5 292 223]);
end

%% Can be uncommented if new XY cordinated need to be set 
%sliceViewer(lungzWSP);
%[XWSP,YWSP] = getpts;

%% Separating the lung
for i = 1:76
    BW3 = bwselect(lungzWSP(:,:,i),XWSP,YWSP);
    lungT00wsp(:,:,i) = BW3;
end
%% Viewing the segmented lung! 
volshow(lungSagT00)