function result = reshape_sum_avg(r, s)
    result = zeros(1,32);
    for j=0:31
        start = j*8+1;  %start <= j & 001;   bitshift
        sum = 0;
        for i= start:start+3 %2 bit that use for all of it
            sum = int32(sum + r(i)*s(i));
        end
        result(j+1) = bitshift(sum, -2);
    end
end

function [delta_f,I] = fDAFreqOffset(r,s,nfft,dwnsamp,flag_Coarse)

    tmp1 = reshape_sum_avg(r, s);
    
    %using IPcore
    Pw1  = abs(fft(tmp1,nfft)).^2;

    %just change address for Pw
    Pw   = [Pw1(nfft/2+1:nfft),Pw1(1:nfft/2)]; % = fftshift(Pw1)

    % use constant value for Fw
    Fw   = -1/2:1/nfft:1/2-1/nfft; 
    
    
    [~, I] = max(Pw);
    
    % Index = 0; %!
    if I == 1 || I == length(Pw) , delta_f = 0; return;end
    % Y = Pw(I-1:I+1);
    
    
    if flag_Coarse
    
        delta_f = Fw(I)/dwnsamp ;  % Without Interpolation
    end

end

dwnsamp = 8;
x = randperm(511) - 256;
x = x(256:end);
y = x(1:256);
r = x;
s = y;
nfft = 64;
flag_Coarse = 1;

[delta_f, I] = fDAFreqOffset(r, s, nfft, dwnsamp, flag_Coarse)