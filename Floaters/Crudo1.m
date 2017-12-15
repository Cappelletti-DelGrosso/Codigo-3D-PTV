figure
for ii=1:243
disp = curva{ii}(:,:,:,:)-curva{ii}(1,:,:,:);
time = disp(:,1);
r2 = sum(disp(:,2:4).^2,2);
loglog(time, r2)
hold on
end