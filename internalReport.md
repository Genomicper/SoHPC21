## Project Achievements												2021-08-24

A summary for the project of what has been tried, what worked and what did not work.

* `fread ` and `vroom` functions tried reading the data sets. `vroom` was faster for the 8M case. However,   `vroom`  come up with two additional issues:

  - There was a `locale` issue on Windows on a machine with a Turkish locale `vroom::locale()` gave an error. We could not fix this in RStudio using a `.RProfile` file and setting the locale explicitly: `Sys.setlocale(category = "LC_ALL", locale = "Turkish")`. There was some connection with finding `tzdb`.
  - On a Windows system that seemed to be related to this [issue](https://github.com/r-lib/vroom/issues/40) - the data file needed to have an extra line at the end when read in by a windows machine.

  On the meeting 03/08/21 it was decided that `vroom` gave the best performance but was introducing too many issues so we would go back on to use `fread`. 

*  `rbindlist` function tried instead of `rbind` in `genome_order_v2.R` (see in Line 38) . However `rbindlist` caused a problem because of the `data.frame`.

* İrem's machine didn't cope with the more than 1M data sets.

* In `read_pvals_v2.R` at line 35 ` all_data <- merge(all_snps, data, by = "name", all.x = FALSE, all.y = TRUE, incomparables = "NA")`  used `inner_join()` instead of `merge()` .` inner_join()` function is much faster on larger data sets.

*  Trying a pvalues threshold be another optimisation strategy. **(ongoing)**

* Trying to change the `which` in `read2_paths_v2.R`.**(ongoing)** (See in below the profile of the 1M data set)

![image](C:\Users\asus\OneDrive\Masaüstü\image.PNG)

