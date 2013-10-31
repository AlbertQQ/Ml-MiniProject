%Initial
clear
clc

% This script test the testingDigits with the trainingDigits
% And calulate the error rate of these classifications


% Get all the filenames under the trainingDigits path

trainFileDir = dir('./digits/trainingDigits/*.txt');

% Store all names in a list

trainLen = length(trainFileDir);   %Get the lengh of these files
% To store every file's label
digitLabels = zeros(1, trainLen);

trainFileList = cell(1,trainLen);

% Read the file names and store them

for i = 1:trainLen
    trainFileList{i} = trainFileDir(i).name;
end

%Store the trainning file's matrix information.
trainMat = zeros(trainLen,1024);

% Classify classes of numbers from the filenames
% And store theri matrix information

for i = 1:trainLen
    fileNameStrTrain = trainFileList{i};
    %Get filename without suffix
    fileNameTrain = regexp(fileNameStrTrain, '\.', 'split');
    fileNameTrain = fileNameTrain{1};          %  To string
    
    %Get the digit class
    classNumTrain = regexp(fileNameTrain, '_', 'split');
    classNumTrain = str2double(classNumTrain{1});    %To number
    
    %Store this file's label
    digitLabels(i) = classNumTrain;
    
    % Get the file's matrix information
    % Using function: image2vector which has been written.
    
    trainMat(i, :) = image2vector(strcat('./digits/trainingDigits/', fileNameStrTrain));
end

% Handle the testing files
testFileDir = dir('./digits/testDigits/*.txt');
testLen = length(testFileDir);

testFileList = cell(1, testLen);

for i = 1:testLen
    testFileList{i} = testFileDir(i).name;
end

%Count the errors
errorsCount = 0.0;

%Classifying!!!!

for i = 1:testLen   
    fileNameStrTest = testFileList{i};
    %Get filename without suffix
    fileNameTest = regexp(fileNameStrTest, '\.', 'split');
    fileNameTest = fileNameTest{1};          %  To string
    
    %Get the digit class
    classNumTest = regexp(fileNameTest, '_', 'split');
    classNumTest = str2double(classNumTest{1});    %To number
    
    % The under test vector
    vectorUnderTest = image2vector(strcat('./digits/testDigits/', fileNameStrTest));
    
    % Do knnClassifying !!!!!
    classifyResult = knnClassifier(vectorUnderTest, trainMat, digitLabels, 3);
    fprintf('The classify result is: %d, the actual number is: %d. \n', classifyResult, classNumTest);
    
    %Count errors
    if classifyResult ~= classNumTest
        errorsCount = errorsCount +1;
    end
end


fprintf('The total errors number is: %d\n', errorsCount);
fprintf('The error rate is: %f\n', (errorsCount / testLen));





























