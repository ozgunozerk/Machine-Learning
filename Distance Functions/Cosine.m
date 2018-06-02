function res = Cosine(point_1,point_2) %This function returns the cosine distance between two points
mod_point_1=norm(point_1);               
mod_point_2=norm(point_2);

num=point_1*point_2'; %The scalar product of two vectors
den=mod_point_1*mod_point_2;
cos_similarity=num/den; % calculating the cosine similarity


res=1-cos_similarity; %calculating the cosine distance

end