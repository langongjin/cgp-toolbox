cgp = cgptoolbox.CGP(struct( ...
    'rows', 1, ...
    'columns', 10, ...
    'levels_back', 10, ...
    'output_type', 'random', ...
    'runs', 100, ...
    'outputs', 1, ...
    'generations', 8000, ...
    'offsprings', 4, ...
    'mutation', 0.2, ...
    'fitness_solution', 0.01, ...
    'fitness_operator', '<=' ...
));

a = zeros(1, 50);
b = zeros(1, 50);
index = 1;
for x = -1:2/49:1
    a(index) = x^6 - 2*(x^4) + x^2;
    b(index) = x;
    index = index + 1;
end

cgp.addInputs( ...
    struct( ...
        'points', struct('x', b, 'y', a), ...
        'scalar', 1 ...
    ) ...
);

%cgp.addParameters( ...
%   struct(                                ...
%       'name', 'interval',                ...
%       'initialize', @()rand(),           ...
%       'mutate', @(x)x + rand()           ...
%   ), ...
%   struct(                                ...
%       'name', 'interval',                ...
%       'initialize', @()rand(),           ...
%       'mutate', @(x)x + rand()           ...
%   ) ...
%);

cgp.addCallbacks(struct( ...
   'NEW_GENERATION', @(args)fprintf('run %d - generation %d - %.12f\n',args.run, args.generation, args.fitness) ...
));

cgp.addFunctionsFromPath('function-set/');
cgp.addFitnessFunction(@fitness);

cgp.run();
