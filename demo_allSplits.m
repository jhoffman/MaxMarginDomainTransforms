% Author jhoffman@eecs.berkeley.edu (Judy Hoffman)
% demo script for the paper:
% "Efficient Learning of Domain-invariant Image Representations"
% J. Hoffman, E. Rodner, J. Donahue, K. Saenko, T. Darrell
% International Conference on Learning Representations (ICLR), 2013.

clear all;
AddDependencies;

param = Config();
[Data, Labels] = LoadOfficePlusCaltechData(param.DATA_DIR, param.norm_type);

all_acc = cell(numel(param.domains));
for s = 1:numel(param.domains)
    source_domain = param.domains(s);
    for t = 1:numel(param.domains)
        target_domain = param.domains(t);
        if source_domain == target_domain
            continue;
        end
        param = Config(source_domain, target_domain);
        % Load data splits
        splits = load(param.result_filename);
        train_ids = splits.train;
        test_ids = splits.test;
        
        fprintf('Source Domain - %s, Target Domain - %s\n', ...
            param.domain_names{source_domain}, param.domain_names{target_domain});
        
        % Store results:
        n = param.num_trials;
        telapsed = zeros(n,1);
        accuracy = zeros(n,1);
        pred_labels = cell(n,1);
        for i = 1:n
            fprintf('       Iteration: %d / %d\n', i, n);
            data.train.source = Data{source_domain}(train_ids.source{i}, :);
            data.train.target = Data{target_domain}(train_ids.target{i}, :);
            data.test.target = Data{target_domain}(test_ids.target{i}, :);
            
            labels.train.source = Labels{source_domain}(train_ids.source{i});
            labels.train.target = Labels{target_domain}(train_ids.target{i});
            labels.test.target = Labels{target_domain}(test_ids.target{i});
            labels = UpdateLabelValues(labels, param);
            
            if param.dim < size(data.train.source, 2)
                P = princomp([data.train.source; data.train.target; data.test.target]);
                data.train.source = data.train.source * P(:, 1:param.dim);
                data.train.target = data.train.target * P(:, 1:param.dim);
                data.test.target = data.test.target * P(:, 1:param.dim);
            end
            %
            tstart = tic;
            [model, W] = TrainMmdt(labels.train, data.train, param);
            telapsed(i) = toc(tstart);
            [pl, acc] = predict(labels.test.target', ...
                [sparse(data.test.target), ones(length(labels.test.target),1)], ...
                model);
            accuracy(i) = acc(1);
            pred_labels{i} = pl;
            fprintf('   Accuracy = %6.2f (Time = %6.2f)\n', accuracy(i), telapsed(i));
            
            
        end
        fprintf('\n\n Mean Accuracy = %6.3f +/- %6.2f  (Mean time = %6.3f)\n', ...
            mean(accuracy), std(accuracy)/sqrt(n), mean(telapsed));
        all_acc{s,t} = accuracy;
    end
end

fprintf('\n\n');
total_ma=0;
for s=1:4
    for t = 1:4
        if s ~= t
            ma = mean(all_acc{s,t});
            fprintf('%s -> %s: %6.2f +/-%6.1f\n',param.domain_names{s}, ...
                param.domain_names{t}, ma, std(all_acc{s,t})/sqrt(numel(all_acc{s,t})));
            total_ma = total_ma + ma;
        end
    end
end
fprintf('\n\n Mean acc all: %6.2f\n', total_ma /12);
