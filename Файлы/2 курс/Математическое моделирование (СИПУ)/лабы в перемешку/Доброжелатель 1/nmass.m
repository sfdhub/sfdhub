function outputArg = nmass(inputArg)

if size(inputArg,1)>=2 || length(size(inputArg))<=0 || size(inputArg,2) <= 1
    disp('error, not massiv  ')
    return
end
mas=inputArg;
for i=1:(length(mas)-1)
    j=length(mas)-1;
    while j>i
        if (mas(j-1)>mas(j))
        temp=mas(j-1);
        mas(j-1)=mas(j);
        mas(j)=temp;
        end
        j= j-1;
    end
end

outputArg = mas;
end