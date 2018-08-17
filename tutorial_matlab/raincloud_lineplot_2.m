%% works, part

function h = raincloud_lineplot_2(X, clz, rot, cthru)

Xsize = size(X);
X_old = X;
X = reshape(X,numel(X),1);
tmpclz = vertcat(clz{:}); 

if ~exist('cthru', 'var')
    cthru = 0;
end

% calculate densities
for i = 1:length(X)
    [f{i}, xi{i}] = ksdensity(X{i});
end

% use density heights to determine spacing between plots
spacing     = 2 * mean(cellfun(@max,f));
baseline    = spacing .* (-0.5 + 1:Xsize(1));
baseline    = repmat(baseline,1,Xsize(2));
% also determines width of 1-d scatter cloud (raindrops)
jitwidth    = spacing / 8;

nax = 1;
% plot density plots
for i = 1:length(X)
    ax(nax)                     = axes;
    h.a(i)                      = area(xi{i}, -f{i} + baseline(i), baseline(i));
    h.a(i).FaceColor            = tmpclz(i,:);
    if cthru
        h.a(i).FaceAlpha        = 0.5;
    end
    h.a(i).LineStyle            = 'none';
    h.a(i).BaseLine.LineStyle   = 'none';
    if i ~= 1
        axis off
    end
    % figure out orientation (horiz/vert)
    if rot
        view([90 -90]);
    else
        set(ax(nax), 'Ydir', 'reverse');
    end
    nax = nax + 1;
end

% raindrops
for i = 1:length(X)
%     nax                     = length(X) + i;
    npts                    = length(X{i});
    jit                     = -(jitwidth / 2) + (rand(1, npts) * jitwidth);
    ax(nax)                 = axes;
    tmp                     = repmat(baseline(i) + (spacing / 4), 1, npts);
    h.s(i)                  = scatter(X{i}, tmp + jit);
    h.s(i).MarkerFaceColor  = tmpclz(i,:);
    h.s(i).MarkerEdgeColor  = 'none';
    h.s(i).MarkerFaceAlpha  = 0.5;
    axis off
    % figure out orientation (horiz/vert)
    if rot
        view([90 -90]);
    else
        set( ax(nax), 'Ydir', 'reverse');
    end
    nax = nax + 1;
end

% condition means will determine big dots and line
mnz = cellfun(@mean, X_old);

% lines
for i=1:Xsize(2)
    baseline_tmp        = reshape(baseline, Xsize(1), Xsize(2));
    ax(nax)             = axes;
    h.ln                = plot(mnz(:,i), baseline_tmp(:,i));
    h.ln.Color          = mean(clz{i});
    h.ln.LineWidth      = 4;
    axis off
    % figure out orientation (horiz/vert)
    if rot
        view([90 -90]);
    else
        set( ax(nax), 'Ydir', 'reverse');
    end
    nax = nax + 1;
end

% 95% bootstrapped confidence intervals, as lines
for i = 1:length(X)
    ci(:,i) = bootci(1000,@mean,X{i});
    ax(nax)                 = axes;
    h.ci(i)                 = line([ci(i) ci(i)], [baseline(i) baseline(i)] );
    axis off
    if rot
        view([90 -90]);
    else
        set( ax(nax), 'Ydir', 'reverse');
    end
    nax = nax + 1;
end

% mean dots
for i = 1:length(X)
    ax(nax)                 = axes;
    h.m(i)                  = scatter(mnz(i), baseline(i), 100);
    h.m(i).MarkerFaceColor  = tmpclz(i,:);
    h.m(i).MarkerEdgeColor  = 'k';
    axis off   
    % figure out orientation (horiz/vert)
    if rot
        view([90 -90]);
    else
        set( ax(nax), 'Ydir', 'reverse');
    end
    nax = nax+1;
end

limits = cell2mat(get(ax, 'YLim'));

% link all the axes together
linkaxes(ax);

% adjust size so everything is in the picture
% (note: this sometimes trims the top of the first density plot)
set(gca,'YLim',[min(limits(:,1)) baseline(end) + spacing / 2])

% replace meaningless values on X-axis with something more sensible
set(ax, 'YTick', baseline(1:Xsize(1)));
set(ax, 'YTickLabel', {1:length(X)});

% % ci lines (in dev, doesn't work properly and I'm not even sure if it's
% % the thing I want).
% % 95% bootstrapped confidence intervals, as lines
% for i = 1:length(X)
%     ci(:,i) = bootci(1000,@mean,X{i});
% %     nax                     = 2 * length(X) + i;
% %     ax(nax)                 = axes;
%     h.ci(i)                 = line([ci(:,i)'], [baseline(i) baseline(i)] );
%     axis off
% end