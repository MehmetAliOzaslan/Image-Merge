clc, clear, close all
warning off

im1 = im2double(imread('1_1.jpg'));
im2 = im2double(imread('1_2.jpg')); 

[rows,columns] = size(im1(:,:,1)); 
Empty_A = [];

for i = 1:10 
    for j = 1:rows 
        imout1(j,i) = im2(j,i); 
    end 
end 

for k = 1:columns 
    for j = 1:10 
        imout2(:,j) = im1(:,k);
    end 
    zeros_fill = corr2(imout1,imout2);
    Empty_A = [Empty_A zeros_fill];
end 

[min_value, index] = max(Empty_A); 
n_columns = index + columns; 
for i = 1:rows 
    for j = 1:index
        imout3(i,j,:) = im1(i,j,:); 
    end
end
for i = 1:rows 
    for k = index:n_columns 
        imout3(i,k,:) = im2(i,k-index+1,:);
    end 
end

subplot(121);
imagesc(im1);title('First Image'); 
subplot(122); 
imagesc(im2);title('Second Image');
figure(2);imagesc(imout3); 
title('Merged Image'); 
