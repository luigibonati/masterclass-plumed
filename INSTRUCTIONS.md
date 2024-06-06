# PLUMED Masterclass 22.5: Machine learning collective variables with Pytorch

## Origin 

This masterclass was authored by Luigi Bonati on March 28, 2022

## Aims

This Masterclass describes how to design data-driven collective variables using machine learning (ML) methods.

## Objectives

Once this Masterclass is completed, you will know how to:

- Design data-driven CVs in Python using Pytorch
- Deploy them in PLUMED via the PYTORCH_MODEL interface

## Prerequisites

We assume that you are familiar with PLUMED and enhanced sampling calculations. If you are not, the 2021 PLUMED Masterclass is a great place to start.  We will also use OPES to enhance sampling, which has been covered in another masterclass. 

Furthermore, Python knowledge is required for this masterclass.

## Overview

The identification of suitable collective variables (CVs) is crucial for the success of several enhanced sampling methods. Typically, the quest for CVs has been driven by physical intuition, however, the complexity of the systems that can be simulated nowadays calls for new approaches. 
For this reason, here we want to learn the CVs directly from molecular dynamics data. As in any machine learning approach, the three key ingredients will be (1) the data, (2) the model, and (3) the objective function. We note that these are tightly connected to each other. Indeed, depending on the kind of data that is available we can ask different questions. Furthermore, the ability to answer such questions (as well as to interpret the results) will depend on the choice of appropriate models. 

Broadly speaking, the CVs should represent the collective atomic movement as the system translocates from one metastable state to another.
As a general requirement, CVs should be continuous and differentiable functions of the atomic positions able to (1) distinguish the different states and (2) be connected to the slow modes of the system.
However, this results in a chicken and egg problem: if we have reactive trajectories that already explored the relevant phase space we might analyze such simulations and extract good CVs. But more often than not, for obtaining such reactive simulations we already need good CVs.
Here we describe two possible ways out of this chicken-and-egg situation, which reflects two scenarios that in the practice occur very often:

(1) Only the metastable states are known. These could be for instance the reactant and product of a chemical reaction, crystalline and liquid configurations of a material, the bound and unbound states of a ligand into a protein, etc... Given this limited data, we can guess the CVs by optimizing variables with a classification criterion.  This consists of enforcing only the first CV requirement stated above. Of course, one should not expect this to work as well as if one could add dynamic information on the transition paths, but it should be seen as a way to make the best out of limited knowledge. Very often the only information available is what the states of interest are, and so it is necessary to develop methods that can construct approximate CVs from this information. 

(2) We have an enhanced sampling simulation in which we have biased some CV, but with suboptimal results. Instead of proceeding by trial and error by changing the CVs until we find the right one(s), we can analyze such simulations and identify the slow degrees of freedom. If we can express them in a functional form and subsequently bias them we will be able to significantly improve sampling quality.

## Software and data 

The data needed to complete the exercises of this Masterclass can be found on [GitHub](https://github.com/luigibonati/masterclass-plumed/). 
To complete the exercises, we will go through a set of **Jupyter notebooks**, from which all the simulations can be performed and analyzed. 

Here you can find the [instructions](https://github.com/luigibonati/masterclass-plumed/blob/main/INSTALL.md) for installing the required software.
In particular, you will need to use the development version of PLUMED compiled with LibTorch, as well as GROMACS.
To run the simulations we will use GROMACS 2020.6 patched with PLUMED.

## Training CVs with Pytorch

In this tutorial, we will use [mlcvs](https://mlcvs.readthedocs.io/en/latest/), a Python-based package designed for building data-driven collective variables for enhanced sampling simulations. 
In `mlcvs` we have implemented different kinds of data-driven CVs proposed in the literature, including Deep-LDA and Deep-TICA which we describe in this masterclass.

> [!IMPORTANT]
> The mlcvs library has been renamed to [mlcolvar](https://mlcolvar.readthedocs.io) and integrated with many other functionalities. Check out the documentation for up-to-date tutorials and examples.
> 
> [<img src="https://raw.githubusercontent.com/luigibonati/mlcolvar/main/docs/images/logo_name_black_big.png" width="200" />](https://mlcolvar.readthedocs.io)

## Using the CVs in PLUMED

Once the models have been trained on the data, we can export them using the jit (just in time) compiler of Pytorch. This creates a Python-independent model, which can be loaded in PLUMED using Pytorch C++ APIs (LibTorch). Of particular relevance is that we can exploit the automatic differentiation feature of Pytorch to compute derivatives of the model with respect to the inputs. 
Note that in this way we can load the models exported from `mlcvs` as well as any other function built using Pytorch methods and serialized with jit. 

A typical PLUMED input might be the following, in which we first calculate some descriptors and feed them as inputs of the model.

```plumed
#SETTINGS AUXFILE=regtest/pytorch/rt-pytorch_model_2d/torch_model.ptc
phi: TORSION ATOMS=5,7,9,15
psi: TORSION ATOMS=7,9,15,17
model: PYTORCH_MODEL FILE=torch_model.ptc ARG=phi,psi
PRINT FILE=COLVAR ARG=model.node-0,model.node-1
```

## Exercises

The exercises are presented in the two Jupyter notebooks, from which all the simulations can be performed and analyzed. 
For this reason, this page only presents a high level overview of the contents of the notebooks.

### Toy system: alanine dipeptide

As done in some previous masterclass, we will play with a toy system, the small alanine dipeptide molecule in a vacuum (ala2).
This has the advantage of being a well-known system and it is cheap to simulate. 
The typical use case is to test enhanced sampling methods using as CVs the torsional angle $\phi$ and $\psi$. Since the former is an almost ideal CV for describing the transition between its two metastable states, this will typically result in a very efficient sampling. 
Here we want to approach this problem in a more blind way and try to design efficient CVs with as little knowledge as possible, learning the CVs directly from the output of molecular dynamics simulations.  

In both exercises, we will characterize the molecule with a general set of physical descriptors, which are the interatomic distances between heavy atoms. 
The reason for not working directly with atomic positions is twofold: on one hand, invariant CVs can be easily obtained under the relevant symmetries, while on the other, we can use different kind of descriptors to focus the sampling on the relevant processes.

### Tutorial 1: `Collective variables from equilibrium fluctuations

You can find the first tutorial in the jupyter notebook `tutorial1_DeepLDA.ipynb`. In this exercise, we will design the CVs starting only from a realization of the metastable states. 
The main steps will be the following:

1. Perform short unbiased MD simulations in the metastable states and evaluate a set of physical descriptors (e.g. interatomic distances between heavy atoms)
2. We train a neural-network based CV to discriminate between the states, using Fisher's discriminant as the objective function (DeepLDA)
3. Finally, we apply a bias potential to enhance the fluctuations of the DeepLDA CV and drive the system back and forth between the two states.

### Tutorial 2: Collective variables as slow modes of biased simulations

In the second exercise, which you can find in the notebook `tutorial2_DeepTICA.ipynb` , we will extract the CVs from biased simulations. As before, we will go through three main steps:

1. Perform an enhanced sampling calculation using some approximate CVs as well as generalized ensembles simulations (e.g. multicanonical).
2. Use the trajectory to train a neural-network based CV to find the maximally autocorrelated modes, which correspond to the slowest degrees of freedom (DeepTICA)
3. Bias these slow degrees of freedom to improve sampling
