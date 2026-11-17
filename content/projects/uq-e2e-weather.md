+++
title = "UQ for End-to-End AI Weather Models"
date = 2026-08-31
lastmod = 2026-11-17
description = "Making end-to-end AI weather forecasting probabilistic and disentangling observation and model uncertainty."
tags = ["AI for Science", "Weather Forecasting", "Uncertainty Quantification", "End-to-End Forecasting", "Deep Learning"]
+++

### Project Overview
End-to-end weather forecasting systems produce skillful global gridded and station forecasts directly from raw Earth observations, replacing the numerical weather prediction pipeline, including data assimilation, at a fraction of its cost. These systems are deterministic and issue no uncertainty.

In this project we render the [Aardvark Weather](https://doi.org/10.1038/s41586-025-08897-0) model probabilistic by attaching one stochastic mechanism to each component of its encode-process-decode pipeline:

- **Learned, input-dependent noise at the observation encoder**, aimed at the uncertainty inherited from the observing system.
- **Monte Carlo dropout in the processor**, aimed at the uncertainty of the learned dynamics.

The resulting nested ensemble attributes forecast spread to the two sources through a law-of-total-variance decomposition, cross-checked by withholding observation streams (observing-system experiments). After the two components are finetuned separately, the whole chain is finetuned end-to-end against either the gridded (ERA5) or the station (HadISD) target.

![End-to-end ensemble architecture with encoder noise and processor dropout](/uq-e2e-weather-architecture.png)
*The deterministic encode-process-decode pipeline uplifted to a stochastic map. Encoder noise (blue) captures observation and assimilation uncertainty, Monte Carlo dropout (orange) captures model and dynamics uncertainty, and the decoder remains deterministic. The encoder and processor are first finetuned separately against a CRPS objective (1, 2), then the whole chain is finetuned end-to-end against gridded (3) or station (4) targets. The nested rollout decomposes the total variance into the two components.*

### Key Findings
- **Probabilistic finetuning improves the mean forecast** by 11% on average across variables and lead times, significantly for all 60 variable and lead time combinations.
- **The ensemble has more decision value than the deterministic model**: its maximum relative economic value for extremes (above the 90th and below the 10th percentile) is 0.15 to 0.31 higher at every lead time. By day 10 the ensemble keeps 0.32 of a perfect forecast's value, while the deterministic forecast falls to 0.07.
- **The ensemble is close to calibrated against ERA5** through the medium range, with an average spread-skill ratio of 0.96 over days 1 to 10. It still trails the operational ECMWF IFS ensemble in CRPS.
- **Station forecasts are at least as accurate as the deterministic model**: for 2-m temperature the ensemble mean is tied with it at day 1 and significantly better from day 2 on. For 10-m wind speed it is 10 to 17% better at every lead time.
- **The encoder branch behaves as observation-driven uncertainty**: denying satellite sounder observations raises the encoder variance by up to 84% while leaving the dropout variance nearly unchanged.
- Component-attributed uncertainty makes end-to-end forecasts more transparent, a step toward observation-driven digital twins of the atmosphere.

### Papers
**[Uncertainty-Aware End-to-End AI Weather Forecasting: Disentangling Observation and Model Contributions](https://arxiv.org/abs/2608.30795)**  
*Preprint, v2 posted 9 November 2026 (v1: 31 August 2026)*  
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
