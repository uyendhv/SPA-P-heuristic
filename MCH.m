%==========================================================================
% By Hoang Huu Viet
% MCH: Min-Conflicts Heuristic for SPA-P
%==========================================================================
function [f_time,f_cost,f_stable,f_iter,f_reset]= MCH(lect_rank_list,lect_caps_list,proj_caps_list,stud_rank_list,M)
%
n = size(stud_rank_list,1); %number of students
f = n;
%
%initialize the best matching
M_best = M;
f_best = f;
f_stable = 0;
f_reset = 0;
%
MAX_ITERS = 20000;
iter = 0;
tic
si = 1;%randi(n,1,1);
while (iter <= MAX_ITERS)
    iter = iter + 1;
    %if (rand() < 0.01)
    %   si = randi(n,1,1);
    %end
    %find a project pj making undominated blocking pair with si 
    %v = [];
    for j = 1:n
        si = mod(si,n) + 1;
        pj = find_undominated_students(lect_rank_list,lect_caps_list,proj_caps_list,stud_rank_list,si,M);
        %v = [v,si];
        if (pj ~= 0)
            break;
        end
    end
    %
    %fprintf('\niter = %d:',iter);
    %for k = 1:size(v,2)
    %    fprintf('%3d',v(k));
    %end
    %    
    %if there exists no pair (si,pj) then M is stable
    if (pj == 0)
        f_stable = 1;
        f = find_cost_of_matching(M);
        if (f_best > f)
            M_best = M;
            f_best = f;
            %break;
        end
        %if a perfect matching is found
        if (f_best == 0)
            break;
        else
            %perform a random restart
            f_reset = f_reset + 1;
            %M = Reject(stud_rank_list,M);
            M = make_random_matching(lect_rank_list,lect_caps_list,proj_caps_list,stud_rank_list);
            continue;
        end
    end
    %remove undominated blocking pair (si,pj) in M
    M(1,si) = pj;
    %find lecturer lk who offers pj
    lk = find(lect_rank_list(:,pj) > 0);
    M(2,si) = lk;
    %
    %check for over subscribed capacity of project pj 
    if (sum(M(1,:) == pj) > proj_caps_list(pj))
        %find the worst student sj assigned to pj
        sj = find_worst_student(stud_rank_list,pj,M);
        %sj becomes unassigned
        M(1,sj) = 0;
        %lk who offers sj becomes unassigned
        M(2,sj) = 0;
    end
    %check for over subscribed capacity of lecturer lk
    if (sum(M(2,:) == lk) > lect_caps_list(lk))
        %find lk's worst non-empty project pw
        pw = find_worst_project(lect_rank_list,lk,M);
        %find the worst student sj assigned to pw
        sj = find_worst_student(stud_rank_list,pw,M);
        %sj becomes unassigned
        M(1,sj) = 0;
        %lk who offers sj becomes unassigned
        M(2,sj) = 0;
    end
    %--------------------------------
    %{
    %check blocking pair
    fprintf('\n iter = %d\n',iter);
    q = size(lect_rank_list,2);
    for st = 1:size(M,2)
        for pt = 1:q
            %fprintf('(si,pj) = (%d,%d),',si,pj);
            if check_blocking_pair(lect_rank_list,lect_caps_list,proj_caps_list,stud_rank_list,st,pt,M) == true
                fprintf('(st,pt) = (%d,%d)\n',st,pt);
            end
        end
    end
    %}
end
f_time = toc;
f_cost = f_best;
f_iter = iter;
%
%M_best
%verify the result matching
%verify_result_matching(lect_rank_list,lect_caps_list,proj_caps_list,stud_rank_list,M_best);
end
%==========================================================================
%find undominated blocking pairs from student's point of view
%==========================================================================
function [pj] = find_undominated_students(lect_rank_list,lect_caps_list,proj_caps_list,stud_rank_list,si,M)
%pj: a project making an undominated blocking pairs in M from resident's point of view
%
q = size(proj_caps_list,2);
n = size(stud_rank_list,1);
%
pj = 0;
pi = M(1,si);
if (pi > 0)
    rank_si_pi = stud_rank_list(si,pi);
else
    rank_si_pi = n+1;
end
%find an undominated blocking pair (si,pj)
x = stud_rank_list(si,:);
[si_rank_list,projects] = sort(x); 
for k = 1:q
    rank_si_pk = si_rank_list(k);
    if (rank_si_pk > 0) && (rank_si_pk < rank_si_pi)
        pk = projects(k);
        if (check_blocking_pair(lect_rank_list,lect_caps_list,proj_caps_list,stud_rank_list,si,pk,M) == true)
            pj = pk;
            break;
        end
    end
end
end
%==========================================================================
function [M] = Reject(stud_rank_list,M)
students = find(M(1,:) == 0);
for i  = 1:size(students,2) 
    si = students(i);
    projects = find(stud_rank_list(si,:) > 0);
    for j = 1:size(projects,2)
        pj = projects(j);
        k = find(M(1,:) == pj);
        M(1,k) = 0;
        M(2,k) = 0;
    end
end
end
%==========================================================================
%find the cost of a matching M
%==========================================================================
function [f] = find_cost_of_matching(M)
%f: the number of singles in M
f = size(find(M(1,:) == 0),2);
end
%==========================================================================