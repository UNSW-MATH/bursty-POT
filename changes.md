# Changes to previous version

## Referee 1

### Major points and questions

> It should be noted, however, that this process has light-tailed
Mittag-Leffler marginals, while the authors of the paper under review encounter a
different, heavy-tailed Mittag-Leffler law.

+ We have added the following sentence near the end of Section 3: 
"We caution the reader that, somewhat confusingly, there is another distribution
called the "light-tailed" Mittag-Leffler distribution.  This is in fact the 
limiting distribution of the renewal process $N(t)$ above (see @limitCTRW)."
+ We have also added the following reference: 
Meerschaert, Mark M, and Hans-Peter Scheffler. 2004. “Limit Theorems forContinuous-Time Random Walks with Infinite Mean Waiting Times.”J. Appl.Probab.41 (3): 623–38. https://doi.org/10.1239/jap/1091543414.

> (p.5, l. 9-13) Why is it true that the limiting distribution exists? It is well known... 

KATHI TO DO

> Note: It is important to observe that due to the fact that the waiting times Wj ’s have infinite
means, the renewal counting process N(t) cannot be made stationary (through a random shift) and hence this model does not fall into the classic context of Hsing-Leadbetter and Davis-Hsing.

We have added a remark at the end of Section 3, saying: 

"When $0 < \beta < 1$, the renewal process $N(t)$ is _not stationary_, 
and hence the results by @Hsing88 on the exceedances of stationary sequences
do not apply."

> Given the first comment above, can you elucidate the connection between the two different kinds of Mittag-Leffler distributions – the light-tailed distributional limit for the counting process N(t) and the heavy-tailed limit model for the T(l)’s?

We have addressed this, see first point. 

> The use of k is very confusing ... These two sentences are so unclear, so poorly written...  Be specific, choose your words carefully and introduce labels/titles in the plots.

We have re-written the entire section titled "Simulation study". 

> (Section 5 and 6) In these 2 sections it is implied that p = k/n .... While a complete rigor in the discussion on the statistical methodology is perhaps not necessary, itis important for the reader to clearly see where “asymptotic approximations” are applied.

We have re-written Sections 5 & 6, and made sure that $p$ is used as the theoretical exceedance probability, whereas the fraction of exceedances $k/n$ is denoted as $\hat p$. We have also clarified throughout where we assuming approximations.

> (Section 5) The methodology in this section (pages 9 and 10) is not very clearly described. Why give 2 algorithms if you are using just the second one, mostly? ... The scaling/rescaling of the scale coefficient by the choice of l and k is very confusing. Please revise Section 5 thoroughly.

We have re-written Section 5, as per the referee's suggestions, and we can now do without the "practical adjustments" section. 

> (page 11, line 12) Poor scientific language: “... the hill estimator gets useless ... Also a few lines after that, they claim that the scale cannot be estimated. This is not entirely true. ... 

KATHI TO DO

> Last but not least, given that the authors are dealing with more or less standard semi- parametric estimation of heavy-tail exponents and scales, they could formulate limit the- orems on the asymptotic distribution of their statistics and derive Wold-type confidence intervals for the estimated parameters. ... 

In the last paragraph of Section 5, we have included pointers to the literature for confidence intervals for the shape and scale parameters of the Mittag-Leffler distribution, and how these lead to "confidence bands" in our plots, based on the CTRE package. 


### Typos and suggestions

1. fixed
2. fixed
3. fixed
4. fixed
5. fixed
6. fixed
7. fixed
8. fixed
9. fixed
10. fixed
11. fixed
12. fixed
13. fixed
14. fixed
15. KATHI TO DO
16. fixed
17. no longer applies
18. fixed
19. fixed
20. fixed
21. fixed
22. fixed
23. fixed
24. fixed
25. fixed
26. The section has been re-written
27. fixed
28. fixed
29. fixed
30. fixed
31. fixed
32. fixed
33. We have commented as follows: 
    "The stability plot for the tail stabilizes nicely around 0.85 (dashed line), while 
    the scale parameter stabilizes less obviously near $3 \times 10^7$ (dashed line).
    The growth of the scale parameter for lower threshold appears to be closer to linear in $p$, 
    rather than proportional to $p^{1/0.85}$ as suggested by the Mittag-Leffler
    fits. The reason for this is likely that the overall goodness of fit as 
    compared to an exponential distribution is improved due to the 
    peaked shape of the Mittag-Leffler distribution near $0$,
    rather than its tail behaviour at $\infty$.
    The reported fit should hence come with the caveat that a Mittag-Leffler 
    distribution models exceedance times well only up to certain time-scales. 
    More research is needed into the modelling of scale transitions, where
    inter-exceedance times appear to have different power laws across different 
    time scales."
34. We have changed "fitted" to "estimated".
35. We have added confidence limits.
36. We have added titles to the two figures, and to other figures where 
    feasible. 
37. fixed
38. fixed
