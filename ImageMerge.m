% Bu matlab kodu iki resmi okur ve birleştirir. Görüntü kayıt yöntemi korelasyon tekniği kullanılarak yapılır. 
% İkinci görüntünün küçük bir kısmı maske olarak alınır. 
% Bu maske, ilk görüntünün aynı boyuttaki görüntü pikselleriyle ilişkilendirilir. 
% Maske kayar ve ilişkilendirir. Korelasyonun maksimum olduğu nokta (1'e yakın) optimum nokta olarak alınır.
% Nokta, ikinci resmi ilmek üzerine dikmek için kullanılır.
clc, clear, close all
warning off

im1 = im2double(imread('1_1.jpg')); % 1. imgeyi oku ve double cinsine çevir.
im2 = im2double(imread('1_2.jpg')); % 2. imgeyi oku ve double cinsine çevir.

[rows,columns] = size(im1(:,:,1)); % imge 1 veya imge 2 nin sadece bir kanalını al ve boyutunu hesapla.
% Bunun yapılmasındaki amaç hem renkli imgeyi almak hem de sadece imgenin
% bir botunu almaktır. Aksi halde MATLAB üç boyutu da aynı anda
% alamayacağına göre hata verecektir.
Empty_A = []; % Boş bir dizi oluşturuldu. Buradaki amaç korelasyon yapıldıktan sonraki değerler ile
% boş matrisi yani sıfıraları birleştirmek için oluşturuldu.

for i = 1:10 % for döngüsü açıldı
    for j = 1:rows % for döngüsü açıldı
        imout1(j,i) = im2(j,i); % 2. imgenin satırlarının tamamı ile sütunlarının ilk üçü alınarak yeni 
        % bir değişkene at�ldı.
    end % for döngüsünü bitir.
end % for döngüsünü bitir.

for k = 1:columns % for dögüsü açıldı
    for j = 1:10 % for dögüsü açıldı
        imout2(:,j) = im1(:,k); % Burada ise 1. imgenin sütunlarının tamamı alındı ve satılarının
        % sadece ilk üç satırı alındı ve yeni bir değişkene atıldı.
    end % for döngüsünü bitir.
    zeros_fill = corr2(imout1,imout2); % Elde edilen bu satır ve sütun taramalarından sonra bu iki imgenin
    % korelasyonuna bakıldı.
    Empty_A = [Empty_A zeros_fill]; % Yukarıda oluşturulan boş matris ile korelasyonu alınan bu imge birleştirlerek
    %yeni bir değişkene atıldı.
end % for döngüsünü bitir.

[min_value, index] = max(Empty_A); % Buradaki amaç matrisin max değeri alarak birleştirelecek olan iki imgenin
% birleşim noktası alınmak istenmesidir.
n_columns = index + columns; % Çıktı görüntüsünün yeni sütunu oluşturuldu.(1. sonu + 2. imgenin 1.pixeli ...)

for i = 1:rows % for döngüsü açıldı.
    for j = 1:index % for döngüsü açıldı.
        imout3(i,j,:) = im1(i,j,:); % İlk imgeyinin değeleri ve RGB renk tonları alınarak yeni bir 
        % değişkene atıldı.
    end % for döngüsünü bitir.
end % for döngüsünü bitir.
for i = 1:rows % for döngüsü açıldı. 
    for k = index:n_columns % for döngüsü açıldı.
        imout3(i,k,:) = im2(i,k-index+1,:); %İkinci imgenin başlangıç noktası ile bitiş noktasına kadarki
        % pixel değerleri alınarak yeni bir değişkene atıldı. Yani örneğin 100. pixelden itibaren 101, 102, ..
        % imgenin son pixeline kadarki değerler alındı. 
    end % for döngüsünü bitir.
end % for döngüsünü bitir.

subplot(121); % birden çok imgeyi aynı figürde görmek için subplot komutu kullanıldı. 1 satır ve 2 sütundan
% oluşan figure
imagesc(im1);title('First Image'); % imge 1 i göster
subplot(122); % birden çok imgeyi aynı figürde görmek için subplot komutu kullanıldı. 1 satır ve 2 sütundan
% oluşan figure
imagesc(im2);title('Second Image');% imge 2 yi göster
figure(2);imagesc(imout3); % bileştirilmiş iki imgeyi göster
title('Merged Image'); % imgelerin boyutları ve birleştirilmiş imgenin boyutları orantısız olduğu için 
% imagesc komutu kullanıldı.
