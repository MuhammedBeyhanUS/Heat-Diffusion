i = imread('img.jpg');
g = rgb2gray(i);
[sizeX,sizeY]=size(g);
%g = imnoise(g,'gaussian', 0.002);
imshow(g);
%%---XD Kontrol Paneli XD---%%
% Güzel değerler : dt 0.267 iteration 100--- 0.251 e 1000   0.06e 5000
dt = 0.25; 
iteration = 10000; 
debir = 1000; % Kaç iteration da bir foto göterilsin
show = 1;  % Fotoğrafları göster (heat operation)
gradiants_show = 0; %gradiance fotoları gösterilsin mi
for p = 1:iteration
g = double(g);
%figure,imshow(g);
output=g;

%KÃ¶Ã¾elerin hesaplanmasÃ½
output(1,1)=dt*(-4*g(1,1)+2*g(1,2)+2*g(2,1))+g(1,1);%sol Ã¼st kÃ¶Ã¾e deÄŸerlerinin hesaplanmasÃ½
output(1,sizeY)=dt*(-4*g(1,sizeY)+2*g(2,sizeY)+2*g(1,sizeY-1))+g(1,sizeY);%saÄŸ Ã¼st kÃ¶Ã¾e deÃ°erlerinin hesaplanmasÃ½
output(sizeX,sizeY)=dt*(-4*g(sizeX,sizeY)+2*g(sizeX-1,sizeY)+2*g(sizeX,sizeY-1))+g(sizeX,sizeY);%saÃ° alt kÃ¶Ã¾e deÃ°erlerinin hesaplanmasÃ½
output(sizeX,1)=dt*(-4*g(sizeX,1)+2*g(sizeX,2)+2*g(sizeX-1,1))+g(sizeX,1);%sol alt kÃ¶Ã¾e deÃ°erlerinin hesaplanmasÃ½

%KenarlarÃ½n hesaplanmasÃ½
for up = 2:sizeY-1
    output(1,up)=dt*(-4*g(1,up)+g(1,up-1)+g(1,up+1)+2*g(2,up))+g(1,up);%sol kenar deÃ°erlerinin hesaplanmasÃ½
end

for down = 2:sizeY-1
    output(sizeX,down)=dt*(-4*g(sizeX,down)+g(sizeX,down-1)+g(sizeX,down+1)+2*g(sizeX-1,down))+g(sizeX,down);%sol kenar deÃ°erlerinin hesaplanmasÃ½
end

for left = 2:sizeX-1
    output(left,1)=dt*(-4*g(left,1)+g(left-1,1)+g(left+1,1)+2*g(left,2))+g(left,1);%Ã¼st kenar deÃ°erlerinin hesaplanmasÃ½
end

for right = 2:sizeX-1
    output(right,sizeY)=dt*(-4*g(right,sizeY)+g(right-1,sizeY)+g(right+1,sizeY)+2*g(right,sizeY-1))+g(right,sizeY);%alt kenar deÃ°erlerinin hesaplanmasÃ½
end

for k = 2:sizeX-1
    for j = 2:sizeY-1
        output(k,j)=dt*(-4*g(k,j)+g(k-1,j)+g(k+1,j)+g(k,j-1)+g(k,j+1))+g(k,j);
    end
end

temp= 0.0;

for f = 1:sizeX
    for a = 1:sizeY
        temp = temp + output(f,a);        
    end
end
temp = temp/sizeX/sizeY;


alltemp(p)=temp;

g=output;
v(p) = var(g(:));
if mod(p,debir) == 0 
    
    output=uint8(output);
    
    if gradiants_show == 1
    [Gmag, Gdir] = imgradient(output,'prewitt');
    figure, imshow(Gdir);
    end
    if show == 1
    figure, imshow(output);
    end
    
    
    
    
end


end   
figure
stem(alltemp) %all point average  
figure
stem(v) 
        
        
