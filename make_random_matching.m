function [M] = make_random_matching(lect_rank_list,lect_caps_list,proj_caps_list,stud_rank_list)
%create a random matching M in which r and h find each other acceptable
%
%number of students
n = size(stud_rank_list,1);
%
iter = 0;
while (true)
    iter = iter + 1;
    %initialize M, where M(1,:) are projects, M(2,:) are lecturers
    M = zeros(2,n);
    %make random students
    X = rand(1,n);
    [~,students] = sort(X);
    %assign projects and lecturers to students
    for i = 1:size(students,2)
        si = students(i);
        proj = find(stud_rank_list(si,:) > 0);
        %find a random project pj ranked by student si
        idx  = randi(size(proj,2),1,1);
        pj = proj(idx);
        cj = proj_caps_list(pj);
        %find lecturer lk who offer project pj 
        lk = find(lect_rank_list(:,pj) > 0);
        dk = lect_caps_list(lk);
        %check project capacity
        if (sum(M(1,:) == pj) < cj) && (sum(M(2,:) == lk) < dk)
            M(1,si) = pj;   
            M(2,si) = lk;   
        end
    end
    %
    %the following codes is not necessary!
    %check again capacity |M(pj)| > proj_caps_list(pj)
    over_subscribed = false;
    x = unique(M(1,:));
    for i = 1:size(x,2)
        pj = x(i);
        if (pj >0)
            cj = proj_caps_list(pj);
            %check cj in proj_caps_list
            if (sum(M(1,:) == pj) > cj)
                over_subscribed = true;
                break;
            end
        end
    end
    %
    %check again capacity |M(lk)| > lect_caps_list(lk)
    y = unique(M(2,:));
    for i = 1:size(y,2)
        lk = y(i);
        if (lk > 0)    
            dk = lect_caps_list(lk);
            %check dk in lect_caps_list
            if (sum(M(2,:) == lk) > dk)
                over_subscribed = true;
                break;
            end
        end
    end
    %if capacities are under-subscribed or full then ok
    if (over_subscribed == false)
        break;
    end
    iter = iter + 1;
    if (iter > 10)
        fprintf('\n we cannot make a random maching!!!');
        break;
    end
end
end
%==========================================================================