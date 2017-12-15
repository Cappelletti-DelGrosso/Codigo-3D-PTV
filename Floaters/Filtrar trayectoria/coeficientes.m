function [xf, uf, af]= coeficientes(x, t)
    w = length(x);
    unos = ones(w,1) ;
    vec1 = t ;
    vec2 = vec1.^2 ;
    vec3 = vec1.^3 ;
    
     A  = [ unos vec1 vec2 vec3 ];
     
%     invAtpA =inv(A.'*A);
%     cx = (A.'*x).'*invAtpA;
%     b/A para b*inv(A)
    cx = (A.'*x).'/ (A.'*A) ;
    
    xf = cx*[1,t((w+1)/2),t((w+1)/2)^2, t((w+1)/2)^3]';
    uf = cx*[0,1,2*t((w+1)/2), 3*t((w+1)/2)^2]';
    af = cx*[0,0,2, 6*t((w+1)/2)]';
end