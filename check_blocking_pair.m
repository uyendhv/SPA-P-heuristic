function [f] = check_blocking_pair(lect_rank_list,lect_caps_list,proj_caps_list,stud_rank_list,si,pj,M)
% A (student,project) pair (si, pj) in (SxP)\M is a blocking pair of M, if 
%1. pj is in Ai (i.e. si finds pj acceptable).
%2. Either si is unassigned in M or si prefers pj to M(si).
%3. pj is under-subscribed and either
%  (3a) si is in M(lk) and lk prefers pj to M(si), or
%  (3b) si is not in M(lk) and lk is under-subscribed, or
%  (3c) si is not in M(lk) and lk is full and lk prefers pj to his worst non-empty project.
%  where lk is the lecturer who offers pj .
%==========================================================================
%1. pj is in Ai (i.e. si finds pj acceptable).
rank_si_pj = stud_rank_list(si,pj);
f1 = (rank_si_pj > 0);
%
%2. Either si is unassigned in M or si prefers pj to M(si).
pi = M(1,si);
if (pi >0)
    rank_si_pi = stud_rank_list(si,pi);
else
    rank_si_pi = 0;
end
f2 = (pi == 0)||(rank_si_pj < rank_si_pi);
%
%3. pj is under-subscribed
cj = proj_caps_list(pj);
f3 = (sum(M(1,:) == pj) < cj);
%
%find lecturer lk who offers pj
lk = find(lect_rank_list(:,pj) > 0);
%take pi's rank in lk's rank list
if (pi >0)
    rank_lk_pi = lect_rank_list(lk,pi);
else
    rank_lk_pi = 0;
end
%
%(3a) si is in M(lk) and lk prefers pj to M(si)
rank_lk_pj = lect_rank_list(lk,pj);
f3a = (rank_lk_pi > 0) && (rank_lk_pj < rank_lk_pi);
%
%(3b) si is not in M(lk) and lk is under-subscribed
dk = lect_caps_list(lk);
f3b = (rank_lk_pi == 0) && (sum(M(2,:) == lk) < dk);
% 
%(3c) si is not in M(lk) and lk is full and lk prefers pj to his worst non-empty project.
%find lk's worst non-empty project pw
pw = find_worst_project(lect_rank_list,lk,M);
rank_lk_pw = lect_rank_list(lk,pw);
f3c = (rank_lk_pi == 0) && (sum(M(2,:) == lk) == dk) && (rank_lk_pj < rank_lk_pw);
%
%return the blocking pair 
f = f1 && f2 && f3 && (f3a || f3b || f3c);
end
%==========================================================================