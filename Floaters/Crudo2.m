curva=curva3;
cont=0;
figure
for kk=1:length(curva)
data=curva{kk};
cont=cont+1;
nData          = size(data,1); %# number of data points
numberOfDeltaT = floor(nData); %# for MSD, dt should be up to 1/4 of number of data points
msdt = zeros(numberOfDeltaT,3);
msd = zeros(numberOfDeltaT,3); %# We'll store [mean, std, n]
%# calculate msd for all deltaT's
for dt = 1:numberOfDeltaT
deltaCoords = data(1+dt:end,2:4) - data(1:end-dt,2:4);
squaredDisplacement = sum(deltaCoords.^2,2); %# dx^2+dy^2+dz^2
msd(dt,1) = mean(squaredDisplacement); %# average
msd(dt,2) = std(squaredDisplacement); %# std
msd(dt,3) = length(squaredDisplacement); %# n
end
t = curva{kk}(1:numberOfDeltaT,1)-curva{kk}(1,1);
loglog(t, msd(:,1))
hold on
end
grid on
xlabel({'Tiempo [s]'},'FontSize', 16)
ylabel({'Distancia Cuadrática Media [mm^2]'},'FontSize', 16)
set(gca,'fontsize',16)