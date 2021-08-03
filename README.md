# Pairwise Dependence-based Unsupervised Feature Selection (DUFS) [[Paper]](https://www.sciencedirect.com/science/article/pii/S0031320320304660)

```bash
@article{LIM2021107663,
title = {Pairwise dependence-based unsupervised feature selection},
journal = {Pattern Recognition},
volume = {111},
pages = {107663},
year = {2021},
issn = {0031-3203},
doi = {https://doi.org/10.1016/j.patcog.2020.107663},
url = {https://www.sciencedirect.com/science/article/pii/S0031320320304660},
author = {Hyunki Lim and Dae-Won Kim},
keywords = {Unsupervised feature selection, Feature dependency, Feature redundancy, Joint entropy,  regularization},
abstract = {Many research topics present very high dimensional data. Because of the heavy execution times and large memory requirements, many machine learning methods have difficulty in processing these data. In this paper, we propose a new unsupervised feature selection method considering the pairwise dependence of features (feature dependency-based unsupervised feature selection, or DUFS). To avoid selecting redundant features, the proposed method calculates the dependence among features and applies this information to a regression-based unsupervised feature selection process. We can select small feature set with the dependence among features by eliminating redundant features. To consider the dependence among features, we used mutual information widely used in supervised feature selection area. To our best knowledge, it is the first study to consider the pairwise dependence of features in the unsupervised feature selection method. Experimental results for six data sets demonstrate that the proposed method outperforms existing state-of-the-art unsupervised feature selection methods in most cases.}
}
```

## Abstract

This program (DUFS) is designed to perform the feature selection for unsupervised condition. This method assumes pattern-feature matrix typed data set.

This software is a Matlab implementation of proposed method. The original version of this program was written by Hyunki Lim. We also provide codes for 10 conventional unsupervised feature selection methods; MaxVar, LS, MCFS, UDFS, NDFS, SOCFS, EUFS, RSR, DISR, and IUFS. You can find detailed information in our manuscript.


## Download

This program is available for download for non-commercial use, licensed under the GNU General Public License, which is allows its use for research purposes or other free software projects but does not allow its incorporation into any type of commerical software.

[[Download Feature Selection Program]](http://air.cau.ac.kr/softwares/dufs/programs.zip)

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
