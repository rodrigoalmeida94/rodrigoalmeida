+++
title = "UQ for AI Weather Models"
date = 2025-11-21
lastmod = 2026-08-25
description = "Evaluating the predictive skill of AI weather models for extreme events using uncertainty quantification. Published in Artificial Intelligence for the Earth Systems (AMS)."
tags = ["AI for Science", "Weather Forecasting", "Uncertainty Quantification", "Deep Learning", "Climate Change"]
+++

### Project Overview
Accurate prediction of extreme weather events remains a major challenge for AI-based weather prediction systems. Deterministic models such as FuXi, GraphCast and SFNO now rival numerical weather prediction in forecast skill, but they issue a single forecast without telling users how confident it is. This research asks whether perturbing the inputs of these models can turn them into ensembles that quantify uncertainty and capture extremes.

Using four perturbation strategies (Gaussian noise, Perlin noise, Hemispheric Centered Bred Vectors and Huge Ensembles), we generated 50-member ensembles for the August 2022 Pakistan floods and China heat wave, and complemented these case studies with a global threshold-based evaluation. Ensemble skill was assessed against ERA5 and compared with the ECMWF IFS ENS and AIFS ENS probabilistic systems using deterministic and probabilistic metrics.

![Global ROCSS decomposed by percentile threshold, model architecture and perturbation method across August 2022](/uq-ai-weather-aies-fig4.jpg)
*Global ROC skill score (ROCSS) for extremes in August 2022, decomposed by percentile threshold (left), model architecture (middle) and perturbation method (right). The similar spread across perturbation methods and the distinct spread across models show that the choice of model, not the perturbation, drives ensemble skill on extremes.*

### Key Findings
- **Model choice is the dominant factor** for ensemble performance, not the perturbation method. A two-way ANOVA attributes most of the variance in CRPS and RMSE to the model architecture.
- **Simple perturbations are competitive**: Gaussian and Perlin noise produce similarly realistic ensemble spread and probabilistic skill as the flow-dependent bred vector approaches (HCBV and HENS).
- **The gap to dedicated probabilistic systems is narrowed but not closed**: IFS ENS and AIFS ENS retain the highest probabilistic skill across variables.
- **Temperature extremes are captured more effectively than precipitation extremes** across all models.
- Input perturbations are a useful but limited tool, most relevant when hardware constraints preclude running dedicated probabilistic systems, and one of several directions toward reliable AI-driven early warning systems.

### Papers
**[On the Predictive Skill of Artificial Intelligence-Based Weather Models for Extreme Events Using Uncertainty Quantification](https://journals.ametsoc.org/view/journals/aies/5/3/AIES-D-25-0113.1.xml)**  
*Artificial Intelligence for the Earth Systems, Volume 5, Issue 3. Published 25 August 2026.*  
DOI: [10.1175/AIES-D-25-0113.1](https://doi.org/10.1175/AIES-D-25-0113.1)  
Rodrigo Almeida, Noelia Otero, Miguel-Ángel Fernández-Torres, Jackie Ma.

**[Can Artificial Intelligence Global Weather Forecasting Models Capture Extreme Events? A Case Study of the 2022 Pakistan Floods](https://www.climatechange.ai/papers/neurips2025/22)**  
*Presented December 2025*  
A focused case study comparing three deterministic data-driven models (FourCastNet v2/SFNO, GraphCast, and FuXi) against the ECMWF Integrated Forecasting System Ensemble.

### Related Work
The follow-up project [UQ for End-to-End AI Weather Models]({{< relref "projects/uq-e2e-weather.md" >}}) moves from input perturbations of deterministic models to disentangling observation and model uncertainty in end-to-end forecasting systems.

### Conference Presentations
**[NeurIPS 2025 Workshop on Tackling Climate Change with Machine Learning](https://www.climatechange.ai/papers/neurips2025/22)**  
*December 7, 2025, San Diego, USA*  
Poster: "Can Artificial Intelligence Global Weather Forecasting Models Capture Extreme Events? A Case Study of the 2022 Pakistan Floods"

**[3rd Workshop on Machine Learning for the Earth System](https://cesoc.net/key-insights-from-mlesm25/)**  
*August 25, 2025, Bonn, Germany*  
Oral Presentation: "Can AI weather models capture rare events? A case study of the 2022 Pakistan floods"
