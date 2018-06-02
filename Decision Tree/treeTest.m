function outCome = treeTest (DS, root)

[rows,cols]=size(DS);

outCome = ones(rows,1)*(-1);


for i=1:rows
    currentNode = root;
    while (isa(currentNode.left, 'treeNode') && isa(currentNode.right, 'treeNode'))
        if(DS(i,currentNode.value) == 0)
            currentNode = currentNode.left;
        else
            currentNode = currentNode.right;
        end
    end
    if (i==309)
        a =5;
    end
    outCome(i) = currentNode.value;
end
