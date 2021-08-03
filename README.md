# cau-air-softwares
CAU AIR Lab Public Codes

# Pairwise Dependence-based Unsupervised Feature Selection (DUFS) [[Paper]](https://www.sciencedirect.com/science/article/pii/S0031320320304660)

## Abstract

This program (DUFS) is designed to perform the feature selection for unsupervised condition. This method assumes pattern-feature matrix typed data set.

This software is a Matlab implementation of proposed method. The original version of this program was written by Hyunki Lim. We also provide codes for 10 conventional unsupervised feature selection methods; MaxVar, LS, MCFS, UDFS, NDFS, SOCFS, EUFS, RSR, DISR, and IUFS. You can find detailed information in our manuscript.


## Download

This program is available for download for non-commercial use, licensed under the GNU General Public License, which is allows its use for research purposes or other free software projects but does not allow its incorporation into any type of commerical software.

Download Feature Selection Program

Sample Input and Output

It will return the index of input features in orders of importance of the terms. This code can executed under Matlab command window.

## [Usage]:
   `>> idx = dufs( data, class_size, lambda1, lambda2, lambda3 );`

## [Description]
   data – a matrix that is composed of pattern-feature
   class_size – a scalar value represents the number of clusters
   lambda1 – weight for sparsity regularization of W
   lambda2 – weight for orthogonality constraint
   lambda3 – weight for redundancy of features
