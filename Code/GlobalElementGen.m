function [Global_Mat] = GlobalElementGen(xmin, xmax, Ne, D, llambda, reactionNeeded)
% Given the relevent input paramenters this cod ewill generate the local
% element matracies for each element and combign these to form the global
% element matrix for both the diffution operator and the reaction operator
% if needed.
%   Where:
%   xmin = the mimimum value of x to be used when generating the mesh.
%   xmax = the maxmum value of x to be used when generating the mesh.
%   Ne = Number of elements to be used when generating the mesh.
%   D = Diffution operator used when generating the local element matracies
%       for diffution.
%   llambda = Scalar coefficient used when generating the lcoal element
%             matracies for reaciton operator.
%   ReactionNeeded = This is either 1 is the global element matrix for the
%                   reaction operator needs to be generatod or 0 if it does not need to be
%                   gerenated.

msh = OneDimLinearMeshGen(xmin,xmax,Ne); % Generate the mesh

% GENERATE LOCAL ELEMENT MATRACIERS FOR ALL ELEMENTS
for i = 1:Ne
    Diffusion(i).Local = LaplaceElemMatrix(D, i, msh); % Generate the local element diffution matrix for element i
    
    if reactionNeeded == 1 % Check if the reaction matrix is required
        Reaction(i).Local = LocalElementMat_Reaction(llambda, i, msh); % Generate the local element reaction matrix for element i
        Overall(i).Local = Diffusion(i).Local - Reaction(i).Local;% Calculate the overall local element matrix of the left hand side of the equation if the reaction term is needed
    else
        Overall(i).Local = Diffusion(i).Local; % Calculate the overall local element matrix of the left hand side of the equation if the reaction term isn't needed
    end
end

Global_Mat = zeros(Ne+1); % Generate blank global matrix for population.

% GENREATE THE GLOBAL MATRIX
for i = 1:Ne
    Global_Mat(i:i+1,i:i+1) =  Global_Mat(i:i+1,i:i+1)+Overall(i).Local;
end

4

end
