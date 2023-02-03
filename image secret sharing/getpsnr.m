function psnr_Value = getpsnr(A,B)
% PSNR (Peak Signal to noise ratio

  
    mseImage = (double(A) - double(B)) .^ 2;
    [rows,columns] = size(A);
    
    mse = sum(mseImage(:)) / (rows * columns);

   
    psnr_Value = 10 * log10( 256^2 / mse);

