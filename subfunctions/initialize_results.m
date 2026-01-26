<<<<<<< HEAD
function results = initialize_results(setup)
    results = struct();
    for i = 1:length(setup.datasets)
        results(i).Dataset = setup.datasets{i};
        results(i).Methods = setup.methods;
        results(i).Metrics = struct('ACC',[], 'NMI',[], 'Purity',[], 'Fscore',[]);
    end
=======
function results = initialize_results(setup)
    results = struct();
    for i = 1:length(setup.datasets)
        results(i).Dataset = setup.datasets{i};
        results(i).Methods = setup.methods;
        results(i).Metrics = struct('ACC',[], 'NMI',[], 'Purity',[], 'Fscore',[]);
    end
>>>>>>> f6a4ed6 (master)
end