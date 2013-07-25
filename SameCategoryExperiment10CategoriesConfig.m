function param = SameCategoryExperiment10CategoriesConfig(D_s, D_t)
% D = (1: Amazon, 2: Webcam, 3: Dslr, 4: Caltech256)
param.domains = {'amazon', 'webcam', 'dslr', 'caltech'};
if D_s == 1
    num_train_source = 20;
else
    num_train_source = 8;
end

param.num_train_source = num_train_source;
param.num_train_target = 3;
param.held_out_categories = false;

%param.all_categories = {  'back_pack'    'bike'    'bike_helmet'    'bookcase'    'bottle'    'calculator'    'desk_chair'    'desk_lamp'    'desktop_computer'    'file_cabinet'    'headphones'    'keyboard'    'laptop_computer'    'letter_tray'    'mobile_phone'    'monitor'    'mouse'    'mug'    'paper_notebook'    'pen'    'phone'    'printer'    'projector'    'punchers'    'ring_binder'    'ruler'    'scissors'    'speaker'    'stapler'    'tape_dispenser'    'trash_can' };

param.categories = {'back_pack' 'bike'  'calculator' ...
    'headphones' 'keyboard'  'laptop_computer' 'monitor'  'mouse' ...
    'mug' 'projector' };
param.num_trials = 20;
param.result_filename = sprintf('DataSplitsOfficeCaltech/SameCategory_%s-%s_%dRandomTrials_10Categories.mat', ...
    param.domains{D_s}, param.domains{D_t}, param.num_trials);
end