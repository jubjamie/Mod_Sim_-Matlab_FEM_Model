function [LocalElementMat] = LaplaceElemMatrix(D, eID, msh, GN)
%This fuction calculates the local 2-by-2 element matrix for the diffusion
%operator, which can calculate this matrix for an arbitrary element eN
%defined between the points x0 and x1
%   D = diffusion coefficient
%   eID is the local element number
%   msh is the mesh data structure calcualted using
%       OneDimLinearMeshGen. From this mesh each elements Jacobian and the
%       nodal posisions x0 and x1 can be accesed.
%   GD = N value for Gaussiam Quadriture scheme

x0 = msh.elem(eID).x(1); %First X value of element being analysed
x1 = msh.elem(eID).x(2); % Second X value of element being analysed

% DEFINITION OF LIMITS OF THE STANDARD ELEMENT
Xi0 = -1; % The vlaue of Xi0
Xi1 = 1; % The vlaue of Xi1

% IMPLIMENTING GAUSSIAN QUADRATURE
N=GN;
[gq] = CreateGQScheme(N); %Creating the values of gaussian quadrature

% Run function to get dPhi_dXi
for i = 1:gq.npts
    dPsidXi(i) = EvalBasisGrad(i-1, 0);
end

J = msh.elem(eID).J; % Drawing in the Jacobian of the element ebing analysed

dXidx =1/J; % Calculating the value of dXi/dx

% Setting up initial values of the local element matrix
Int00 = 0;
Int01 = 0;
Int11 = 0;

for k=1:N
    % Calculating the first value (Int00) of the local element matrix
    Int00 = Int00 + gq.wi(k)*(D * dPsidXi(1) * dXidx * dPsidXi(1) * dXidx * J);
    % Calculating the second and third value (Int10/Int01) of the local element matrix
    Int01 = Int01 + gq.wi(k)*(D * dPsidXi(1) * dXidx * dPsidXi(2) * dXidx * J);
    % Calculating the final value (Int11) of the local element matrix
    Int11 = Int00 + gq.wi(k)*(D * dPsidXi(2) * dXidx * dPsidXi(2) * dXidx * J);
end


LocalElementMat = [Int00 Int01; Int01 Int00]; % For the lcoal element matrix

end