% Use like: h = rm_raincloud(data, colours, plot_top_to_bottom, density_type, bandwidth)
% Where 'data' is an M x N cell array of N data series and M measurements
% And 'colours' is an N x 3 array defining the colour to plot each data series
% plot_top_to_bottom: Default plots left-to-right, set to 1 to rotate.
% density_type: 'ks' (default) or 'RASH'. 'ks' uses matlab's inbuilt 'ksdensity' to
% determine the shape of the rainclouds. 'RASH' will use the 'rst_RASH'
% method from Cyril Pernet's Robust Stats toolbox, if that function is on
% your matlab path.
% bandwidth: If density_type == 'ks', determines bandwidth of density estimate
% h is a cell array containing handles of the various figure parts:
% h.p{i,j} is the handle to the density plot from data{i,j}
% h.s{i,j} is the handle to the 'raindrops' (individual datapoints) from data{i,j}
% h.m(i,j) is the handle to the single, large dot that represents mean(data{i,j})
% h.l(i,j) is the handle for the line connecting h.m(i,j) and h.m(i+1,j)

%% TO-DO:
% Patch can create colour gradients using the 'interp' option to 'FaceColor'. Allow this?

function h = rm_raincloud(data, colours, plot_top_to_bottom, density_type, bandwidth)
%% check dimensions of data

[nper, nseries] = size(data);

% make sure we have enough colours
assert(all(size(colours) == [nseries 3]), 'number of colors does not match number of plot series');

if nargin < 3
    plot_top_to_bottom = 0; % left-to-right plotting by default
end

if nargin < 4
    density_type = 'ks';
end

if nargin < 5
    bandwidth = [];
end

%% Calculate properties of density plots

% Probably okay to hard-code this as it just determines the granularity of
% the density estimate

nbins = repmat(200, nper, nseries);

% calculate kernel densities
for i = 1:nper
    for j = 1:nseries
        % TO-DO: Switch here to use alternative methods to estimate density (e.g. RASH)
        switch density_type
            case 'ks'
                [ks{i,j}, x{i,j}] = ksdensity(data{i,j}, 'NumPoints', nbins(i,j), 'bandwidth', bandwidth);
            case 'rash'
                % check for rst_RASH function (from Robust stats toolbox) in path, fail if not found 
                assert(exist('rst_RASH') == 2,'Could not compute density using RASH method. Do you have the Robust Stats toolbox on your path?');
                
                [x{i,j}, ks{i,j}] = rst_RASH(data{i,j});
                % override default 'nbins' as rst_RASH determines number of bins
                nbins(i,j) = size(ks{i,j},2);
        end
        
        % Define the faces to connect each adjacent f(x) and the corresponding points at y = 0.
        q{i,j}       = (1:nbins(i,j)-1)';
        faces{i,j}   = [q{i,j}, q{i,j} + 1, q{i,j} + nbins(i,j) + 1, q{i,j} + nbins(i,j)];
    end
end

% keyboard

% determine spacing between plots
spacing     = 2 * mean(mean(cellfun(@max,ks)));
ks_offsets  = [0:nper-1] .* spacing;
% flip so first plot in series is plotted on the *top*
ks_offsets  = fliplr(ks_offsets);

% calculate patch vertices from kernel density
for i = 1:nper
    for j = 1:nseries
        verts{i,j} = [x{i,j}', ks{i,j}' + ks_offsets(i); x{i,j}', ones(nbins(i,j),1) * ks_offsets(i)];
        verts{i,j} = [x{i,j}', ks{i,j}' + ks_offsets(i); x{i,j}', ones(nbins(i,j),1) * ks_offsets(i)];
    end
end


%% jitter for the raindrops

jitwidth = spacing / 8;

% TO-DO: This should probably not be hardcoded either...
sz = 100;

for i = 1:nper
    for j = 1:nseries
        jit{i,j} = jitwidth + rand(1, length(data{i,j})) * jitwidth;
    end
end

%% means (for mean dots)

mnz = cellfun(@mean, data);

%% plot
% note - we *could* plot everything here in one big loop, but then
% different figure parts would overlay each other in a silly way.

hold on

% patches
for i = 1:nper
    for j = 1:nseries
        % plot patches
        h.p{i,j} = patch('Faces', faces{i,j}, 'Vertices', verts{i,j}, 'FaceVertexCData', [colours(j,:)], 'FaceColor', 'flat', 'EdgeColor', 'none', 'FaceAlpha',0.5);
        
        % scatter rainclouds
        h.s{i,j} = scatter(data{i,j}, -jit{i,j} + ks_offsets(i), 'MarkerFaceColor', colours(j,:), 'MarkerEdgeColor', 'none', 'MarkerFaceAlpha', 0.5, 'SizeData', sz);
    end
end

% plot mean lines
for i = 1:nper-1 % note 2, not 1. We have nper-1 lines because lines connect pairs of points
    for j = 1:nseries
        h.l(i,j) = line(mnz([i i+1],j), ks_offsets([i i+1]), 'LineWidth', 4, 'Color', colours(j,:));
    end
end

% plot mean dots
for i = 1:nper
    for j = 1:nseries
        h.m(i,j) = scatter(mnz(i,j), ks_offsets(i), 'MarkerFaceColor', colours(j,:), 'MarkerEdgeColor', [0 0 0], 'MarkerFaceAlpha', 1, 'SizeData', sz*2, 'LineWidth', 2);
    end
end

%% clear up axis labels

% 'YTick', likes values that *increase* as you go up the Y-axis, but we plot the first
% raincloud at the top. So flip the vector around
set(gca, 'YTick', fliplr(ks_offsets));

set(gca, 'YTickLabel', nper:-1:1);

%% determine plot rotation
% default option is left-to-right
% plot_top_to_bottom can be set to 1 
% NOTE: Because it's easier, we actually prepare everything plotted
% top-to-bottom, then - by default - we rotate it here. That's why the
% logical is constructed the way it is.

% rotate and flip
if ~plot_top_to_bottom
    view([90 -90]);
    axis ij
end
