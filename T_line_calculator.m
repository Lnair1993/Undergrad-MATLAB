m = 1;
while m==1

choice = menu('CHOOSE TYPE OF PLANAR TRANSMISSION LINE','MICROSTRIP','COUPLED STRIPLINE','COPLANAR STRIPS');
switch (choice)

    case 1 %MICROSTRIP
        
%Taking input values from the user
R = input('Enter L for low impedance or H for high impedance ', 's');
E = input('Enter dielectric constant value: ');
Z = input('Enter characteristic impedance value: ');

%Calculation of width for low and high impedance cases
if(R == 'H')    
A = (Z/60)*((E+1)/2)^0.5 + ((E-1)/(E+1))*(0.23 + 0.11/E);
X = abs((8*exp(-A)/(exp(-2*A)-1)));
end
if(R == 'L')
B = (60*(pi)^2)./(Z*E);
X = abs(2*((B-1)-log(2*B-1)) + ((E-1)/(2*E))*(log(B-1) + 0.39 - 0.61/E));
end

W = X*0.15625; %h = 0.15625 ; 1/16th of an inch

%Displaying the output
display('The required width for microstrip in cm is: ');
display(W);
axis equal;
rectangle ('Position',[0,0,3*W,0.15625*0.1],'facecolor',[0 1 1]);
rectangle ('Position',[W,0.15625+0.15625*0.1,W,0.1*0.15625],'facecolor',[1 1 0]);
rectangle ('Position',[0,0.15625*0.1,3*W,0.15625],'facecolor',[0 1 0]);


    case 2 %COUPLED STRIPLINE
        
%Taking inputs from user        
Z0 = input('Enter characteristic impedance value: ');
E0 = input('Enter dielectric constant of the substrate: ');
H = input('Enter required height of substrate in cm: ');
type = input('Edge coupled (1) or broadside coupled lines (2)?: ');
C0 = 0.2;

%Calculation of S and W
X = abs((log(coth((94.15*pi*C0)/(sqrt(E0)*Z0*sqrt(1-C0^2)))))/pi);
A = (-188.3*pi*C0)/(sqrt(E0)*Z0*sqrt(1-C0^2));
Y = abs((94.15/(sqrt(E0)*Z0))*(sqrt((1-C0)/(1+C0)))-(log(2*(1+exp(A))))/pi);

%Display output
display('Required separation between strips: ');
display(X*H);
display('Required width of strip: ');
display(Y*H);
axis equal;
x=X*H;
y=Y*H;
z=H/2-y*0.01-x/2;
if(type==1)
rectangle ('Position',[0,H/2,y,y*0.1],'facecolor',[0 1 1]);
rectangle ('Position',[y+x,H/2,y,y*0.1],'facecolor',[0 1 1]);
rectangle ('Position',[0,0,2*y+x,y*0.01],'facecolor',[0 1 0]);
rectangle ('Position',[0,H,2*y+x,y*0.01],'facecolor',[0 1 1]);

end
if(type==2)
rectangle ('Position',[0,z,(Y*H),y*0.1],'facecolor',[0 1 1]);
rectangle ('Position',[0,z+x,(Y*H),y*0.1],'facecolor',[0 1 1]);
rectangle ('Position',[0,0,y,y*0.01],'facecolor',[0 1 0]);
rectangle ('Position',[0,H,y,y*0.01],'facecolor',[0 1 1]);

end

    case 3 %COPLANAR STRIPLINE
        
%Taking inputs from user        
Z = input('Enter characteristic impedance value: ');
e = input('Enter dielectric constant of the substrate: ');
H = input('Enter required height of substrate in mm: ');
S = input('Enter required strip width: ');     

%Calculations
E1=(e+1)/2;
t=(60*sqrt(2)*pi)/(sqrt(e+1));
     if(Z<=t)
     P= (0.125*exp  (  (60*pi*pi) /(Z*sqrt(E1))  ))-0.5;
     G=1/P   ;
     end
     if(Z>t)
     G=    0.25*exp( Z*sqrt(E1) /120)  +  exp( -1* ( Z*sqrt(E1)/120 ) )-1;    
     end
Q=G;     
l=  exp(  (pi*(1+Q)*S)/(2*H)  )   -exp(   (pi*S)/(2*H)  );
geg=l/(    exp(  (pi*(2+Q)*S)/(2*H)   )  -1);
g=sqrt(geg);
t1=1+ tanh(         (Z*Z*(e^7)*exp(  (1+0.0004*e*Z*S/H)*log(S/H)  )    )/(720*pi*pi*pi*((1+e)^8))    );   
     if(0<=g  && g<=0.841)
     temp=log(  2*(1+   ( (1- g*g*g*g)^0.25) )/(1-   ( (1- g*g*g*g)^0.25) ));
     t2=837.5/temp;
     end
     if(g>0.841 && g<=1)
     t2=84.85*log(  (2*(1+g))/(1-g)   );
     end
E=t1*(1+((e-1)/(Z*sqrt(e+1)))*t2);
     if(Z<=t)
     P= (0.125*exp  (  (60*pi*pi) /(Z*sqrt(E))  ))-0.5;
     G=1/P   ;
     end
     if(Z>t)
     G=  0.25*exp( Z*sqrt(E) )/120  +  exp( -1* ( Z*sqrt(E)/120 ) )-1; 
     end
  
     W=S*G;
 
 %Displaying the output    
 display('Required strip width is = ');
 display(S);
 display('Required slot width is = ');
 display(W);
 axis equal;
 rectangle ('Position',[0,0,3*W+2*S,H],'facecolor',[0 0 1]);
 rectangle ('Position',[W,H,S,H*0.1],'facecolor',[1 0 0]);
 rectangle ('Position',[2*W+S,H,S,H*0.1],'facecolor',[1 0 0]);
 
end

m = menu('Would you like to repeat calculation?','Yes','No');

end