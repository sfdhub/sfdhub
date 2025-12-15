function outputArg = zerost(inputArg)

if length(size(inputArg))>=3 || length(size(inputArg))<=1 || size(inputArg,1) ~= size(inputArg,2)
    disp('error, not square matrix  ')
    return
end
mtrx =inputArg;
for i=1:size(inputArg,1)
    for j=1:size(inputArg,2)
        if mod(j,2)==0
            mtrx(i,j)=0;
        end
    end
end

outputArg = mtrx;
end