load('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\23-06-17\Floaters1\Vel, ac, salt.mat')
vx1=vx;
ax1=ax;
vy1=vy;
ay1=ay;
vz1=vz;
az1=az;
clear vx ax vy ay vz az saltos
load('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\23-06-17\Floaters2\Vel, ac, salt.mat')
vx2=vx;
ax2=ax;
vy2=vy;
ay2=ay;
vz2=vz;
az2=az;
clear vx ax vy ay vz az saltos
load('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\23-06-17\Floaters3\Vel, ac, salt.mat')
vx3=vx;
ax3=ax;
vy3=vy;
ay3=ay;
vz3=vz;
az3=az;
clear vx ax vy ay vz az saltos
load('C:\Users\Nicolás\Desktop\Labo 6\Mediciones\23-06-17\Floaters4\Vel, ac, salt.mat')
vx4=vx;
ax4=ax;
vy4=vy;
ay4=ay;
vz4=vz;
az4=az;
clear vx ax vy ay vz az saltos
vx=[vx1;vx2;vx3;vx4];
ax=[ax1;ax2;ax3;ax4];
vy=[vy1;vy2;vy3;vy4];
ay=[ay1;ay2;ay3;ay4];
vz=[vz1;vz2;vz3;vz4];
az=[az1;az2;az3;az4];
clearvars -except vx ax vy ay vz az