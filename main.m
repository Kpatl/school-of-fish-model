%intialization of variables
directX=300;
directY=300;
sea=zeros(300,300);
sea2=zeros(300,300);
dist1=0;
dist2=0;
fishXS=zeros(1,50);
fisYS=zeros(1,50);
nextX=1;
nextY=1;

%Initializing the model, and also setting initial average values
for i=1:50
   x=round(199.*rand(1))+1;
   y=round(199.*rand(1))+1;
   if(~(sea(x,y)==1)) 
       sea(x,y)=1;
       fishXS(nextX)=x;
       fishYS(nextY)=y;
       nextX=nextX+1;
       nextY=nextY+1;
   end
end

aveX=round(mean(fishXS));
aveY=round(mean(fishYS));

%the model, for loops loop through all elements of 2D array and allow each
%"fish" to operate
for t=1:500
    for i=1:300
        for j=1:300
            if(sea(i,j)==1) %ensures that a fish is located in this element
                if(((directX<i&&aveX>i)||(directX>i&&aveX<i))&&((directY<i&&aveY>j)||(directY>i&&aveY<j)))
                    %case one, the fish lie close the the line between the
                    %"center" of the school, the fish moves toward the
                    %direction point
                    if(sea2((i+round((directX-i)/10)),j+round((directY-j)/10))==0&&sea(i+round((directX-i)/10),j+round((directY-j)/10))==0)
                            sea2((i+round((directX-i)/10)),j+round((directY-j)/10))=1;
                        else
                            sea2(i,j)=1;
                        end
                elseif((directX<i&&aveX>i)||(directX>i&&aveX<i)||(directY<i&&aveY>j)||(directY>i&&aveY<j))
                    %case 2, the fish will move toward the line between the
                    %school's "center" and the direction point via a
                    %perpendicular line
                    dy=directY-aveY;
                    dx=directX-aveX;
                    d1=sqrt(((i+dy)-aveX)^2+((j-dx)-aveY)^2);
                    d2=sqrt(((i-dy)-aveX)^2+((j+dx)-aveY)^2);
                    if(d1>d2)
                        dy=-1*dy;
                        if(sea2(i+round(dy/10),j+round(dx/10))==0&&sea(i+round(dy/10),j+round(dx/10))==0)
                            sea2(i+round(dy/10),j+round(dx/10))=1;
                        else
                            sea2(i,j)=1;
                        end   
                    else  
                        dx=-1*dx;
                        if(sea2(i+round(dy/10),j+round(dx/10))==0&&sea(i+round(dy/10),j+round(dx/10))==0)
                            sea2(i+round(dy/10),j+round(dx/10))=1;
                        else
                            sea2(i,j)=1;
                        end
                    end
                else
                    %final case, the fish will move toward the closest
                    %point, either direction or average, unless it is close
                    %to the center of the school, then it will move toward
                    %the direction, not nessesarily the closest point
                    dist1=sqrt((i-aveX)^2+(j-aveY)^2);
                    dist2=sqrt((i-directX)^2+(j-directY)^2);
                    if(dist1>dist2)
                        if(sea2((i+round((directX-i)/10)),j+round((directY-j)/10))==0&&sea(i+round((directX-i)/10),j+round((directY-j)/10))==0)
                            sea2((i+round((directX-i)/10)),j+round((directY-j)/10))=1;
                        else
                            sea2(i,j)=1;
                        end
                    elseif(dist1<20) 
                        if(sea2((i+round((directX-i)/2)),j+round((directY-j)/2))==0&&sea(i+round((directX-i)/2),j+round((directY-j)/2))==0)
                            sea2((i+round((directX-i)/2)),j+round((directY-j)/2))=1;
                        else
                            sea2(i,j)=1;
                        end
                    elseif(abs(abs((directY-j)/(directX-i))-abs((aveY-j)/(aveX-i)))<=1.1)
                        if(sea2((i+round((directX-i)/2)),j+round((directY-j)/2))==0&&sea(i+round((directX-i)/2),j+round((directY-j)/2))==0)
                            sea2((i+round((directX-i)/2)),j+round((directY-j)/2))=1;
                        else
                            sea2(i,j)=1;
                        end
                    else
                        if(sea2((i+round((aveX-i)/2)),j+round((aveY-j)/2))==0&&sea(i+round((aveX-i)/2),j+round((aveY-j)/2))==0)
                            sea2((i+round((aveX-i)/2)),j+round((aveY-j)/2))=1;
                        else
                            sea2(i,j)=1;
                        end
                    end   
                end  
            end
        end
    end
   imagesc(sea, [0,1]) %the plotting of the model
   drawnow 
   nextX=1;
   nextY=1;
   %resetting of average values
   for b=1:300
       for c=1:300
           if(sea2(b,c)==1)
               fishXS(nextX)=b;
               fishYS(nextY)=c;
               nextX=nextX+1;
               nextY=nextY+1;
           end
       end
   end
   aveX=round(mean(fishXS));
   aveY=round(mean(fishYS));
   %resetting to allow for the next iteration
   sea=sea2;
   sea2=zeros(300,300);
   pause(0.5); %this allows observation of the bevavior
end

                        
                            
                            
                    
                            
                
                
        




