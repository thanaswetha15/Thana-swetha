function a = CRTS(x,m,p,ShareImgNum,all)
for i =1:ShareImgNum
	if x < p 
		y = x+all*p;
		a= mod(y,m(i));
	else
		y=x-p+all*p;
		a= mod(y,m(i));
	end
end
