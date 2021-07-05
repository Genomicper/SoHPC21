# SoHPC21

This repo deals with a [PRACE Summer of HPC 2021 project](https://summerofhpc.prace-ri.eu/re-engineering-and-optimizing-software-for-the-discovery-of-gene-sets-related-to-disease/) to improve the genomicper R package.

The aims of this project are to understand the [circular permutation algorithm](https://pubmed.ncbi.nlm.nih.gov/22973544/) that underlies genomicper analysis and from this:

1. Profile and baseline the code performance to identify bottlenecks and opportunities for software improvement in performance and functionality.
1. Re-write the base algorithm in C/C++ and embed the code in R..
1. Benchmark and test the performance of any new algorithm with varying input sizes (e.g. 10/20 /30 million data points)

Any resulting code improvements should be contributed back to the existing CRAN R package.
