for TH = 48:4:60
    
    
    ThresholdTest = 1;   
    image_secret=imread('Lena.bmp');
    image_secret=imresize(image_secret,[128,128]);
    imshow(image_secret);
    [rols,cols]=size(image_secret);
    SISMethodFlag=4; 
    Threshold = 2;
    ShareImgNum = 3;   
    CRTOurMethodFlag=3;
    w =[1,1]; 
    ScrambleFlag = 0;
    imshowFlag=0;
    imSaveFlag=1;  
    EncryptMethodFlag = 1;
    
    if SISMethodFlag==4
        
        k=Threshold;
        p=128;
        m=[251 253 255];
        n=length(m);% 
        if p==256
            CRTOurMethodFlag=2;
            k=n;
        end
        r=k;
        RecoveredNo = 1:r; 
        M=prod(m(1:r)); 
        Nr1 = prod(m(n-r+2:end));
        
        if CRTOurMethodFlag==3 
            T = round((floor(M/p-1))/2); 
            RanBigRange = (T+1):(floor(M/p-1));
            RanSmallRange = 0:(T-1); 
        end
        InvalidValue = m;
        P=m;
        Tsc = round(P/2); 
        AllRandom = 4*T;
    end
    
    if  ThresholdTest == 1
        TH1 = Tsc+TH;
        TH0 = Tsc-TH;
    end
    n=ShareImgNum;
    k=Threshold;
    r=k;
    SC = cell(1,n);
    C = SC;
    Flag = cell(n,2); 
    C{1} =imread('C.bmp');
    imshow(C{1});
    C{2} =imread('P.bmp');
    imshow(C{2});

    if ShareImgNum>=3
        C{3} =imread('M.bmp');
        imshow(C{3});

    end
    for i=1:n
        SC{i} = ones(rols,cols);
        Flag{i}{1} = (rand(rols,cols)<w(1));
        Flag{i}{2} = (rand(rols,cols)<w(2)); 
        C{i} = imresize(C{i},[rols,cols]);
       
         
    end
    image_secret=double(image_secret); 
    image_secret=uint8(image_secret);
    if imshowFlag ==1
        figure,imshow(uint8(image_secret));
    end
    if imSaveFlag ==1
        savefilepath1 = strcat('D:\work\SecretShare', '\\',num2str(k),num2str(n),num2str(TH), 'S ','.bmp');
        %fileID = fopen(savefilepath1);
        imwrite(image_secret, savefilepath1);
       
    end
    for i=1:rols
        for j=1:cols
            x=image_secret(i,j);
            iscc = [];
            c=zeros(1,n);
            
            for isc = 1:n
                c(isc) = C{isc}(i,j);
                if Flag{isc}{c(isc)+1}(i,j) ==1
                    iscc = isc;
                    
                end
            end
            if SISMethodFlag==4
                if x<p 
                    Aall = RanBigRange;
                elseif x>=p
                    Aall = RanSmallRange;
                end
                
                ind = randperm(length(Aall));   
                for iRandom = 1:length(Aall)
                   
                    
                    all= Aall(ind(iRandom));
                    [a] = CRTS(x,m,p,ShareImgNum,all);
                    if isempty(iscc)
                    else
                       Q = [1,3];
                       value1=qfunction(SC,TH1 ,TH0,c);
                       a(iscc)=value1;
                       TH1((iscc))=value1;
                       TH0((iscc))=value1;
                       if Q(a(iscc),TH1((iscc)),TH0((iscc))) == c(iscc)

                            break;
                       end
                    end
                end
            end
            for l =1:ShareImgNum 
                SC{l}(i,j) = a(l);
            end
            
        end
    end
    
    
    if imshowFlag ==1
        for i = 1:n   
            figure,imshow(uint8(SC{i}));
        end
    end
    if imSaveFlag ==1
        for i = 1:n   
            %savefilepath{i} = strcat('D:\\work\\SecretShare', '\\', num2str(k), num2str(n),num2str(TH),'SC', num2str(i), '.bmp');
            imwrite(uint8(SC{i}), savefilepath{i});
        end
    end
    






    nmin = n;
    nmax = n;
    kmin = 3;
    for n = nmin:nmax
        for r = kmin: n
            zh = combntns(1:n,r);
            sizezh = size(zh);
            sizezh = sizezh(1); 
            secret=[rols,cols];
            for pt = 1: sizezh 
                Jzh = zh(pt,:); 
                for i=1:rols
                    for j=1:cols
                        for l=1:n
                            a(l)=SC{l}(i,j);
                        end
                        if SISMethodFlag==4
                            
                            secret(i,j) = CRTRecovery(a(Jzh),m(Jzh));
                      
                        end
                    end
                end
                if imshowFlag ==1
                     for i = 1:n     
                        figure,imshow(uint8(secret));
                     end
                end
                if imSaveFlag ==1
                    savefilepath1 = strcat('DATA:\\work\\SecretShare', '\\',num2str(k),num2str(n),num2str(TH), 'SRec',num2str(Jzh), '.bmp');
                    imwrite(uint8(secret), savefilepath1); 
                end
            end
        end
    end
   
    sum(sum(double(secret-image_secret)))
    temp = 1;
    for i=1:n
        temp = temp * (TH0(i)/m(i) + (m(i)-TH1(i))/m(i))/2;
    end
    N_A = T*temp;
    
     for i=1:n
        Im_original = C{i}*255; 
        Im_modified = SC{i};
       
        gp=getpsnr(Im_original,Im_modified);
        print(gp);
        gm=getMSSIM(Im_original,Im_modified);
        print(gm);
       
    end
    
    
    
    savefilepath = strcat('DATA:\\work\\SecretShare', '\\', 'RISS', num2str(k), num2str(n),num2str(TH), 'data', '.mat');
    save(savefilepath);    

end





