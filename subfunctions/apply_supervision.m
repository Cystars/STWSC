function Z = apply_supervision(Z, Omega, B, beta)
    % 在约束位置注入监督信号
    for v = 1:size(Z,3)
        Z(Omega,:,v) = Z(Omega,:,v) + beta*B;
        Z(:,Omega,v) = Z(:,Omega,v) + beta*B';
    end
end