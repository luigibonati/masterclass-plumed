# Masterclass 22.05: Machine learning collective variables with Pytorch

This Masterclass describes how to design data-driven collective variables using machine learning (ML) methods. In particular, two methods will be presented. In the first (DeepLDA), the CVs are optimized as classifiers to distinguish metastable states. In the second (DeepTICA) the slow modes of the simulations are extracted from a (biased) simulation and used as CVs. 

This lesson was given as part of the PLUMED masterclass series in 2022.  It includes:

* A first videos that describes the theory.
* Python notebooks that contain the exercises.
* A second video with the discussion and the solution of the exercises. 
* Python notebooks containing the solution to the exercises.

The flow chart shown below indicates the order in which you should consult the resources.  You can click on the nodes to access the various resources.  Follow the thick black lines for the best results.  The resources that are connected by dashed lines are supplmentary resources that you may find useful when completing the exercise.

This lesson was the fifth masterclass in the 2022 series.

```mermaid
flowchart TB;
  A[PLUMED Syntax] -.-> E[Lecture I];
  B[OPES] -.-> E;
  C[Ref: DeepLDA] -.-> E;
  D[Ref: DeepTICA] -.-> E;
  E ==> F[Instructions];
  F ==> G[Install];
  G ==> H[DeepLDA exercises];
  G ==> I[DeepTICA exercises];
  H ==> L[Lecture II];
  I ==> L;
  L ==> M[DeepLDA solutions];
  L ==> N[DeepTICA solutions]
  click A "ref1" "A previous tutorial that introduces the basics of PLUMED syntax";
  click B "ref2" "A paper on the OPES method";
  click C "ref3" "A paper that introduced the DeepLDA method that is used in the tutorial";
  click D "ref4" "A paper that describes the DeepTICA method that is used in the tutorial"; 
  click E "video1" "A lecture that was given on March 28th 2022 as part of the plumed masterclass series about machine learning collective variables";
  click F "INSTRUCTIONS.md" "Instructions for the exercises that you are supposed to complete";
  click G "INSTALL.md" "Instructions for installing the required software.";
  click H "tutorial1_DeepLDA.ipynb" "A python notebook that discusses the exercises on deepLDA";
  click I "tutorial2_DeepTICA.ipynb" "A python notebook that discusses the exercises on deepTICA";  
  click L "video2" "A lecture that was given on April 4th 2022 as part of the plumed masterclass series that goes through the solutions to the exercises in the lesson";
  click M "solutions/solution1_DeepLDA.ipynb" "A python notebook with the solutions of the exercises on DeepLDA";
  click N "solutions/solution2_DeepTICA.ipynb" "A python notebook with the solutions of the exercises on DeepTICA";
```

## References
1. Bonati, Rizzi and Parrinello, [Data-Driven Collective Variables for Enhanced Sampling](https://pubs.acs.org/doi/full/10.1021/acs.jpclett.0c00535), JPCL (2020)
2. Bonati, Piccini and Parrinello, [Deep learning the slow modes for rare events sampling](https://doi.org/10.1073/pnas.2113533118), PNAS(2021)
