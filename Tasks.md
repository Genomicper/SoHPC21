# Project tasks

## Setting up and background knowledge

Things to do/look at:

1. Install R from [CRAN](https://cran.r-project.org/) also install Rtools (if you are using windows).
2. Install [RStudio](https://www.rstudio.com/products/rstudio/).
3. Familiarise yourself with R. There are a whole bunch of good free R books at:
   * https://bookdown.org/
   In particular the R packages book:
   * https://r-pkgs.org/
   I don't think you need to know much R to work your way through this and you will be working with an R package.
   There are some other good books available here. For a more basic R tutorial look at what the Carpentries have, for instance:
   * http://swcarpentry.github.io/r-novice-gapminder/
   I have a minimised version of this course I have used in the past at:
   * https://github.com/marioa/trieste
4. You will want to install git for windows though if you have GitHub Desktop you will probably already have it. RStudio supports git and you are better using this over GitHub Desktop. To install the command line client go to:
   * https://git-scm.com/download/win
   then have a look at:
   * https://happygitwithr.com/
   Once you move on to remote computers you will probably need to learn a bit about the command line, have a look at:
   https://git-scm.com/book/en/v2
   Possibly up to the end of chapter 3 - don't worry if you do not get it all in one go. I am still learning and I have been using this for years.

## Project tasks

These are possible longer term tasks to undertake:

* Baseline performance
* Create regression tests
* If code left in R, important to maintain the environment as it is now. Migrate from read.table, data.frame etc to data.table (fread, https://cran.r-project.org/web/packages/data.table/vignettes/datatable-intro.html). Compare using data.table full functionality with data.table for reading data in and tidyverse for data manipulation Parallelisation and optimisation of SNP and Gene permutations (maybe https://nceas.github.io/oss-lessons/parallel-computing-in-r/parallel-computing-in-r.html is useful). Benchmarking
* Parallelisation and optimisation of SNP and Gene permutations (maybe https://nceas.github.io/oss-lessons/parallel-computing-in-r/parallel-computing-in-r.html is useful). Benchmarking

* Re-write in in C/C++ and embed the code in R. Potential issues with paaralellisationin C/C++ are:
   (a) problems with 'core count' software grabs. I'm sure there is a proper way of saying this (autodetect vs determine cores to to be used). 
   (b) setting random seed in a comparable way to R to make results comparable in the analysis (nothing to do with making R and C the same)
* Extra: visualisation, try to visualise pathways. Maybe of interest for student interested in biology.
