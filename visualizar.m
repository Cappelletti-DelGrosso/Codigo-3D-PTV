function [  ] = visualizar( H, Vi )

for jj=1:size(Vi,3)
     figure
    scatter(Vi(1,:,jj), Vi(2,:,jj), 'ro')
    for ii=1:size(Vi,2),
            hold on;
            if ii+1<size(Vi,2) && ii>2
                r =  min([norm(Vi(:,ii+1,jj)- Vi(:,ii,jj)), norm(Vi(:,ii,jj)- Vi(:,ii-1,jj))])/3;
            else
                r =  min([norm(Vi(:,2,jj)- Vi(:,1,jj)), norm(Vi(:,end,jj)- Vi(:,end-1,jj))])/3;
            end
            text(Vi(1,ii,jj)+r,Vi(2, ii,jj)+r,num2str(ii),'Color','blue','FontSize',14);
            text(Vi(1,ii,jj)-r*2,Vi(2, ii,jj)-r,['(',num2str(H(1,ii)),';',num2str(H(2,ii)),')'],'Color','green','FontSize',14);
            %pause
    end
end

end

