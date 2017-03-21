% Εισαγωγή πινάκων με τις προσφορές πωλητών και αγοραστών 
sell = xlsread('seller.xlsx');
buy = xlsread('buyer.xlsx');

% Ταξινόμηση των προσφορών
A=sortrows(sell,2);
B=sortrows(buy,-2);


 x1=cumsum(A(:,1));
 y1=A(:,2);
 x2=cumsum(B(:,1));
 y2=B(:,2);
  
 x1=[0 ; x1 ];
 d=size( y1, 1 );
 y1=[y1 ; y1(d) ];
 x2=[0 ; x2 ];
 s=size( y2, 1 );
 y2=[y2 ; y2(s) ];
  
    % Σχεδιασμός καμπυλών προσφοράς και ζήτησης
    stairs([x1,x2],[y1,y2]);
    grid on;
    xlabel('MWh')     
    ylabel('Euro/MWh')
    axis([0 200 0  80]);
   
    
    % Σημείο τομής καμπυλών 
    [x3,y3] = stairs(x1,y1);
    [x4,y4] = stairs(x2,y2);
    [x0,y0] = intersections(x3,y3,x4,y4);
    
     M=[x0,y0];
     
     % Επιλογή σημείου για κάθε πιθανή ένωση των καμπυλών
     w=size(M, 1);
     if w>1
         if M(1,1)~= M(w,1)
            x0= M(w,1);
            y0=M(1,w);
         else
           x0= M(w,1);
           y0=  (M(1,2)+M(1,w))/2;
         end
    end

 
   fprintf('Clearing point: \n Energy = %1.2f MWh     Price = %1.2f Euro/MWh', x0,y0);