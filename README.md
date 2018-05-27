# HopLand
Single-cell pseudotime recovery using continuous Hopfield network based modeling of Waddington’s epigenetic landscape

## Dependencies
The MATLAB package of GPmat and a fast marching toolbox are required. They can be downloaded from 

-- fast marching toolbox: https://www.ceremade.dauphine.fr/~peyre/teaching/manifold/matlab/toolbox_fast_marching.zip
or http://histone.sce.ntu.edu.sg/HopLand/toolbox_fast_marching.zip

-- GPmat: https://github.com/SheffieldML/GPmat (It recommends that you also include netlab (https://github.com/sods/netlab) as a dependency)


After downloading the required packages, unzip them to your working directory and add the directories to your MATLAB path. 


## Installation
1. Download the MATLAB source code. 
2. Unzip it to your desired location. 

## Example 

Dataset: GUO2010 

Data type: qPCR

Source: Guo G, Huss M, Tong GQ, et al. Resolution of Cell Fate Decisions Revealed by Single-Cell Gene Expression Analysis from Zygote to Blastocyst. Dev Cell. 2010. doi:10.1016/j.devcel.2010.02.012.

Number of cells: 438

Number of genes: 48

Description: Early mouse embryonic development

Stages: 1-cell, 2-cell, 4-cell, 8-cell, 16-cell, 32-cell, 64-cell stages

# Results

<img src='./images/fig_2_a.png/' width='400px' height='400px'/>
(a)
<img src='./images/fig_2_b.png/' width='400px' height='400px'/>
(b)

Figure 1. (a) The Waddington's epigenetic landscape recovered using HopLand. (b) The contour plot of the constructed Waddington's epigenetic landscape. The dots are colored according to the developmental stages of the represented cells.


<img src='./images/fig_4.png/' width='400px' height='400px'/>

Figure 2. The minimum spanning tree constructed from Waddington's epigenetic landscape. The dots are colored according to the developmental stages of the cells in the dataset of GUO2010.


## Contact
Please send your suggestions, comments, reports of bugs and errors to <a href="zhengjie_2001@hotmail.com">Jie Zheng</a>. Thank you!
