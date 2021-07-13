snps_permutation_v2 <-
function(ordered_alldata = "", pers_ids = "", ntraits = "",
         nper = 100, threshold = 0.05, seed = 10, saveto = "workspace",
         gs_locs = "", envir = "") {

    cat("Arguments: \n")
    cat("\tOrdered dataset: ", substitute(ordered_alldata), "\n",
        sep = "")
    cat("\tIndexes of SNP Annotations: ", substitute(pers_ids), "\n")
    cat("\tIndexes of Traits to Analyse:", as.numeric(ntraits), "\n")
    cat("\tTraits:", colnames(ordered_alldata)[as.numeric(ntraits)], "\n")
    cat("\tNumber of permutations: ", nper, "\n")
    cat("\tThreshold: ", threshold, "\n")
    cat("\tPermutation Results save to: ", substitute(saveto), "\n")

    if (saveto != "workspace" & saveto != "directory") {
         stop("Define where are the results to be saved:
              \"saveto\"=\"workspace\" OR \"directory\"")
    }
    ntraits <- as.numeric(ntraits)
    nper <- as.numeric(nper)
    threshold <- as.numeric(threshold)
set.seed(as.numeric(seed), kind = "Mersenne-Twister")
    temp <- ordered_alldata[, c(1:6, ntraits)]
    ns <- which(pers_ids != "NULL")
    if (length(ns) == 0) {
        stop("No SNPs mapped to the gene-sets")
    }
    pers_ids <- pers_ids[ns]
    paths_list <- names(pers_ids)
    mx_rs <- dim(temp)[1]
    sd <- round(runif(nper, 1, mx_rs))
    rowsf <- dim(gs_locs)[1]
    tname <- NULL
    lab <- NULL
    i <- NULL
    ids <- NULL
    j <- NULL
    k <- NULL
    date()
    all_ts <- NULL
    listf <- as.numeric(as.character(gs_locs[, 4]))
    for (i in seq_len(length(paths_list))) {
        per_mat <- matrix(data = NA, nrow = length(sd) + 3,
                          ncol = length(temp) - 6)
        colnames(per_mat) <- colnames(temp)[7:length(temp)]
        path_name <- strsplit(paths_list[i], split = "[_]")[[1]][3]
        cat(path_name, "\n")
        indxs <- pers_ids[[i]]
        for (j in 7:length(temp)) {
            temp2 <- temp[, j]
            big_count <- 0
            sig_snps_real <- 0
            for (k in seq_len(length(sd))) {
                if (k == 1) {
                  per_mat[1, j - 6] <- sig_snps_real <- length(which(temp[indxs,
                    j] <= threshold))
                }
                count <- 0
                fkindxs <- sapply(indxs, sum, sd[k])
                mayores <- which(fkindxs > mx_rs)
                menores <- which(fkindxs <= mx_rs)
                count <- length(which(temp2[fkindxs[menores]] <=
                  threshold))
                if (length(mayores) != 0) {
                  for (m in seq_len(length(mayores))) {
                    fkindxs[mayores[m]] <- fkindxs[mayores[m]] -
                      mx_rs
                  }
                  count <- count + length(which(temp2[fkindxs[mayores]] <=
                    threshold))
                }
                per_mat[k + 1, j - 6] <- count
                if (count > sig_snps_real) {
                  big_count <- big_count + 1
                }
            }
            per_mat[k + 2, j - 6] <- big_count
            per_mat[k + 3, j - 6] <- big_count / length(sd)
        }
        rownames(per_mat) <- c("Real_Count", seq_len(length(sd)), "All_Count",
            "Score")
        if (saveto == "directory") {
            write.table(per_mat, file = paste("Permus_", path_name,
                ".txt", sep = ""), sep = "\t", row.names = T,
                col.names = T, quote = F)
        }
        if (saveto == "workspace") {
            assign(paste("Permus_", path_name, sep = ""), per_mat,
                envir = envir)
        }
    }
}
