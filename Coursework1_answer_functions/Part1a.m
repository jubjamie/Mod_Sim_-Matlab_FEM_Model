function [] = Part1a()
%This fuction runs the nessusary codes to complete part 1a of the
%coursework sheet. This can be found in the documents folder.

PathAdd(); % Run the funciton that adds all the nessusary folders to the path

% RUN TESTS TO ENSURE LAPLACEELEMENTMATRIX FUNCTIONS CORRECTLY
results = runtests('CourseworkOneUnitTest'); % This line runs the test designed to check LaplaceElemMatrix runs correctly

% Part 1a of the course work is completes if all the tests in the above
% code run successfully and withoug fault.

% CHECK THAT ALL TESTS WERE PASSED
if results(1).Passed == 1 && results(2).Passed == 1 && results(3).Passed==1
    disp('All tests passed. Part 1a complete') % If all were compelte display this
else
    error('not all tests in "CourseworkOneUnitTest" were passed. edit LaplaceElemMatrix.m and try again') % If not all tests were complete give an error

end

