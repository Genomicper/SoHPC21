read_pvals_v2 <-
function(data_name = "", snps_ann = "", from = "workspace", verbose = FALSE) {


     if (verbose) {
       cat("Arguments set (read_pvals):\n")
       cat("\t", substitute(data_name), ",\n", sep = "")
       cat("\t", substitute(snps_ann), ",\n", sep = "")
       cat("\tfrom ", from, ".", sep = "")
    }
    if (from != "workspace" & from != "directory") {
       stop("Argument \"from\" must be set to \"workspace\" or \"directory\"")
    }
    if (missing(data_name) == TRUE) {
        stop("Argument data_name (GWAS p-values) missing")
    }
    if (missing(snps_ann) == TRUE) {
        stop("Argument snps_ann (SNPs location) missing")
    }
    if (from == "workspace") {
        data <- data_name
        all_snps <- snps_ann
    }
    if (from == "directory") {
        data <- fread(file = data_name,data.table = FALSE)
        all_snps <- fread(file = snps_ann,data.table = FALSE)
    }
    colnames(data)[1] <- "name"
    colnames(all_snps)[1] <- "name"
    all_data <- inner_join(all_snps, data, by = "name", all.x = FALSE,
                      all.y = TRUE, incomparables = "NA")
    return(all_data)
}

