function [indxminI,indxminJ] = modmin(inputArg)

if length(size(inputArg))>=3 || length(size(inputArg))<=1 
    disp('error, not 2x matrix  ')
    return
end
min =inf;
indxminI=0;
indxminJ=0;
for i=1:size(inputArg,1)
    for j=1:size(inputArg,2)
        if abs(inputArg(i,j))<min
        min=abs(inputArg(i,j));
        indxminI=i;
        indxminJ=j;
        end
    end
end
disp('минимальный по модулю элемент находится: ')
fprintf('строка = %d столбец = %d \n',indxminI,indxminJ);

end