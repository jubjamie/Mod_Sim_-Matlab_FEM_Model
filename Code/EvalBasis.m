function [ psi ] = EvalBasis(lnid,xipts)
%EvalBasis Evaluates linear Lagrange basis functions
% Given the local node id (lnid) for a linear Lagrange element, and a xi
% coordinate (between [-1,1]), returns the correpsonding value of the
% basis function for that local node, at that xi point

sign = (-1)^(lnid+1);
psi = 0.5*(1 + ((sign*xipts))); %Basis Function at a given gauss point

end