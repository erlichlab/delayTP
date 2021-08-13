# Julia

This folder contains a notebook that was written (by JCE) to do some final analyses for the response to reviewer. Figure S5 is constructed from two of the figures in this notebook.

The folder is a "self-contained" julia package in the sense that the following steps should get it running.

1. Clone this repository
2. Install Julia version 1.6.x 
3. Change into this directory and run `julia --project-. -e 'import Pkg; Pkg.instantiate()`
4. Once you get to the julia prompt run `using Pluto; Pluto.run(notebook=joinpath(pwd(), "scalar_timing.jl"))`

You can also take a look at `scalar_timing.html` which is a rendered version of the notebook. The main difference is that the notebook let's one include/exclude outliers with a checkbox to see how that changes the results.