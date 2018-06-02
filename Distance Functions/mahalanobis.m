function mdist = mahalanobis(point_1,point_2,covMat) % this function returns mahalanobis distance betwwen two points
mdist = sqrt((point_1-point_2)*inv(covMat)*(point_1-point_2)');
end