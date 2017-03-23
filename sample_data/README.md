1. Guo2010:  

Data type: qPCR
Source: Guo G, Huss M, Tong GQ, et al. Resolution of Cell Fate Decisions Revealed by Single-Cell Gene Expression Analysis from Zygote to Blastocyst. Dev Cell. 2010. doi:10.1016/j.devcel.2010.02.012.
Number of cells: 438
Number of genes: 48
Description: Early mouse embryonic development
Stages: 1-cell, 2-cell, 4-cell, 8-cell, 16-cell, 32-cell, 64-cell stages
Preprocessing: normalized 

2. Deng2014:

Data type: scRNA-seq
Source: Deng Q, Ramsköld D, Reinius B, et al. Single-Cell RNA-Seq Reveals Dynamic, Random Monoallelic Gene Expression in Mammalian Cells. Science (80- ). 2014;343(6167):193-196. doi:10.1126/science.1245316.
				We collected this dataset from SCUBA sample data
Number of cells: 317
Number of genes: 1000
Description: Mouse preimplantation embryos development
Stages: Zygote, 2-cell embryo, Early 2-cell blastomere, Mid 2-cell blastomere, 4-cell blastomere, 8-cell blastomere, 16-cell blastomere,  Early blastocyst cell, Mid blastocyst cell, Late blastocyst cell, fibroblast, adult liver
Preprocessing: normalized 


3. Synthetic data

Data type: synthetic
Source: Zwiessele M, Lawrence ND. Topslam: Waddington Landscape Recovery for Single  Cell Experiments. doi:10.1101/057778.
				The 5 datasets were simulated using the function "simulate_new_Y_qPCR" with 5 differentiation patterns of cells (Fig. 2 in Topslam paper). 
Number of cells: 438-490 
Number of genes: 48
Description: Simulated differentiation processes along cell stages
Stages: timporal information 
Preprocessing: None


4. Yan2013

Data type: scRNA-seq
Source: Yan L, Yang M, Guo H, et al. Single-cell RNA-Seq profiling of human preimplantation embryos and embryonic stem cells. Nat Publ Gr. 2013. doi:10.1038/nsmb.2660.
Number of cells: 124
Number of genes: 125
Description: human preimplantation embryos and human embryonic stem cells (hESCs)
Stages: Oocyte, Zygote, 2-cell, 4-cell, 8-cell, Morulae, Late blastocyst and hESC
Preprocessing: normalized; differentially expressed genes

5. LPS

Data type: scRNA-seq
Source: Amit I, Garber M, Chevrier N, et al. Unbiased Reconstruction of a Mammalian Transcriptional Network Mediating Pathogen Responses. Science (80- ). 2009;326(5950):257-263. doi:10.1126/science.1179050.
Number of cells: 131
Number of genes: 42
Description: primary mammalian cells, Unstimulated cells and stimulated cells 
Stages: no timporal information, two types of cells
Preprocessing: filter out genes with low variances; normalized


6. HSMM 

Data type: scRNA-seq
Source: Trapnell C, Cacchiarelli D, Grimsby J, et al. The dynamics and regulators of cell fate decisions are revealed by pseudotemporal ordering of single cells. Nat Biotechnol. 2014;32(4):381-386. doi:10.1038/nbt.2859.
Number of cells: 271
Number of genes: 53
Description: differentiation of primary human myoblasts
Stages: no timporal information; four types, labeled T1, T2, T3 and T4 respectively
Preprocessing: filter out genes with low variances; normalized



7. ES_MEF

Data type: scRNA-seq
Source: Islam S, Kjällquist U, Moliner A, et al. Characterization of the single-cell transcriptional landscape by highly multiplex RNA-seq. Genome Res. 2011;21(7):1160-1167. doi:10.1101/gr.110882.110.
				We collected this dataset from Topslam sample data
Number of cells: 92
Number of genes: 35
Description: embryonic stem cells and 
Stages: no timporal information; two types
Preprocessing: filter out genes with low variances; normalized


