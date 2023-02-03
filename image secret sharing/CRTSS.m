
function [a]=CRTSS(x,m,p,ShareImgNum,Aall(ind(iRandom)))
a=[];
for i=1:ShareImgNum
	if x<p 
		y = x + Aall*p;
		a[i]=y;%m[i];
	else
		y=x-p + Aall*p;
		a(i)=y;%m[i];
	end
end