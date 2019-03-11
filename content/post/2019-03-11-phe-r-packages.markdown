---
title: PHE R packages
author: Julian Flowers
date: '2019-03-11'
slug: phe-r-packages
categories:
  - R
  - packages
  - Data science
tags:
  - fingertips
  - methods
---

As part of our open data and data science strategy we create R packages, three of which we have made widely available through [CRAN]().

The most popular is `fingertipsR` which reads data from [Fingertips](https:fingertips.phe.org.uk) via the fingertips API.



```r
library(pacman)
p_load(cranlogs, tidyverse)
```


```r
cran_plot <- function(packages = "fingertipsR", from = Sys.Date() - 365, to = Sys.Date(), title = "Plot"){
  
  plot <- cranlogs::cran_downloads(packages = packages, to = to, from = from) %>%
    group_by(month = zoo::as.yearmon(date), package) %>%
    summarise(monthly = sum(count)) %>%
  ggplot(aes(month, monthly, colour = package)) +
    #geom_line(aes(group = package), colour = "grey", show.legend = FALSE) +
    geom_smooth(se = FALSE, aes(group = package), show.legend = FALSE) +
    labs(title = title, y = "Monthly downloads") +
    zoo::scale_x_yearmon()
  
  plot
  
}
```



```r
#cranlogs::cran_downloads("fingertipsR", when = "last-day")

cran_plot(packages = c("fingertipsR", "fingertipscharts", "PHEindicatormethods"), title = "Smoothed monthly downloads") +
  facet_wrap(~package) +
  scale_y_log10()
```

<img src="/post/2019-03-11-phe-r-packages_files/figure-html/plot-1.png" width="672" />

