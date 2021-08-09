genome_order_v2 <-
function(all_data = "", verbose = FALSE) {

    if (verbose) {
       cat("Number of SNPs without location and removed: ",
           sum(is.na(all_data[, 2])), sep = "")
    }
    # Remove any NA values in the Chromosome column.
    all_data <- all_data[!is.na(all_data[, 2]), ]
    rowsf <- length(unique(sort(as.character(all_data[, 4]))))
    colsf <- length(all_data)
    colnames(all_data)[4] <- "GENE_ID"
    # Convert any columns from 7 that may be factors to numeric values - do
    # this only if the column is a factor.
    for (i in 7:colsf) {
        if (!is.factor(all_data[, i])) {
            next
        }
        all_data[, i] <- as.numeric(as.character(all_data[, i]))
    }
    or_data <- all_data
    or_data[, 2] <- as.character(or_data[, 2])

    lk <- as.character(1:50)
    ## Numeric Chromosomes
    x <- which(or_data[, 2] %in% lk)
    nums <- or_data[x, ]
    nums[, 2] <- as.numeric(nums[, 2])
    indx_nums <- order(nums[, 2], nums[, 3])
    nums <- nums[indx_nums, ]

    ## Chromosome LETTERS
    lets <- or_data[-c(x), ]
    indx_lets <- order(lets[, 2], lets[, 3])
    lets <- lets[indx_lets, ]

    # bind both datasets
    or_data <- rbindlist(nums, lets)
    # unique genes
    listf <- unique(sort(or_data[, 4]))
    gs_locs <- matrix(data = NA, nrow = rowsf, ncol = 6)
    for (j in seq_len(length(listf))) {
        ids <- which(or_data[, 4] == listf[j])
        obs <- length(ids)
        gs_locs[j, 1] <- as.character(or_data[ids[1], 5])
        gs_locs[j, 2] <- or_data[ids[1], 2]
        gs_locs[j, 3] <- or_data[ids[1], 3]
        gs_locs[j, 4] <- listf[j]
        gs_locs[j, 5] <- ids[1]
        gs_locs[j, 6] <- obs
    }
    lab <- c("Symbol", "Chromosome", "Location", "Gene_ID", "Start_Indx",
             "Observations")
    colnames(gs_locs) <- lab
    ordered_alldata <- or_data
    return(list(ordered_alldata = ordered_alldata, gs_locs = gs_locs))
}
