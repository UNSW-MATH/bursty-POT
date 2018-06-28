---
date: 2018-06-28
papersize: a4
fontsize: 10pt
geometry:
  margin=2cm
linkcolor: blue
classoption: twoside
output:
  html_document: default
  pdf_document:
    toc: false
---

![](UNSW-flag.png)\ 

28 June 2018  
Dr Peter Straka  
p.straka@unsw.edu.au  
School of Mathematics & Statistics Faculty of Science  
UNSW Sydney  

#### Re-submission of paper titled "Peaks Over Threshold for Bursty Time Series"


Dear Professor Mikosch,

please find attached an updated version of our previous manuscript, now titled
"Thresholding Bursty Time Series". 
We hope that you agree to re-consider this article for publication in Extremes. 

The paper takes a novel approach to irregularly spaced extremes, which is based 
on the notion of "bursts" (see work by Albert-László Barabási). 
We believe that it constitutes a novel perspective on the timing of extremes,
which applied scientists will find highly applicable and useful. 

Further below, we address the associate editors previous comments

We thank you for re-considering this submission, and we look forward to your reply.

Yours sincerely,




Dr Peter Straka (on behalf of all authors)


### Previous comments by associate editor

> 1) On the third page the authors write: "This article generalizes the Peaks Over Threshold (POT) model to the setting where inter-event times are heavy-tailed."  
> I find the described connection misleading. The classical POT methods amounts to model the distribution of exceedences by means of the GPD, on assuming that the exceedences occur at the times of a homogeneous Poisson process. 
In the paper under review, the authors focus on modeling the times until the next excess, not on the exceedences themselves. This is confirmed not only by the main theorem, but also by the inference procedure in Section 5.  
> To add to the confusion, on Figure 2 the authors model the solar data using the Pareto distribution. If I understand correctly, the authors model the exceedences over the threshold, not the waiting times. This is not what is the paper about! 

Indeed, we model the exceedances and their timing separately.
What is new is the modelling of the timing of exceedances. 
As a model for the exceedances we use the plain old POT. 

To make it clearer what the achievement of the paper is, we have 

* Rephrased the offending sentence to "This article provides a new model for 
  the threshold inter-exceedance _times_; the threshold exceedances are modeled 
  via the standard Peaks Over Threshold (POT) method."
* Changed the title from "Peaks Over Threshold for Bursty Time Series" to 
  "Thresholding Bursty Time Series"
* Refrained completely from modelling the exceedances of the example dataset, 
  since it is not instructive at this point. 

> 2) Theorem in Section 3 (the lone theoretical of the paper) shows that the waiting time to the first exceedence over the threshold $l$ converges to a Mittag-Leffler distribution when $l\to\infty$. It seems as a relatively straightforward application of the result in Meerschaert and Stoev 2008. 

The Associate Editor seems to express disappointment over the amount of novel 
mathematics in the paper.  Besides the mentioned Theorem, the theoretical 
development in our paper lies in 

* the nonlinear scaling result of the exceedance inter-arrival times: 
  the scale grows as $p^{-1/\alpha}$ where $p$ is the threshold crossing
  probability
* the novel estimation method for the 

> 3) The authors should clearly explain what does it mean that the Mittag-Leffler is heavy tailed. This can be easily done by the representation that appears in the proof of the main theorem, that is $M=X^{1/\beta}D$, where $X$ is exponential and $D$ is $\beta$-stable. That is, we can easily give the formula for the tail behaviour of $M$ using the Breiman lemma. 

> 4) In Section 4 the authors argue that it is not a good idea to perform statistical inference for Mittag-Leffler by means of QQ-techniques or Hill plot. 
However, I rather disagree with the authors. 
Mittag-Leffler is a scale mixture of a stable law and a Weibull law. Due to the presence of the Weibull part, there is much more mass close to the origin in case of the Mittag-Leffler as compared to a stable law. This means simply that while the Hill plot for stable law will behave nicely for a wide range of order statistics, in case of Mittag-Leffler we need to consider a narrow range of order statistics, since the bias kicks in quickly.  
Of course, the additional challenge is even in case of long time series, we may have few exceedences and hence few waiting times to work with. 

> 5) There is no real contents of Section 5, since the authors use the log-transformed moments by Cahoy (2013) to estimate the parameters of the Mittag-Leffler. Also, "Assuming that the variation of L(c) is negligible" is a wishful-thinking, since it is usually a slowly varying function that causes the problems. 

> 6) The model verification of Section 6 has a serious flaw at the very beginning. Since the inter-exceedendes times follow Mittag-Leffler, they have infinite mean, hence the ACF plots have no meaning. 

> 7) Finally, the paper requires a serious editing. A number of, especially German, names is misspelled. 
In Theorem on page 7, $J_k$'s should be $W_k$'s. 

> SUMMARY: This paper is not about POT method, rather about inference for Mittag-Leffler distribution. There is almost no theoretical development (Section 3). There is some explanation why the QQ and Hill methods should not be used to estimate the M-L parameters (Section 4). I am not convinced in case of the Hill method. There is really no new approach to estimate the M-L parameters (Section 5) and certainly what is presented here is not "theoretically sound". the model checking in Section 6 is flawed from the very beginning.
