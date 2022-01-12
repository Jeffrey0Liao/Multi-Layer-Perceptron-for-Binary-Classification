function [] = build_animals()
% BUILD_DATASET  
% Please set the path to the local path
file_path = 'C:\Users\41713\Documents\MATLAB\FAI-cw2\animals';
img_list = dir(fullfile(file_path, '*.jpg'));

% Memory reallocation
X = double(zeros(25,3000));
y = double(ones(1,3000));

% Read in images 
for i=1:length(img_list)
    file_name = sprintf('%s/%s', file_path, img_list(i).name);
    
    if contains(file_name, 'cats')
        y(:, i) = 1;
    end
    if contains(file_name, 'dogs')
        y(:, i) = 2;
    end
    if contains(file_name, 'panda')
        y(:, i) = 3;
    end
    
    img = imread(file_name);
    % Image resize
    img = imresize(img, [5, 5]);
    % RGB images to grey scale images
    img = rgb2gray(img);
    % Reshape the matrix
    img_reshaped = reshape(img, 25, 1);
    X(:, i) = img_reshaped;
end

% normalization & standardlization ranging from [0, 1]
[m,n] = size(X);
xmax = max(X);
xmin = min(X);
X_ = double(zeros(25,3000));
for i = 1:m
    for j = 1:n
        X_(i, j) = (X(i, j)-xmin)*(1-0)/(xmax-xmin);
    end
end
X = X_;

% Index to vector (vectorization)
y = ind2vec(y);
save 'data.mat' X y;
end

