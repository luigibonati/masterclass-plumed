# Masterclass 22.05: Machine learning collective variables with Pytorch

This lesson was given as part of the PLUMED masterclass series in 2022.  It includes:

* A first videos that describes the theory.
* Python notebooks that contain the exercises.
* A second video with the discussion and the solution of the exercises. 
* Python notebooks containing the solution to the exercises.

The flow chart shown below indicates the order in which you should consult the resources.  You can click on the nodes to access the various resources.  Follow the thick black lines for the best results.  The resources that are connected by dashed lines are supplmentary resources that you may find useful when completing the exercise.

This lesson was the fifth masterclass in the 2022 series.

```mermaid
flowchart TB;
  A[ref1] -.-> E[Lecture I];
  B[ref2] -.-> E;
  C[ref3] -.-> E;
  D[ref4] -.-> E;
  E ==> F[Instructions];
  F ==> G[Install];
  G ==> H[DeepLDA notebook];
  G ==> I[DeepTICA notebook];
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
  click M "solutions/tutorial1_DeepLDA.ipynb" "A python notebook with the solutions of the exercises on DeepLDA";
  click N "solutions/tutorial2_DeepTICA.ipynb" "A python notebook with the solutions of the exercises on DeepTICA";
```
