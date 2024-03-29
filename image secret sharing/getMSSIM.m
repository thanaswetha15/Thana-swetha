function mssim=getMSSIM(frameReference,frameUnderTest)

    C1 = 6.5025;
    C2 = 58.5225;
    frameReference=double(frameReference);
    frameUnderTest=double(frameUnderTest);
    frameReference_2=frameReference.^2;
    frameUnderTest_2=frameUnderTest.^2;
    frameReference_frameUnderTest=frameReference.*frameUnderTest;

    mu1=imgaussfilt(frameReference,1.5);
    mu2=imgaussfilt(frameUnderTest,1.5);
    mu1_2=mu1.^2;
    mu2_2=mu2.^2;
    mu1_mu2=mu1.*mu2;

    sigma1_2=imgaussfilt(frameReference_2,1.5);
    sigma1_2=sigma1_2-mu1_2;
    sigma2_2=imgaussfilt(frameUnderTest_2,1.5);
    sigma2_2=sigma2_2-mu2_2;
    sigma12=imgaussfilt(frameReference_frameUnderTest,1.5);
    sigma12=sigma12-mu1_mu2;

    
    t3 = ((2*mu1_mu2 + C1).*(2*sigma12 + C2));
    t1 =((mu1_2 + mu2_2 + C1).*(sigma1_2 + sigma2_2 + C2));
    ssim_map =  t3./t1;
    mssim = mean2(ssim_map); 
    mssim=mean(mssim(:));
return;


