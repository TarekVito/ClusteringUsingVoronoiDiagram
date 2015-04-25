function prevVoronoi(X)
[VX,VY] = voronoi(X(:,1),X(:,2));
h = plot(VX,VY,'-b',X(:,1),X(:,2),'.r');

% Assign labels to the points X.
nump = size(X,1);
plabels = arrayfun(@(n) {sprintf('X%d', n)}, (1:nump)');
hold on
Hpl = text(X(:,1), X(:,2), plabels, 'color', 'r', ...
      'FontWeight', 'bold', 'HorizontalAlignment',...
      'center', 'BackgroundColor', 'none');

% Compute the Voronoi diagram.
dt = delaunayTriangulation(X);
[V,R] = voronoiDiagram(dt);


% Assign labels to the Voronoi vertices V.
% By convention the first vertex is at infinity.
numv = size(V,1);
vlabels = arrayfun(@(n) {sprintf('V%d', n)}, (2:numv)');
hold on
Hpl = text(V(2:end,1), V(2:end,2), vlabels, ...
      'FontWeight', 'bold', 'HorizontalAlignment',...
      'center', 'BackgroundColor', 'none');
hold off
end