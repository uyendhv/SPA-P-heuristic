function main
clc
clear vars
clear all
close all
%run algorithms
alg = 3;
%number of instances has the same (n,m,p1,p2)
k = 100;
% n = 200;
 for n = 1000:1000:10000
     m = 0.05*n;
        f_results= [];
        i = 1;
        while (i <= k)
            %load the preference matrices and the matching from file
            filename = ['inputsEx3_AP_20\I(',num2str(n),',',num2str(m),')-',num2str(i),'.mat'];
            load(filename,'lect_rank_list','lect_caps_list','proj_caps_list','stud_rank_list','M');
            %run algorithms
            if (alg == 1)
                [f_time,f_cost,f_stable,f_iter,f_reset] = HGS(lect_rank_list,lect_caps_list,proj_caps_list,stud_rank_list);
            end
            if (alg == 2)
                [f_time,f_cost,f_stable,f_iter,f_reset] = MCH(lect_rank_list,lect_caps_list,proj_caps_list,stud_rank_list,M);
            end
            if (alg == 3)
            [f_time,f_cost,f_stable,f_iter,f_reset] = SPA_P_promotion(lect_rank_list,lect_caps_list,proj_caps_list,stud_rank_list);
             end
            %
            f_results = [f_results; f_time,f_cost,f_stable,f_iter,f_reset];
            %
            fprintf('\nI(%d,%d)-%3d: time = %3.5f, f(M)=%2d, stable=%d, iters=%d, reset=%d',n,m,i,f_time,f_cost,f_stable,f_iter,f_reset);
            %
            i = i + 1;
        end
        if (alg == 1)
            filename2 = ['outputsEx3_AP_10\HG(',num2str(n),',',num2str(m),').mat'];
            save(filename2,'f_results');
        end
%         if (alg == 2)
%             filename2 = ['outputsEx2_10\MCH(',num2str(n),').mat'];
%             save(filename2,'f_results');
%         end
        if (alg == 3)
            filename2 = ['outputsEx3_AP_20\AP(',num2str(n),',',num2str(m),').mat'];
            save(filename2,'f_results');
        end
       %
 end
end
%==========================================================================