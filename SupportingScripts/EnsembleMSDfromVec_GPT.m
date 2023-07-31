function MSD = EnsembleMSDfromVec_GPT(TimeIndex, Xvec, Yvec)
    [m, n] = size(Xvec);

    if size(TimeIndex, 2) == 1
        for i = 1:n - 1
            TimeIndex(:, i + 1) = TimeIndex(:, 1);
        end
    end

    TimeStep = diff(TimeIndex, 1, 1);
    StepMatrix1 = (TimeStep == 1);
    Num1steps = sum(StepMatrix1, 'all');
    CalcMatrix(:,:,1) = TimeStep;
    CalcMatrix(:,:,2) = Xvec;
    CalcMatrix(:,:,3) = Yvec;

    MSD = NaN(Num1steps, (max(TimeIndex, [], 'all', 'omitnan') - min(TimeIndex, [], 'all', 'omitnan')));
    Counters = zeros(1, (max(TimeIndex, [], 'all', 'omitnan') - min(TimeIndex, [], 'all', 'omitnan')));

    for i = 1:m
        TempMatrix = custom_movmean(CalcMatrix, i, 1);
        Tmin = min(TempMatrix(:,:,1), [], 'all');
        Tmax = max(TempMatrix(:,:,1), [], 'all');

        for j = Tmin:Tmax
            Temp2 = (TempMatrix(:,:,1) == j);
            k = find(Temp2);
            X = TempMatrix(:,:,2);
            Y = TempMatrix(:,:,3);
            MSD(Counters(j) + 1:Counters(j) + sum(Temp2, 'all'), j) = X(k).^2 + Y(k).^2;
            Counters(j) = Counters(j) + sum(Temp2, 'all');
        end

        disp(['Min: ', num2str(Tmin), ' Max: ', num2str(Tmax)]);
    end
end

function out = custom_movmean(A, window_size, dim)
    A_cumsum = cumsum(A, dim);
    out = A;
    
    if dim == 1
        A_cumsum_shift = [zeros(1, size(A, 2), size(A, 3)); A_cumsum(1:end-1, :, :)];
    elseif dim == 2
        A_cumsum_shift = [zeros(size(A, 1), 1, size(A, 3)), A_cumsum(:, 1:end-1, :)];
    else
        error('custom_movmean supports only dim values 1 and 2');
    end

    out = A_cumsum - A_cumsum_shift;
    out(1:window_size, :, :) = A_cumsum(1:window_size, :, :);
end