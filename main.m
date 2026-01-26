close all; clear 
addpath(genpath('.'));
DBDIR = './Dataset/';
i= 1;

% DataName{i} = 'dig1-10_uni'; i = i + 1;%iter75 0.01 10
% DataName{i} = 'S1500'; i = i + 1;%100 5 0.01 1e-5
% DataName{i} = 'jaffe'; i = i + 1;%100 10 0.1 1e+3
% DataName{i} = 'D50'; i = i + 1;%50 1000 1000
% DataName{i} = 'iris'; i = i + 1;% 100 10 1 1e-7
% DataName{i} = 'yeast_uni'; i = i + 1;%iter50 0.001 0.001
% DataName{i} = 'Isolet5'; i = i + 1;%100 6 48 迭代图
% DataName{i} = 'COIL20'; i = i + 1;% 50 1 50 10
% DataName{i} = 'COIL100'; i = i + 1;% 50 1 50 10
% DataName{i} = 'yaleB'; i = i + 1;% 50 1 50 10
DataName{i} = 'USPS'; i = i + 1;
% DataName{i} = 'BA'; i = i + 1;
% DataName{i} = 'imagenet000data'; i = i + 1;


dbNum = length(DataName);

maxIter =1;
bnorm = 1;
testLamda = 1;
lamda = [10 0.1 1e-5];
c=2;

%%%%%%%%%%%%%%%%%%%%%%result
acc = 0;
nmi = 0;
ARI = 0;
Fscore = 0;
Pu = 0;
Precision = 0;
Recall = 0;

%%%%%%%%%%%%%%%%%%%%%%
result1=zeros(1,8);
for dbIndex = 1:dbNum
   clear X gt 
   dbnamePre = DataName{dbIndex}; 
   dbfilename = sprintf('%s%s.mat',DBDIR,dbnamePre);
   load(dbfilename);
   
   la1 = [ 1e+4];   
   la2 = [1e+4];
   la3 = [10];
   if (testLamda == 1)
        for m = 1:length(la1)
            for i = 1:length(la2)
               for j=1:length(la3)
                    lamda(1) = la1(m);
                    lamda(2) = la2(i);
                    lamda(3) = la3(j);
                    k = length(unique(gt));
                    [acc, nmi, ARI, Fscore, Pu, Precision, Recall] = new(X, bnorm, gt, maxIter, lamda,k);
                    printResult(acc, nmi, ARI, Fscore, Pu, Precision, Recall, dbnamePre, lamda)
               end
            end
        end      
   else
       k = length(unique(gt));
        [acc, nmi, ARI, Fscore, Pu, Precision, Recall] = test(X, bnorm, gt, maxIter, lamda,k);             
        printResult(acc, nmi, ARI, Fscore, Pu, Precision, Recall, dbnamePre, lamda)
   end      
end
fprintf('\n complete... \n');


function printResult(acc, nmi, ARI, Fscore, Pu, Precision, Recall, dbnamePre, lamda)
    str = sprintf('[%s ][ACC %.2f] [NMI %.2f] [ARI %.2f] [F-score %.2f] [Purity %.2f] [Precision %.2f] [Recall %.2f][lamda1:%.3f lamda2:%.3f lamda3:%.3f]  %s ',...
            dbnamePre, acc * 100, nmi * 100, ARI * 100, Fscore * 100, Pu * 100, Precision * 100, Recall * 100,lamda(1), lamda(2),lamda(3));
    fprintf('%s\n',str);    
end