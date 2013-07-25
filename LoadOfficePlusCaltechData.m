function [Data, Labels] = LoadOfficePlusCaltechData(foldername, norm_type)
fname = '%s_SURF_L10.mat';
domain_names = {'amazon', 'webcam', 'dslr', 'Caltech10'};

Data = cell(numel(domain_names));
Labels = cell(numel(domain_names));
for d = 1:numel(domain_names)
   fullfilename = fullfile(foldername, sprintf(fname, domain_names{d}));
   load(fullfilename);
   fts = NormData(fts, norm_type);
   Data{d} = fts;
   Labels{d} = labels';
end
end

function fts = NormData(fts, norm_type)
    switch norm_type
        case 'l1_zscore'
            fts = fts ./ repmat(sum(abs(fts),2),1,size(fts,2));
            fts = zscore(fts,1);
        case 'l2_zscore'
            fts = fts ./ repmat(sqrt(sum(fts.^2,2)),1,size(fts,2));
            fts = zscore(fts,1);
        case 'l1'
            fts = fts ./ repmat(sum(abs(fts),2),1,size(fts,2));
        case 'l2'
            fts = fts ./ repmat(sqrt(sum(fts.^2,2)),1,size(fts,2));
        case 'none'
            return;
        otherwise
            error('norm');
    end
end
