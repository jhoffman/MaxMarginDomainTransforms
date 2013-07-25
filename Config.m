function param = Config(source, target)

%%%%%               FIXED PARAMETERS FOR OFFICE DATASET             %%%%%%
amazon = 1; webcam = 2; dslr = 3; caltech = 4;
param.domains = [amazon, webcam, dslr, caltech];
param.domain_names = {'amazon', 'webcam', 'dslr', 'caltech'};
param.use_Gaussian_kernel = false;

param.categories = {'back_pack' 'bike'  'calculator' ...
    'headphones' 'keyboard'  'laptop_computer' 'monitor'  'mouse' ...
    'mug' 'projector' };

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%                      PARAMETERS TO EDIT                       %%%%%%
% Directory containing the data 
param.DATA_DIR = '~/code/dev/OfficeExperiments/datacodeofthegeodesicflowkernel/';

% Choose the experiment type
param.held_out_categories = false; 

% Choose domains
if nargin == 2
    param.source = source;
    param.target = target;
else
    param.source = webcam;
    param.target = dslr;
end

% Choose the number of iterations to use
param.num_trials = 20;

% Choose dimension for data (with no dim reduction choose 800)
param.dim = 20;

% Choose the data normalization to use: ('none', 'l1','l2', 'l1_zscore',
% 'l2_zscore')
param.norm_type = 'l2_zscore';

% Parameters for MMDT
param.C_s = .05;
param.C_t = 1;
param.mmdt_iter = 2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Number of training examples per category (Below is parameters from paper)
if param.source == amazon
    param.num_train_source = 20; % Use 20 for amazon and 8 for every other domain
else
    param.num_train_source = 8;
end
param.num_train_target = 3;

param.result_filename = sprintf('DataSplitsOfficeCaltech/SameCategory_%s-%s_%dRandomTrials_10Categories.mat', ...
    param.domain_names{param.source}, param.domain_names{param.target},...
    param.num_trials);
end