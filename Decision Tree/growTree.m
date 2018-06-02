function node = growTree(parent, DS, visited)

[~,cols]=size(DS);

if ~exist('visited','var')
    visited = zeros(1,cols-1);
end

gains = zeros(cols-1,1);
stop = zeros(cols-1,1);


if ~isempty(DS) & find(visited==0)
    for i=1:cols-1
        if visited(i)==0 %0 = not visited
            [one, two] = Entropy(DS, i);
            gains(i) = one;
            stop(i) = two;
        else
            gains(i)=0;
        end
    end
end

current = find(gains==max(gains));
current = current(1);
node = treeNode;
node.value = current;

visited(current) = 1;


if (stop(current) == 0) % grow tree in both ways
    if find(visited == 0)
        node.left = growTree(node, DS(DS(:,current)==0,:), visited);
        node.right = growTree(node, DS(DS(:,current)==1,:), visited);
    else 
        node.left = treeNode();
        node.right = treeNode();
        node.left.value = mode(DS(DS(:,current)==0,cols));
        node.right.value = mode(DS(DS(:,current)==1,cols));
    end
end

if (stop(current) == 1) % grow tree only in right branch
    node.left = treeNode();
    node.left.value = mode(DS(DS(:,current)==0,cols));
    if find(visited == 0)
        node.right = growTree(node, DS(DS(:,current)==1,:), visited);
    else 
        node.right = treeNode();
        node.right.value = mode(DS(DS(:,current)==1,cols));
    end
end

if (stop(current) == 2) % grow tree only in left branch
    node.right = treeNode();
    node.right.value = mode(DS(DS(:,current)==1,cols));
    if find(visited == 0)
        node.left = growTree(node, DS(DS(:,current)==0,:), visited);
    else 
        node.left = treeNode();
        node.left.value = mode(DS(DS(:,current)==0,cols));
    end
end

if (stop(current) == 3) % stop growing the tree
    node.right = treeNode();
    node.left = treeNode();
    node.right.value = mode(DS(DS(:,current)==1,cols));
    node.left.value = mode(DS(DS(:,current)==0,cols));
end











