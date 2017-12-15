Lvx=length(vx);
Lax=length(ax);
[PDFVX, VX]=hist(vx, sqrt(Lvx));
[PDFAX, AX]=hist(ax, sqrt(Lax));
PDFVX=PDFVX/Lvx;
PDFAX=PDFAX/Lax;
figure(1); semilogy(VX, PDFVX); hold on
title('PDF Velocidad X')
figure(2); semilogy(AX, PDFAX); hold on
title('PDF Aceleración X')

Lvy=length(vy);
Lay=length(ay);
[PDFVY, VY]=hist(vy, sqrt(Lvy));
[PDFAY, AY]=hist(ay, sqrt(Lay));
PDFVY=PDFVY/Lvy;
PDFAY=PDFAY/Lay;
figure(3); semilogy(VY, PDFVY); hold on
title('PDF Velocidad Y')
figure(4); semilogy(AY, PDFAY); hold on
title('PDF Aceleración Y')

Lvz=length(vz);
Laz=length(az);
[PDFVZ, VZ]=hist(vz, sqrt(Lvz));
[PDFAZ, AZ]=hist(az, sqrt(Laz));
PDFVZ=PDFVZ/Lvz;
PDFAZ=PDFAZ/Laz;
figure(5); semilogy(VZ, PDFVZ); hold on
title('PDF Velocidad Z')
figure(6); semilogy(AZ, PDFAZ); hold on
title('PDF Aceleración Z')

[sum(PDFVX),sum(PDFAX),sum(PDFVY),sum(PDFAY),sum(PDFVZ),sum(PDFAZ)]