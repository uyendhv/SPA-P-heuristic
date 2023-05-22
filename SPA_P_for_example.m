clc
clear vars
close all
%==========================================================================
%examle SPA-ST, Manlove 2003
lect_rank_list = [1 2 3 0 0;
                  0 0 0 1 2];
lect_proj_list = [1 1 1 2 2 2 3 3];
lect_caps_list = [3;2];
proj_caps_list = [1 2 1 1 2];
%
stud_rank_list = [1 0 2 3 0;
                  2 0 0 0 1;
                  0 1 0 0 2;
                  0 2 0 1 0;
                  0 0 0 0 1];
[f_time,f_cost,f_stable,f_iter,f_reset] = HGS(lect_rank_list,lect_caps_list,proj_caps_list,stud_rank_list);
%==========================================================================
