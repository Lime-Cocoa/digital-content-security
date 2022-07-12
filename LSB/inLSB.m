function pichide = inLSB(pichide,m,n)
    for i=1:m
        for j=1:n
            if mod(pichide(i,j),2)==1
                pichide(i,j)=255;
                %fprintf('1');
            else
                pichide(i,j)=0;
                %fprintf('0');
            end
        end
    end
end

