function [counts,pairs] = neighbors(grains)
% returns the number of neighboring grains
%
% Input
%  grains - @grain2d
%
% Output
%  counts - number of neighbors per grain
%  pairs  - index list of size N x 2
%
% Description
% $$N = 2 \sum n_i $$
% is the total number of neighborhood relations (without self--reference).
%
% pairs(i,:) give the indexes of two neighboring grains, i.e
%
%  neighbor_gr = grains(pairs(1,:))
%
% selects two neighboring grains.
%

% extract grainIds for each boundary segment
gbid = grains.boundary.grainId;
gbid(any(gbid == 0,2),:) = [];

% sort columnwise
gbid = sort(gbid,2);

% get unique pairs
pairs = unique(gbid,'rows');

% check if neighboring grain id is in grainset
pairs(any(~ismember(pairs,grains.id),2),:)=[];

% get the number of neighbours per grain
ng = max(grains.id);
countIds = full(sparse(pairs(pairs<=ng),1,1,ng,1));

% rearange with respect to grain order
counts = countIds(grains.id);
