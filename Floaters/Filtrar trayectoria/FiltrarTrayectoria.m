function [XYZf, UVWf, ABCf] = FiltrarTrayectoria(tXYZ,W)
if mod(W,2)==1,
    error('The second argument to the function must be an even integer.');
    return
end

L = size(tXYZ,1);
t = tXYZ(:,1);
x = tXYZ(:,2);
y = tXYZ(:,3);
z = tXYZ(:,4);

N = W/2;
dt = t(2)-t(1);
cidx = N;

% Allocating for results
XYZf = zeros(L,3);
UVWf = zeros(L,3);
ABCf = zeros(L,3);

% NaNs where we cannot get results
XYZf(1:cidx+N,:) = NaN;
UVWf(1:cidx+N,:) = NaN;
ABCf(1:cidx+N,:) = NaN;

unos = ones(2*N+1,1);

for ct=t(N+1):dt:t(L-2*(N+1)),
    cidx = cidx+1;
    
    
    vec1 = (t((N+1):((3*N)+1)));
    tvec = linspace(cidx,cidx+2*N,2*N+1);
    
    vec2 = vec1.^2;
    vec3 = vec1.^3;
    
    A  = [ unos vec1 vec2 vec3 ];
    
    invAtpA =inv(A.'*A);
    cx = (A.'*x(tvec)).'*invAtpA;
    cy = (A.'*y(tvec)).'*invAtpA;
    cz = (A.'*z(tvec)).'*invAtpA;

    xf = cx(1)+cx(2)*vec1((end+1)/2)+cx(3)*vec2((end+1)/2)+cx(4)*vec3((end+1)/2);
    yf = cy(1)+cy(2)*vec1((end+1)/2)+cy(3)*vec2((end+1)/2)+cy(4)*vec3((end+1)/2);
    zf = cz(1)+cz(2)*vec1((end+1)/2)+cz(3)*vec2((end+1)/2)+cz(4)*vec3((end+1)/2);

    uf = cx(2)+2*cx(3)*vec1((end+1)/2)+3*cx(4)*vec2((end+1)/2);
    vf = cy(2)+2*cy(3)*vec1((end+1)/2)+3*cy(4)*vec2((end+1)/2);
    wf = cz(2)+2*cz(3)*vec1((end+1)/2)+3*cz(4)*vec2((end+1)/2);

    af = 2*cx(3)+6*cx(4)*vec1((end+1)/2);
    bf = 2*cy(3)+6*cy(4)*vec1((end+1)/2);
    cf = 2*cz(3)+6*cz(4)*vec1((end+1)/2);
    
    XYZf(N+cidx,:) = [xf yf zf];
    UVWf(N+cidx,:) = [uf vf wf];
    ABCf(N+cidx,:) = [af bf cf];

end

% NaNs where we cannot get results
XYZf(cidx+1:L,:) = NaN;
UVWf(cidx+1:L,:) = NaN;
ABCf(cidx+1:L,:) = NaN;




