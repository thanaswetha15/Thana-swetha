function v1 =qfunction(SC,TH1 ,TH0,c)
for i=1:3
    for j=1:3
        if SC{i,j}(1,1) >=TH1  && c(i,j) == 1
           v1=1;
        end
        if SC(i,j) < TH0 && c(i,j) == 0
           v1=0;
        end
    end
end

