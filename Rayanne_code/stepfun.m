function stepy = stepfun(t,nsteps,maxp,delay)
%Creates stair-step function used to measure 16 s pressure-volume loop
%   Uses tanh functions for smoothness

difp = maxp/nsteps;
tw = 0.1; % make narrow tanh
step_up = @(t, t0, tw) 0.5*difp + 0.5*difp*tanh((t - t0)/tw);
step_down = @(t, t0, tw) -0.5*difp - 0.5*difp*tanh((t - t0)/tw);

t0 = (0:1:t(end))+delay;
sms = zeros(length(t), length(t0));
for i = 1:length(t0)
    if i <= 8
        sms(:, i) = step_up(t, t0(i), tw);
    elseif i > 8
        sms(:, i) = step_down(t, t0(i), tw);
    end
end
stepy = sum(sms, 2);

end

