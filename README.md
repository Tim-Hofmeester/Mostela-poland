# Mostela Poland
Repository for data and code for the manuscript: T.R. Hofmeester, J. Mos & K. Zub - Comparing direct (live-trapping) and indirect (camera-trapping) approaches for estimating the abundance of weasels (<i>Mustela nivalis</i>). Mammalian Biology

<b>Abstract</b>

Information on the presence and abundance of a species is crucial for understanding key ecological processes but also for effective protection and population management. Collecting data on cryptic species, like small mustelids, is particularly challenging and often requires the use of non-invasive methods. Despite recent progress in the development of camera trap-based devices and statistical models to estimate the abundance of unmarked individuals their application for studying this group of mammals is still very limited. We compared direct (live-trapping) and indirect (an enclosed camera-trapping approach – the Mostela system) survey methods to estimate the population size of weasels (<i>Mustela nivalis</i>) inhabiting open grasslands in Northeast Poland over a period of four years. We also live trapped voles to determine prey availability. We used a Royle-Nichols model to estimate yearly (relative) abundance from the camera-trapping data in a Bayesian framework. The total number of live-captured weasels showed a similar change over time as the relative abundance of weasels estimated using camera-trap data. Moreover, estimates of weasel abundance increased with the availability of their main prey. Our study is part of a growing body of work showing that camera traps can provide a useful non-invasive method to estimate the relative abundance of small mustelids. Moreover, a combination of data from camera traps with statistical models allowed us to track the changes in weasel number over time. This information could be very useful for the conservation of small mustelids as well as their management in regions where they are invasive.

<b>Data</b>

The weasel-data.RData file contains the detection history and covariate data as used in the manuscript. The vole-abundance covariate is given as standardized values.

The RN-model.R file contains the code to run the RN-model on the weasel data using the unmarked and ubms packages. The code runs the two models presented in the manuscript, as well as some diagnostic tests and model comparison. 

<b>Archived version</b>
<a href="https://zenodo.org/doi/10.5281/zenodo.10512567"><img src="https://zenodo.org/badge/527527567.svg" alt="DOI"></a>
