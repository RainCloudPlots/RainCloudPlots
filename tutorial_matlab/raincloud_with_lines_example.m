figure(1); clf
% generate data

rng default  % for reproducibility
m = 2;
sd = 2;
n = 10000;

data1 = sort((randn(n,1)*sd)+m);

data2 = sort([randn(n/2,1)+m-sd; randn(n/2,1)+m+sd]);

v = sd^2;
mu = log((m^2)/sqrt(v+m^2));
sigma = sqrt(log(v/(m^2)+1));
data3 = sort(lognrnd(mu,sigma,n,1));

data = [data1 data2 data3];

[handles] = raincloud_plot(data,'color',[0.7 0 0; 0 0.7 0; 0 0 0.7],...
    'band_width',[1 0.5 0.8],'box_dodge',1,'box_alpha',0.2,'alpha',0.5,'plot_width',0.3,...
    'dot_alpha',0.01);

hold on

data = data+50;
[handles] = raincloud_plot(data,'color',[0.7 0 0; 0 0.7 0; 0 0 0.7],...
    'band_width',[1 0.5 0.8],'box_dodge',1,'box_alpha',0.2,'alpha',0.5,'plot_width',0.3,...
    'dot_alpha',0.01,'dot_random_distribution','uniform');

ax=gca;
yticks([1 2 3])
ax.YTickLabel ={'normal','bimodal','lognormal'};
title('Raincloud plot for different distributions')
set(gca,'FontSize',16)

%%
figure(2); clf

% generate data
m = 2;
sd = 2;
n = 40;

data1 = sort((randn(n,1)*sd)+m);

data2 = sort([randn(n/2,1)+m-sd; randn(n/2,1)+m+sd]);

v = sd^2;
mu = log((m^2)/sqrt(v+m^2));
sigma = sqrt(log(v/(m^2)+1));
data3 = sort(lognrnd(mu,sigma,n,1));

data = [data1 data2 data3];

[handles] = raincloud_plot(data,'color',[0.7 0 0; 0 0.7 0; 0 0 0.7],...
    'band_width',[1 0.5 0.8],'box_dodge',1,'connecting_lines',1,'box_alpha',0.2,'alpha',0.5,'y_values',[0.8 1.8 2.8],'plot_width',0.1);

hold on
data = data+15;
raincloud_plot(data,'color',[0.7 0 0; 0 0.7 0; 0 0 0.7],...
'band_width',[1 0.5 0.8],'box_dodge',1,'connecting_lines',1,'box_alpha',0.2,'alpha',0.5,'y_values',[1.1 2.1 3.1],'plot_width',0.1,...
'range_dots',0);

data = data+20;
[h, bw, d] = raincloud_plot(data,'color',[0.7 0 0; 0 0.7 0; 0 0 0.7],...
'band_width',[1 0.5 0.8],'box_dodge',0,'connecting_lines',1,'box_alpha',0.2,'alpha',0.5,'y_values',[0.85 1.85 2.85],'plot_width',0.3,...
'range_dots',1,'box_width',0.3);

set(gca,'FontSize',16)
ax=gca;
yticks([1 2 3])
ax.YTickLabel ={'normal','bimodal','lognormal'};
title('Lines for (simulated sorted) paired samples')

%%

figure(3);clf

[h, bw, d] = raincloud_plot(data,'color',[0.7 0 0; 0 0.7 0; 0 0 0.7],...
'band_width',[1 0.5 0.8],'box_dodge',0,'connecting_lines',1,'box_alpha',0.2,'alpha',0.5,'plot_width',0.05,...
'range_dots',1,'box_width',0.3,'y_values',[0.2 0.4 0.8], 'cloud_edge_col','none');

hold on

[h, bw, d] = raincloud_plot(data,'plot_vertical',1,'color',[0.7 0 0; 0 0.7 0; 0 0 0.7],...
'band_width',[1 0.5 0.8],'box_dodge',0,'connecting_lines',1,'box_alpha',0.2,'alpha',0.5,'plot_width',0.05,...
'range_dots',1,'box_width',0.3,'y_values',[1.2 1.4 1.8],'cloud_edge_col','none');

set(gca,'FontSize',16)
title('View turned to vertical, with specified y values')