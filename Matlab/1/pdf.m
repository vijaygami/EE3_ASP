
function pdf(x, bins);
% plots the aproximate PDF of input data in either two forms.
% set sw=0 to plot area normalised histogram
% set sw=1 to plot line graph aproximating PDF.

sw=1; %switch for the two aformentioned options of plotting sytles


[c,x] = hist(x, bins);
area=sum(c)*(x(1,2)-x(1,1));    %area of histogram

if sw ==0; %histogram plot
    plot(x,c/(area));           %divide by area to normalise histogram to aproximate PDF

    title('Area normalised histogram aproximating PDF')
    xlabel('x')
    ylabel('PDF estimate (normalised count)')
end




if sw ==1; %line graph plot
    
    s=length(x);                    %length of x
    sm=(x(1,2)-x(1,1))/2;           %small constant used to set plot to zero either side of pdf
    
    plot([x(1,1)-sm,  x, x(1,s)+sm]  ,  [0 , c/(area), 0], 'LineWidth', 2 ); 

    title('Aproximate PDF')
    xlabel('x')
    ylabel('PDF estimate')
end


end
