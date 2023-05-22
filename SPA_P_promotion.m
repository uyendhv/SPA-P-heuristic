%==========================================================================
% By Hoang Huu Viet
% Ref: Kazuo Iwama, Improved approximation bounds for the SPA-P, 2012
%==========================================================================
function [f_time,f_cost,f_stable,f_iter,f_reset] = SPA_P_promotion(lect_rank_list,lect_caps_list,proj_caps_list,stud_rank_list)
n = size(stud_rank_list,1);
%
tic
[lect_pref_list,stud_pref_list] = convert_rank_to_pref(lect_rank_list,stud_rank_list);
%keep students' preference lists
X = stud_pref_list;
%
M = zeros(2,n);
iter = 0;
%let all students be unpromoted.
promoted = zeros(1,n);
while (true)
    iter = iter + 1;
    %find an unassigned student si such that si’s list is non-empty or si is unpromoted
    cont = false;
    idx =  find(M(1,:) == 0); 
    %check si’s preference list is non-empty
    for i = 1:size(idx,2)
        si = idx(i);       
        if (~isempty(find(stud_pref_list(si,:) > 0,1,'first'))) || (promoted(si) == 0)
            cont = true;
            break;
        end
    end
    if (cont == false)
        break;
    end
    %
    %check if si’s preference list is empty and si is unpromoted
    if (isempty(find(stud_pref_list(si,:) > 0,1,'first'))) && (promoted(si) == 0)
        %promote si
        promoted(si) = 1;
        %return to si's original preference list
        stud_pref_list(si,:) = X(si,:);
    end
    %pj is the first project on si’s preference list
    pj_rank = find(stud_pref_list(si,:)~=0,1,'first');
    pj = stud_pref_list(si,pj_rank);
    stud_pref_list(si,pj_rank) = 0;
    %lk is the lecturer who offers pj
    [lk,~] = find(lect_pref_list == pj);
    % 
    %si applies to pj
    pj_is_full = (sum(M(1,:) == pj) == proj_caps_list(pj));
    lk_is_full = (sum(M(2,:) == lk) == lect_caps_list(lk));
    pj_is_worst_project = (pj == find_worst_project(lect_rank_list,lk,M));
    %
    %A.(pj is full) or (lk is full and pj is lk’s worst non-empty project)        
    if (pj_is_full) || (lk_is_full && pj_is_worst_project)
        %find a set of unpromoted students in M(pj)
        idx =  find(M(1,:) == pj);
        unpromoted_students = [];
        for j = 1:size(idx,2)
            sj = idx(j); 
            if (promoted(sj) == 0) 
                unpromoted_students = [unpromoted_students,sj];
            end
        end
        %
        if (promoted(si) == 0) || (isempty(unpromoted_students))
            %reject si
            M(1,si) = 0;
            M(2,si) = 0;
        else
            %reject an arbitrary unpromoted student sj in M(pj) 
            r = randi([1,size(unpromoted_students,2)],1,1);
            sj = unpromoted_students(r);
            M(1,sj) = 0;
            M(2,sj) = 0;
            %add (si,pj) to M.
            M(1,si) = pj;
            M(2,si) = lk;
        end
    else
        %B.lk is full and prefers lk’s worst non-empty project to pj
        pz = find_worst_project(lect_rank_list,lk,M);
        if (lk_is_full) && (lect_rank_list(lk,pz) < lect_rank_list(lk,pj)) 
            %reject si
            M(1,si) = 0;
            M(2,si) = 0;
        else
            %C. otherwise, add (si, pj) to M
            M(1,si) = pj;
            M(2,si) = lk;
            %lk is over-subscribed
            lk_is_over_subscribed = (sum(M(2,:) == lk) > lect_caps_list(lk));
            if (lk_is_over_subscribed)
                %find a set of promoted/unpromoted students in M(pz)
                idx = find(M(1,:) == pz);
                arbitrary_students = [];
                unpromoted_students = [];
                for j = 1:size(idx,2)
                    sj = idx(j);                    
                    if (promoted(sj) == 0) 
                        unpromoted_students = [unpromoted_students,sj];
                    end
                    arbitrary_students = [arbitrary_students,sj];
                end
                %M(pz) contains an unpromoted student
                if (~isempty(unpromoted_students))
                    %reject an arbitrary unpromoted student sj in M(pz)
                    r = randi([1,size(unpromoted_students,2)],1,1);
                    sj = unpromoted_students(r);
                    M(1,sj) = 0;
                    M(2,sj) = 0;
                else
                    %reject an arbitrary student in M(pz)
                    r = randi([1,size(arbitrary_students,2)],1,1);
                    sj = arbitrary_students(r);
                    M(1,sj) = 0;
                    M(2,sj) = 0;
                end
            end
        end
    end
end
f_time = toc;
f_iter = iter;
f_cost = size(find(M(1,:) == 0),2);
f_stable = 1;
f_reset = 0;
%M
%verify the result matching
%verify_result_matching(lect_rank_list,lect_caps_list,proj_caps_list,stud_rank_list,M);
end
%==========================================================================

