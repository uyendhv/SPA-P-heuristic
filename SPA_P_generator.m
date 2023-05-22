%======================================================================================
%by Hoang Huu Viet
%ref. D.F.Manlove et al.: Student-Project Allocation with Preferences over Projects
%========================================================================================
clc
clear vars
close all
% folder = 'inputs5';
%number of students
%  n = 200;
% for m = 5:5:50
for n = 1000:1000:10000
    instances = [];
    %number of instances with the same n
    i = 1; k = 100;
    while (i <= k)
        %number of lecturers
        %n = randi([50*m, 100*m],1,1);
        m = 0.05*n;
        %number of projects 
        q = 0.4*n;
        %probability of incomplete in students' preference lists
        p = 20/q;
        %generate an SPA-P instance of parameters (n,m,q,p)
        [lect_rank_list,lect_caps_list,proj_caps_list,stud_rank_list,f_time] = generator(n,m,q,p);
        if (~isempty(stud_rank_list)) 
            %create a random matching
            [M] = make_random_matching(lect_rank_list,lect_caps_list,proj_caps_list,stud_rank_list);
            %
%             instances = [instances;n,m,q,p];
            %save rank matrices and the matching to file
            filename = ['inputsEx3_AP_15\I(',num2str(n),',',num2str(m),')-',num2str(i),'.mat'];
            save(filename,'lect_rank_list','lect_caps_list','proj_caps_list','stud_rank_list','M');
            %
            fprintf('I%d-(%d,%d,%d,%0.3f)\n',i,n,m,q,p);
            i = i + 1;
        end
    end
%     filename = [folder,'\I-',num2str(n),'.mat'];
%     save(filename,'instances');
end
%========================================================================================
function [lect_rank_list,lect_caps_list,proj_caps_list,stud_rank_list,f_time] = generator(n,m,q,p)
%m: number of lecturers
%q: number of projects
%n: number of students
%p: probability of projets in students' lists
%
tic
f_time = 0;
%1.generate lecturers' projects whose sum of elements is equal to q
x = 1 + rand(m,1);
lect_proj_list = round(x/sum(x)*q);
%exactly round to q projects
s = sum(lect_proj_list) - q;
for i = 1:abs(s)
    if s > 0
        [~,idx] = max(lect_proj_list); 
        lect_proj_list(idx) = lect_proj_list(idx) - 1;
    else
       if s <0
           [~,idx] = min(lect_proj_list);
           lect_proj_list(idx) = lect_proj_list(idx) + 1;
       end
    end
end
%
%generate lecturers' preference lists
q = sum(lect_proj_list);
lect_pref_list = zeros(m,q);
c = 1;
for i = 1:m
    for j = 1:lect_proj_list(i)
        lect_pref_list(i,j) = c;
        c = c + 1;
    end
end
%
%generate lecturers' rank lists
lect_rank_list = zeros(m,q);
for i = 1:m
    for j = 1:q
        if (lect_pref_list(i,j) > 0)
            lect_rank_list(i,lect_pref_list(i,j)) = j;
        end
    end
end
%
%2. the total capacities of the projects
total_cj = round(1.0*n);
%total_cj is randomly distributed amongst the projects
x = 1 + rand(1,q);
proj_caps_list = round(x/sum(x)*total_cj);
%exactly round to q projects
s = sum(proj_caps_list) - total_cj;
for i = 1:abs(s)
    if s > 0
        [~,idx] = max(proj_caps_list); 
        proj_caps_list(idx) = proj_caps_list(idx) - 1;
    else
       if s <0
           [~,idx] = min(proj_caps_list);
           proj_caps_list(idx) = proj_caps_list(idx) + 1;
       end
    end
end
%
%3. the capacity for each lecturer lk is chosen randomly to lie between 
%the highest capacity of the projects offered by lk and the sum of the
%capacities of the projects that lk offers.
%
lect_caps_list = zeros(m,1);
for i = 1:m
    pj = find(lect_rank_list(i,:) > 0);
    if isempty(pj)
        stud_rank_list = [];
        return;
    end
    lect_caps_list(i) = sum(proj_caps_list(pj));
%     d1 = max(proj_caps_list(pj));
%     d2 = sum(proj_caps_list(pj));
%     lect_caps_list(i) = randi([round(0.7*d2),round(0.85*d2)],1,1); %d2;
end
%
%fprintf('\n sum of lecturers capacities = %d\n',sum(lect_caps_list));
%4. generate students' preference lists with probability of p 
y = rand(n,q);
[~,stud_pref_list] = sort(y,2);
for i = 1:n
    z = rand(1,q);
    j = find(z > p);
    stud_pref_list(i,j) = 0;
    %if student has an empty preference list, discard the instance
    if ~any(stud_pref_list(i,:))
        stud_rank_list = [];
        return;
    end
end
%
%generate students' rank lists
stud_rank_list = zeros(n,q);
for i = 1:n
    idx = find(stud_pref_list(i,:) ~=0,1,'first');
    stud_rank_list(i,stud_pref_list(i,idx)) = 1;
    cj = 1;
    for j = idx+1:q
        if (stud_pref_list(i,j) > 0)
            cj = cj + 1;
            stud_rank_list(i,stud_pref_list(i,j)) = cj;
        end
    end
end
f_time = toc;
end
%========================================================================================

