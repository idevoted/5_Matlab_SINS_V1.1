mStartT = 26080; mEndT = 26111;
CutData = DataPrepare_IMUData_TimeAlignmentUTC_Cut(LUWB,200,mStartT,mEndT);

figure;
plot(LUWB(68590:74738,1)+LUWB(68590:74738,2)/1000,LUWB(68590:74738,3));
hold on;
plot(CutData(:,1),CutData(:,2),'r');



mData = zeros(10000,3);
mData(1:10000,1) = LUWB(1:10000,1)+LUWB(1:10000,2)/1000;
mData(1:10000,2:3) = LUWB(1:10000,3:4);

L = length(mData);
Test = zeros(L,1);
for i=1:L-1
    Test(i,1) = mData(i+1,1)-mData(i,1);
end

NewData = DataPrepare_IMUData_LoseCheck_And_Insert(mData,200);

NewIMU(:,1) = fix(NewIMU(:,1)*1000)/1000;

L = length(NewUWB);
TestNew = zeros(L,1);
for i=1:L-1
    TestNew(i,1) = NewUWB(i+1,1)-NewUWB(i,1);
end
figure;
plot(mData(:,1),Test(:,1));
hold on;plot(NewData(:,1),TestNew(:,1),'r');


NewData = DataPrepare_IMUData_TimeAlignmentUTC_SecondAlign(mData,Hz);

test(:,1) = mData(:,1)+mData(:,2)/1000;
test(:,2:3) = mData(:,3:4);


    InsertData = DataPrepare_IMUData_LoseCheck_And_Insert(mData(1:192,:),200);
    
    
L = length(InsertData);
TestInsert= zeros(L,1);
for i=1:L-1
    TestInsert(i,1) = InsertData(i+1,1)-InsertData(i,1);
end
    
    InsertData = [InsertData;mData(193,:)];
    %5.补数后，加上当前段的最后一点(有效时间)，进行时间对齐的插值
    %(在两个有效时间之间，进行时间对齐，包含第一个点，但不包含最后一个点，以防重复) 
    NewTimeData = DataPrepare_IMUData_TimeAlignmentUTC_SecondAlign(InsertData,200);
figure;
plot(TempData(:,1),TempData(:,2));
hold on; plot(NewData(:,1),NewData(:,2),'r');
    

figure;
plot(mData(:,1),mData(:,2));
hold on; plot(NewData(:,1),NewData(:,2),'r');



NewIMU = DataPrepare_IMUData_TimeAlignmentUTC_Cut(IMU,200,26203,27318);

NewUWB = DataPrepare_IMUData_TimeAlignmentUTC_Cut(UWB,200,26203,27318);


for i=2:7
    figure;
    plot(IMU(5031:228236,1)+IMU(5031:228236,2)./1000.0,IMU(5031:228236,i+1));
    hold on;
    plot(NewIMU(:,1),NewIMU(:,i),'r');
end


for i=2
    figure;
    plot(UWB(5031:219000,1)+UWB(5031:219000,2)./1000.0,UWB(5031:219000,i+1));
    hold on;
    plot(NewUWB(:,1),NewUWB(:,i),'r');
end
