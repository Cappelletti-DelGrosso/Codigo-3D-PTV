
function [ vij ] = funcionvij(P,i,j)


vij=[P(i,1)*P(j,1),P(i,1)*P(j,2)+P(i,2)*P(j,1),P(i,2)*P(j,2), P(i,3)*P(j,1)+P(i,1)*P(j,3),P(i,3)*P(j,2)+P(i,2)*P(j,3),P(i,3)*P(j,3)]; 

%esto saca vij

end