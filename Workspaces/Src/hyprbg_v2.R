hyprbg_v2 <-
function(sig_in_paths, unisig, gns_in_paths, universe) {
     gns_notin_paths <- universe - gns_in_paths
     phyper(sig_in_paths, gns_in_paths, gns_notin_paths, unisig,
            lower.tail = FALSE)
}
