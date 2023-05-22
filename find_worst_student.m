function [sj] = find_worst_student(stud_rank_list,pj,M)
%find the worst student sj assigned to pj in M
students = find(M(1,:) == pj);
si_rank_list = stud_rank_list(students',pj);
[~,idx] = max(si_rank_list);
sj = students(idx);
end
%==========================================================================