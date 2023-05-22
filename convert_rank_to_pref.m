function [lect_pref_list,stud_pref_list]= convert_rank_to_pref(lect_rank_list,stud_rank_list)
%
n = size(stud_rank_list,1);
m = size(lect_rank_list,1);
q = size(lect_rank_list,2);
%
stud_pref_list = zeros(n,q);
lect_pref_list = zeros(m,q);
%
%convert lect_rank_list to lect_pref_list
for i = 1:m
    for j = 1:q
        if (lect_rank_list(i,j) > 0)
            lect_pref_list(i,lect_rank_list(i,j)) = j;
        end    
    end
end
%convert stud_rank_list to stud_pref_list
for i = 1:n
    for j = 1:q
        if (stud_rank_list(i,j) > 0)
            stud_pref_list(i,stud_rank_list(i,j)) = j;
        end 
    end
end
end