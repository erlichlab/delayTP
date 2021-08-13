%% master.m
% master script that calls individual functions to generate each figure.
% These functions use shared lab code that are a submodule included here:
% https://github.com/erlichlab/elutils/git

addpath '../../../elutils'; % This adds the helper functions that are used for the figures.

%% Fig 2 A
fig2a()

%% Fig 3 F-H
fig3fh()

%% Fig 4 A-C Left and Center Panels
fig4abc_lc()

%% Fig 4 A-C Right Panels
fig4abc_r()