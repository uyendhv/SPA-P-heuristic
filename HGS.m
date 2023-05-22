%==========================================================================
function [f_time,f_cost,f_stable,f_iter,f_reset] = HGS(lect_rank_list,lect_caps_list,proj_caps_list,stud_rank_list)
n = size(stud_rank_list,1);
m = size(lect_rank_list,1);
q = size(lect_rank_list,2);
M = zeros(2,n);
stud_rank_copy = stud_rank_list;
act = ones(1,n);
rec = zeros(1,n);
h = zeros(m,n);
f_reset = 0;
tic
iter = 0;
si = 0;
while(sum(act == 0) < n)
    iter = iter + 1;
    %find some student si is unassigned and si has a non-empty list
    cont = false;
    for j = 1:n
        si = mod(si,n) + 1;
        if (act(si) == 1)
            if(sum(stud_rank_list(si,:)) == 0)
                act(si) = 0;
                continue;
            end
            cont = true;
            break;
        end
    end
    if (cont == false)
        break;
    end
    mr = min(stud_rank_list(si,find(stud_rank_list(si,:))));
    pj = find(stud_rank_list(si,:) == mr,1,'first');
    lk = find(lect_rank_list(:,pj));
    M(1,si) = pj;
    M(2,si) = lk;
    h(lk,si) = lect_rank_list(lk,pj) + sum(stud_rank_list(si,:) > 0)/(q + 1);
    act(si) = 0;
    if (sum(M(1,:) == pj) > proj_caps_list(pj))
        stud = find(M(1,:) == pj);
        %
        h_max = max(h(lk,stud));
        sr = find(h(lk,:) == h_max,1,'first');
        %
        M(1,sr) = 0;
        M(2,sr) = 0;
        h(lk,sr) = 0;
        stud_rank_list(sr,pj) = 0;
        act(sr) = 1;
    end
    if (sum(M(2,:) == lk) > lect_caps_list(lk))
        [~,sr] = max(h(lk,:));
        M(1,sr) = 0;
        M(2,sr) = 0;
        h(lk,sr) = 0;
        stud_rank_list(sr,pj) = 0;
        act(sr) = 1;
    end
end
M;
f_time = toc;
f_iter = iter;
f_cost = size(find(M(1,:) == 0),2);
f_stable = 1;
%M
%verify the result matching
% verify_result_matching(lect_rank_list,lect_caps_list,proj_caps_list,stud_rank_copy,M);
end
%==========================================================================
