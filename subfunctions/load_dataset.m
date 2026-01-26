<<<<<<< HEAD
function [X, labels] = load_dataset(name)
    data = load(name);
    X = data.X; labels = data.gt;
=======
function [X, labels] = load_dataset(name)
    data = load(name);
    X = data.X; labels = data.gt;
>>>>>>> f6a4ed6 (master)
end