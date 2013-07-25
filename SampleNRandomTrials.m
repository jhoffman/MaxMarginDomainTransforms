function [train, test] = SampleNRandomTrials(Labels, n, param)
% Labels - cell contains source and target labels
% n - number of random trials
% param - num_train_source, num_train_target, held_out_categories,
% num_categories, categories

if ~isfield(param, 'num_train_source') || ~isfield(param, 'num_train_target') ...
        || ~isfield(param, 'held_out_categories') || ...
        ~isfield(param, 'categories')
    disp(['Parameters should include -num_train_source,'...
        '-num_train_target, -categories and -held_out_categories.'...
        'Missing some value, cannot return samples']);
    train = [];
    test = [];
    return;
end

result_filename = param.result_filename;
if exist(result_filename, 'file')
    load(result_filename);
    return;
end

for iter = 1:n
   if param.held_out_categories
       [tr_s, te_s, tr_t, te_t] = SplitDiffCategories(Labels{1}, ...
           Labels{2}, param);
       train.source{iter} = tr_s;
       train.target{iter} = tr_t;
       test.source{iter} = te_s;
       test.target{iter} = te_t;
   else
      [tr_s, te_s, tr_t, te_t] = SplitAllCategories(Labels{1}, ...
          Labels{2}, param); 
      train.source{iter} = tr_s;
      train.target{iter} = tr_t;
      test.source{iter} = te_s;
      test.target{iter} = te_t;
   end
end

save(result_filename, 'param', 'train', 'test');
end