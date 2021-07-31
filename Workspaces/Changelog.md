# Change Log

## Contents

* [Summary of changes](#summary-of-changes)
* [Input](#input)
* [Profiles](#profiles)

Keep track of changes.

## Summary of changes

## Input

Input of files was found to be quite expensive. The original code used `read.table`. Three alternative reading files were used:

* `read.table`
* `readr::read_table`
* `data.table::fread`
* `vroom`, see [here](https://www.tidyverse.org/blog/2019/05/vroom-1-0-0/)

For the first 3 cases reading the 8M data case `fread` gives the best performance (time in s):

![Reading data](./imgs/readingdata8Mboxplot.png)

![Performance of vroom vs fread using the 8M data case](./imgs/vroom8Mdata.png)

`vroom` is clearly faster for the 8M case but for the 30k data set `vroom` did not have the best performance:

![vroom vs fread for 30k data set](./imgs/vroomVsfread30k.png)

We found two additional two problems with vroom:

* There was a `locale` issue on Windows on a machine with a Turkish locale `vroom::locale()` gave an error. We could not fix this in RStudio using a `.RProfile` file and setting the locale explicitly: `Sys.setlocale(category = "LC_ALL", locale = "Turkish")`. There was some connection with finding `tzdb`.
* Other problem was also on a windows system which seemed to be related to this [issue](https://github.com/r-lib/vroom/issues/40) - the data file needed to have an extra line at the end when read in by a windows machine. Once we explicitly added a new empty line the file read in ok.

# Profiles

Add profiles in reverse chronological order.

### Profile 1

An early profile for the 8M data case using `profvis`.

![Early profile for the 8M data case](./imgs/profile1.png)

The `as.numeric` appearance is interesting and comes from lines like 13-15 from `genome_order.R`:

```R
    for (i in 7:colsf) {
        all_data[, i] <- as.numeric(as.character(all_data[, i]))
    }
```

This is converting `factors` into `numeric` values. Probably no longer necessary as from R4.0.0 the default when reading in data would be `stringsAsFactors = FALSE`.