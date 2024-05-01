clc;
clear;

weeks = 104;

dim = weeks * 4;
SearchAgents_no = 30;
Max_iter = 500000;

tic;
[~, ~, Convergence_curve1] = GAT(SearchAgents_no, Max_iter, weeks * 4, @obj); 
gat_time = toc;
fprintf('GAT OK! Execution time: %.2f seconds\n', gat_time); 

tic;
[~, ~, Convergence_curve2] = GA(SearchAgents_no, Max_iter, weeks * 4, @obj); 
ga_time = toc;
fprintf('GA OK! Execution time: %.2f seconds\n', ga_time);

tic;
[~, ~, Convergence_curve3] = CGWO(SearchAgents_no, Max_iter, zeros(1, dim), ones(1, dim) * 500, dim, @obj);
cgwo_time = toc;
fprintf('CGWO OK! Execution time: %.2f seconds\n', cgwo_time);

tic;
[~, ~, Convergence_curve4] = PSO(SearchAgents_no, Max_iter, zeros(1, dim), ones(1, dim) * 500, dim, @obj);
pso_time = toc;
fprintf('PSO OK! Execution time: %.2f seconds\n', pso_time);

tic
[~, ~, Convergence_curve5] = AOA(SearchAgents_no, Max_iter, @obj, dim, 0, 500, 1, 2);
aoa_time = toc;
fprintf('AOA OK! Execution time: %.2f seconds\n', aoa_time);


figure;
hold on;
plot(Convergence_curve1, 'b-', 'LineWidth', 1.5); 
plot(Convergence_curve2, 'g--', 'LineWidth', 1.5); 
plot(Convergence_curve3, 'r-.', 'LineWidth', 1.5); 
plot(Convergence_curve4, 'm:', 'LineWidth', 1.5); 
plot(Convergence_curve5, 'k-', 'LineWidth', 1.5); 

% 添加标注
legend('GAT algorithm', 'GA algorithm', 'CGWO algorithm', 'PSO algorithm', 'AOA algorithm');
xlabel('Number of iterations');
ylabel('convergence curve');
title('Optimization algorithm convergence curve');
grid on;
hold off;

% 让y轴自适应数据范围
ylim('auto');