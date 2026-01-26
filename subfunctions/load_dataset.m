function [X, labels] = load_dataset(name)
    data = load(name);
    X = data.X; labels = data.gt;
end