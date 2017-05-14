
indCounter=0;
% Number of connections to pull
for n =2:10
indCounter=indCounter+1;
%repeat some number of times
for r =1:1000

connNums=randi(length(pooledNormIpsiOrnToP),[n,1]);

% CV of syns per conn
CV_Syns(r)=std(pooledNormIpsiOrnToP(connNums))/mean(pooledNormIpsiOrnToP(connNums));

% CV of syns per conn
CV_mMinis(r)=std(pooledNormIpsiMini(connNums))/mean(pooledNormIpsiMini(connNums));

% CV of syns per conn
CV_summEf(r)=std(pooledSumEff(connNums))/mean(pooledSumEff(connNums));

end

numMisleading(indCounter)=sum([sum(CV_Syns<=CV_summEf),sum(CV_Syns<CV_mMinis)]);

end