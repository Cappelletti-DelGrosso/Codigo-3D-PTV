function [msd,t]=MSD(curva, v, u)

cont=0;
largos = cellfun(@(x) size(x,1), curva);
M = max(largos);
squaredDisplacement=cell(1,M-1);
for kk=1:length(curva)
    
        data=curva{kk};
        nData          = length(data); %# number of data points
        numberOfDeltaT = nData-1;
        cont=cont+1;
       
        
        for dt = 1:numberOfDeltaT
           deltaCoords = data(1+dt:end,v:u) - data(1:end-dt,v:u);
           squaredDisplacement{dt} = [squaredDisplacement{dt}; sum(deltaCoords.^2,2)]; %# dx^2+dy^2+dz^2
        end
            
end
L=length(squaredDisplacement);
t = (curva{1}(2,1)-curva{1}(1,1))*(1:L);
for dt=1:L
    msd(dt,1) = mean(squaredDisplacement{dt}); %# average
    msd(dt,2) = std(squaredDisplacement{dt}); %# std
    msd(dt,3) = length(squaredDisplacement{dt}); %# n
end
end