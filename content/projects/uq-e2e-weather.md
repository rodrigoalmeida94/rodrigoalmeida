+++
title = "UQ for End-to-End AI Weather Models"
date = 2026-08-31
description = "Making end-to-end AI weather forecasting probabilistic and disentangling observation and model uncertainty."
tags = ["AI for Science", "Weather Forecasting", "Uncertainty Quantification", "End-to-End Forecasting", "Deep Learning"]
+++

### Project Overview
End-to-end weather forecasting systems produce skillful global gridded and station forecasts directly from raw Earth observations, replacing the numerical weather prediction pipeline, including data assimilation, at a fraction of its cost. These systems are deterministic and issue no uncertainty.

In this project we render the [Aardvark Weather](https://doi.org/10.1038/s41586-025-08897-0) model probabilistic by attaching one stochastic mechanism to each component of its encode-process-decode pipeline:

- **Learned, input-dependent noise at the observation encoder**, capturing aleatoric uncertainty inherited from the observing system.
- **Monte Carlo dropout in the processor**, capturing epistemic uncertainty in the learned dynamics.

The resulting nested ensemble attributes forecast spread to the two sources through a law-of-total-variance decomposition, cross-checked by withholding observation streams (observing-system experiments).

![End-to-end ensemble architecture with encoder noise and processor dropout](/uq-e2e-weather-architecture.png)
*The deterministic encode-process-decode pipeline uplifted to a stochastic map. Encoder noise (blue) captures observation and assimilation uncertainty, Monte Carlo dropout (orange) captures model and dynamics uncertainty, and the decoder remains deterministic and frozen. The nested rollout decomposes the total variance into the two components.*

### Key Findings
- **Probabilistic finetuning improves the mean forecast** by 4.2% on average across variables and lead times.
- **The ensemble is calibrated against ERA5** through the medium range, with a spread-skill ratio of 0.98.
- **Station forecasts stay sharp**: station RMSE remains within 2.4% of the deterministic model while beating it in CRPS at every lead time, trailing the operational ECMWF ensemble.
- **The encoder branch behaves as observation-driven uncertainty**: denying satellite sounder observations inflates the encoder variance while leaving the dropout variance unchanged.
- Component-attributed uncertainty makes end-to-end forecasts more transparent, a step toward observation-driven digital twins of the atmosphere.

### Papers
**[Uncertainty-Aware End-to-End AI Weather Forecasting: Disentangling Observation and Model Contributions](https://arxiv.org/abs/2608.30795)**  
*Preprint, submitted 31 August 2026*  
DOI: [10.48550/arXiv.2608.30795](https://doi.org/10.48550/arXiv.2608.30795)  
Rodrigo Almeida, Noelia Otero, Jost Arndt, Simon Baur, Wojciech Samek, Jackie Ma.

### Data
The finetuned model weights and evaluation data are available on [Hugging Face](https://huggingface.co/datasets/rodrigoalmeida1994/uqe2e).

### Related Work
This project builds on [UQ for AI Weather Models]({{< relref "projects/uq-ai-weather.md" >}}), which evaluated input perturbations of deterministic AI weather models on extreme events.

### Conference Presentations
**[5th ECMWF-ESA Machine Learning Workshop](https://events.ecmwf.int/event/488/contributions/5732/attachments/3559/5998/Poster_Almeida.pdf)**  
*April 13, 2026, Bologna, Italy*  
Poster: "Towards Disentangling Predictive Uncertainty in End-to-End AI Weather Forecasts"
