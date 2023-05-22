function [pj] = find_worst_project(lect_rank_list,lk,M)
%find the worst project pj assigned to lk in M
students = find(M(2,:) == lk);
projects = M(1,students);
lk_rank_list = lect_rank_list(lk,projects);
[~,idx] = max(lk_rank_list);
sj = students(idx);
pj = M(1,sj);
end
%==========================================================================