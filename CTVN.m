function [ idx, C ] = CTVN( X, k,threshold )
[~, C] = kmeans(X,k);


dt = delaunayTriangulation(C);
[V,R] = voronoiDiagram(dt);
%prevVoronoi(C);
marked = zeros(size(C,1),1);

[~, sortIndex] = sort(V(:,1));

subcluster_id = 0;
 
for i=1:size(V,1)-1
    ii = sortIndex(i);
    filteredCells = cellfun(@(x) find(x(:)==ii),R,'Un',0);
    nonEmptyIdx = find(~cellfun(@isempty,filteredCells));
    D = pdist([C(nonEmptyIdx(1),:);V(ii,:)],'euclidean');
    if(D < threshold)
        minSubcluster_id = 1e8;
        for j=1:size(nonEmptyIdx)
            siteIdx = nonEmptyIdx(j);
            if(marked(siteIdx)~=0)
                minSubcluster_id = min([minSubcluster_id, marked(siteIdx)]);
            end
        end
        if(minSubcluster_id == 1e8)
            subcluster_id = subcluster_id+1;
            minSubcluster_id = subcluster_id;
        end
        for j=1:size(nonEmptyIdx)
            siteIdx = nonEmptyIdx(j);
            marked(siteIdx) = minSubcluster_id;
        end
        
    end
end
seeds = zeros(subcluster_id,2);
for i=1:subcluster_id
    clusterData = C(marked == i,:);
    seeds(i,:) = mean(clusterData',2)';
end
['seeds size (' , int2str( size(seeds)),')']
[idx, C] = kmeans(X,[],'start',seeds);
%prevKmean(X,C,idx);
end

