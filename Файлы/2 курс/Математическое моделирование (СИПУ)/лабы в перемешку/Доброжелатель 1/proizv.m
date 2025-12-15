function outputArg = proizv(inputArg)

if size(inputArg,1)>=2 || length(size(inputArg))<=0 || size(inputArg,2) <= 1
    disp('error, not massiv  ')
    return
end
pr=1;
for i=1:length(inputArg)
        if (inputArg(i)<0)
            pr= pr * abs(inputArg(i));
        end
end
if pr == 1
    outputArg = 0;
else 
    outputArg = pr;
end
end
