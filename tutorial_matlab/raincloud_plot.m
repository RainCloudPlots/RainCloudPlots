%% raincloud_plot - plots a combination of half-violin, boxplot, and raw datapoints (1d scatter).
% Use as h = raincloud_plot(data), where data is a data vector and h is a cell array of handles for the various figure
% parts. Seee below for optional inputs. 
% Based on https://micahallen.org/2018/03/15/introducing-raincloud-plots/
% Inspired by https://m.xkcd.com/1967/ 
% v1 - Written by Tom Marshall. www.tomrmarshall.com 
% v2 - Updated inputs to be more flexible - Micah Allen 12/08/2018 
% v3 - Updates and adaptations by Marius Klug 26/10/2018 bemobil.bpn.tu-berlin.de
%
% Thanks to Jacob Bellmund for some improvements
% 
% ---------------------------- INPUT ----------------------------
%
% data - matrix of data to be plotted, required.
%
% --------------------- OPTIONAL ARGUMENTS ----------------------
%
% color                     - color vector (or matrix) for rainclouds (default gray, i.e. = [.5 .5 .5])
% band_width                - band_width of smoothing kernel (default = 1)
% density_type              - choice of density algo ('ks' or 'rath'). Default = 'ks'
% box_on                    - logical to turn box plots on/off (default = 0)
% box_dodge                 - logical to turn on/off box plot dodging (default = 0)
% alpha                     - scalar positive value to increase cloud alpha (defalut = 1)
% line_width                - scalar value to set global line width (default = 2)
% bxcl                      - color of box outline
% cloud_edge_col            - color of the cloud edge line (default = [0 0 0]). Set to 'none' for no cloud edge.
% plot_width                - relative width of the plot to left and right (default = 0.2)
% dot_alpha                 - translucency value of the dots (default = 1)
% box_alpha                 - translucency value of the box (default = 0.5)
% plot_vertical             - set this to true if you want the clouds to be vertical instead of horizontal. Beware, it only
%                               changes the view, the x and y axes will be swapped! (default = false)
% distance_drops            - the distance the drops have from the PDF. Will be symmetrically aligned (default = 0.02)
% connecting_lines          - plot connecting lines between the dots or not (default = 0)
% connecting_lines_color    - color of the connecting lines (default = [0 0 0 0.2]). NOTE: the last value is the alpha value
% dot_random_distribution   - distribution of the dot position: 'normal' or 'uniform' (default = 'normal')
% range_dots                - range multiplicator of the distribution of the dots. 1 means equal width to the PDS (default = 1)
% box_width                 - multiplicator for the width of the box (multiplied with plot_width, default = 0.5)
% y_values                  - y_values for the plot (default = 1:size(data,2))
%
% ---------------------------- OUTPUT ----------------------------
% handles                   - figure handles to change more stuff
% kernel_bandwidths         - parameter from kernel density estimate
% dot_locations             - locations of the dots
%
% ------------------------ EXAMPLE USAGE -------------------------
%
% [handles, kernel_bandwidths, dot_locations] = raincloud(myData, 'box_on', 1, 'color', [0.5 0.5 0.5])
%

function [handles, kernel_bandwidths, dot_locations] = raincloud_plot(data, varargin)

%% check all the inputs and if they do not exist then revert to default settings
% input parsing settings
p = inputParser;
p.CaseSensitive = true;
p.Parameters;
p.Results;

% p.KeepUnmatched = true;

validScalarPosNum = @(x) isnumeric(x) && isscalar(x) && (x > 0);

% set the desired and optional input arguments
addRequired(p, 'data', @isnumeric);
addOptional(p, 'color', [0.5 0.5 0.5], @isnumeric)
addOptional(p, 'band_width', [])
addOptional(p, 'density_type', 'ks', @ischar)
addOptional(p, 'box_on', 1, @isnumeric)
addOptional(p, 'box_dodge', 0, @isnumeric)
addOptional(p, 'alpha', 1, validScalarPosNum)
addOptional(p, 'line_width', 2, validScalarPosNum)
addOptional(p, 'bxcl', [0 0 0], @isnumeric)
addOptional(p, 'cloud_edge_col', [0 0 0])
addOptional(p, 'plot_width', 0.2, @isnumeric)
addOptional(p, 'dot_alpha', 1, @isnumeric)
addOptional(p, 'box_alpha', 0.5, @isnumeric)
addOptional(p, 'plot_vertical', false, @isnumeric)
addOptional(p, 'distance_drops', 0.02, @isnumeric)
addOptional(p, 'connecting_lines', 0, @isnumeric)
addOptional(p, 'connecting_lines_color', [0 0 0 0.2], @isnumeric)
addOptional(p, 'dot_random_distribution', 'normal', @ischar)
addOptional(p, 'range_dots', 1, @isnumeric)
addOptional(p, 'box_width', 0.5, @isnumeric)
addOptional(p, 'y_values', 0, @isnumeric)


% parse the input
parse(p,data,varargin{:});

% then set/get all the inputs out of this structure
data = p.Results.data;
color = p.Results.color; 
density_type = p.Results.density_type; 
box_on = p.Results.box_on;
box_dodge = p.Results.box_dodge; 
alpha = p.Results.alpha;
line_width = p.Results.line_width; 
bxcl = p.Results.bxcl; 
cloud_edge_col = p.Results.cloud_edge_col; 
band_width = p.Results.band_width;
plot_width = p.Results.plot_width; 
dot_alpha = p.Results.dot_alpha; 
box_alpha = p.Results.box_alpha;
plot_vertical = p.Results.plot_vertical;
distance_drops = p.Results.distance_drops;
connecting_lines = p.Results.connecting_lines;
connecting_lines_color = p.Results.connecting_lines_color;
dot_random_distribution = p.Results.dot_random_distribution;
range_dots = p.Results.range_dots;
box_width = p.Results.box_width;
y_values = p.Results.y_values;

% prepare for plotting

if y_values==0
    y_values = 1:size(data,2);
elseif numel(y_values) ~= size(data,2)
    error('x_values must be the same length as size(data,2)!')
end

% if only one color, use that for all plots
if size(color,1) == 1
    color = repmat(color,size(data,2),1);
end


% create band_width cell array and fill with provided values. Necessary to also have the option of empty values
band_widths = cell(1,size(data,2));
if ~isempty(band_width)
    if numel(band_width) == 1
        [band_widths{:}] = deal(band_width);
    elseif numel(band_width) == size(data,2)
        for i=1:numel(band_width)
            band_widths{i} = band_width(i);
        end
    else
        error('''Bandwidth'' must either be a scalar or a vector corresponding in length to the number of columns of the data.')
    end
end

% width of boxplot and dot distribution
width_dots = plot_width - distance_drops;
width_box = plot_width*box_width;

% have double the space if the dots are between box and PDF
if box_dodge
    distance_drops = distance_drops*2;
end

plot_previously_held = ishold;

if ~plot_previously_held
    cla;
    hold on
end

% plot all data columns
for i_column = 1:size(data,2)
    
    this_data = data(:,i_column);
    
    % calculate kernel density
    switch density_type
        case 'ks'
            [f, Xi, kernel_bandwidths(i_column)] = ksdensity(this_data, 'bandwidth', band_widths{i_column});
        case 'rash'
            % must have https://github.com/CPernet/Robust_Statistical_Toolbox
            % for this to work
            try
                [Xi, f] = rst_RASH(this_data);
                band_widths = NaN; % not sure how to handle this with RASH yet
            catch
                disp('you''ve specified density_type = ''RASH'', but something''s gone wrong.')
                disp('Have you downloaded Cyril Pernet''s robust stats toolbox?');
            end
    end
    
    % scale density
    
    if ~box_dodge
        f = f/max(f)*plot_width+distance_drops;
    else
        f = f/max(f)*plot_width+distance_drops + width_dots/2;
    end
    
    % density plot
    handles{i_column,1} = fill(Xi, f+y_values(i_column), color(i_column,:));
    set(handles{i_column,1}, 'FaceColor', color(i_column,:));
    set(handles{i_column,1}, 'EdgeColor', cloud_edge_col);
    set(handles{i_column,1}, 'LineWidth', line_width);
    set(handles{i_column,1}, 'FaceAlpha', alpha);
    
    % jitter for raindrops
    
    if strcmp(dot_random_distribution,'uniform')
        drops_pos = -distance_drops + rand(size(this_data)) * -width_dots * range_dots;
    elseif strcmp(dot_random_distribution,'normal')
        drops_pos = (randn(size(this_data)) * (width_dots/5) * range_dots) -distance_drops - width_dots/2;
    else
        error('The distribution of the dots can be either uniform or normal.')
    end
    
    % if box dodge plot dots in the middle
    if box_dodge
        drops_pos = drops_pos + width_dots/2 + distance_drops;
    end
    
    dot_locations(i_column,:,:) = [this_data,drops_pos+y_values(i_column)];
    handles{i_column,2} = scatter(this_data, drops_pos+y_values(i_column));
    handles{i_column,2}.SizeData = 10;
    handles{i_column,2}.MarkerFaceColor = color(i_column,:);
    handles{i_column,2}.MarkerEdgeColor = 'none';
    handles{i_column,2}.MarkerFaceAlpha = dot_alpha;
    
    if box_on
        
        % info for making boxplot
        quantiles = quantile(this_data, [0.25 0.75 0.5 0.02 0.98]);
        
        if box_dodge
            box_edges = [y_values(i_column)-(plot_width+distance_drops)/2 y_values(i_column)-(plot_width+distance_drops)/2-plot_width/2];
        else
            box_edges = [y_values(i_column)-plot_width/2-width_box/2 y_values(i_column)-plot_width/2+width_box/2] -distance_drops/2;
        end
       
        % 'box' of 'boxplot'
        handles{i_column,3} = fill([quantiles(1),quantiles(2), quantiles(2), quantiles(1), quantiles(1)],...
            [box_edges(1), box_edges(1), box_edges(2), box_edges(2), box_edges(1)],color(i_column,:));
        set(handles{i_column,3}, 'EdgeColor', bxcl)
        set(handles{i_column,3}, 'LineWidth', line_width);
        set(handles{i_column,3},'FaceAlpha',box_alpha)
        
        % mean line
        handles{i_column,4} = line([quantiles(3) quantiles(3)], [box_edges(1) box_edges(2)], 'col', bxcl, 'LineWidth', line_width);
        
        % whiskers
        handles{i_column,5} = line([quantiles(2) quantiles(5)], [mean(box_edges) mean(box_edges)], 'col', bxcl, 'LineWidth', line_width);
        handles{i_column,6} = line([quantiles(1) quantiles(4)], [mean(box_edges) mean(box_edges)], 'col', bxcl, 'LineWidth', line_width);
        
        
    end
end

% plot connecting lines if selected
if connecting_lines
    
    for i_column = 2:size(data,2)
    
        line([dot_locations(i_column-1,:,1);dot_locations(i_column,:,1)],...
            [dot_locations(i_column-1,:,2);dot_locations(i_column,:,2)],'Color',connecting_lines_color)
    end
end

% adjust the view of the figure
if plot_vertical
    view([90 -90])
else
    view([0 90])
end

if ~plot_previously_held
    hold off
end
