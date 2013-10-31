%TODO: using training data to predict a new vector's label
%This is a common classifier
%It supports n-dimension with two labels.
function predictLabel = knnClassifier(underTestVector, data, labels, k)

%Get trainingdata's size
dataSize = size(data, 1);

%get the diffMat to store the difference of underTestVector and exist data
diffMat = repmat(underTestVector, dataSize, 1) - data;

%Get the square of every diffMat. e.g.[x11^2, x22^2,...x1n^2]..
squareDiffMat = diffMat .^ 2;

%Get the square of distances.  e.g  [x11^2 + x12^2 +...+x1n^2]...
squareDistances = transpose(sum(transpose(squareDiffMat)));

%Store the distances of matrixes

distancesMat = sqrt(squareDistances);

%Sort the distances and get its index
[~,sortedDistancesIndex] = sortrows(distancesMat);

%Store the k smallest distances' labels
storeLabels = zeros(1,k);
for i = 1:k
    storeLabels(i) = labels(sortedDistancesIndex(i));    
end

%Find the most labels in storeLabels

uniTable = unique(storeLabels);

numTable = histc(storeLabels,uniTable);
[~,idx] = max(numTable);

%Get the classified label
predictLabel = uniTable(idx);

end   %end of the function