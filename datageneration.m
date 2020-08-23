x = [ones(2000,1) dataset(:,1:2)];
lr = 0.1; % Learning Rate
w = [0 0 0]'; % Initial Weight
pocketW = w; % Initial weights in pocket;
X1 = -15:25;
epoch = 1;
acc = sum(dataset(:,3)'==((w'*x'>= 0)+(w'*x'>= 0)-1)); %Accuracy of
the machine at hand
accPocket(epoch) = acc;
%Accuracy of the machine in pocket
while(accPocket(epoch)~=2000)
 i=mod(epoch,size(dataset,1))+1;
 f = (w'*x(i,1:3)'>=0)+((w'*x(i,1:3)'>=0)-1);
 w = w + lr*(dataset(i,3) - f)*x(i,1:3)';
 acc = sum(dataset(:,3)'==((w'*x'>= 0)+(w'*x'>= 0)-1));
 if(acc > accPocket(epoch))
 pocketW = w;
 accPocket(epoch+1) = acc;
 else
 accPocket(epoch+1) = accPocket(epoch);
 end

 epoch=epoch+1;
 if(epoch==100000)
 break;
 end
end
finalW = pocketW;
plot(X1,(-finalW(1)/finalW(3))-(finalW(2)/finalW(3))*X1,'k-');
disp(fprintf('Solution reached in %d epochs', epoch));
disp(fprintf('%d point classified correctly',accPocket(end)));