# Raincloud Plots

[![Binder](https://img.shields.io/badge/binder%20tutorial-python-fb62f6.svg)](https://mybinder.org/v2/gh/RainCloudPlots/RainCloudPlots/master?filepath=tutorial_python%2Fraincloud_tutorial_python.ipynb)
[![Binder](https://img.shields.io/badge/binder%20tutorial-R-c62e65.svg)](https://mybinder.org/v2/gh/RainCloudPlots/RainCloudPlots/master?urlpath=rstudio)
[![DOI](https://zenodo.org/badge/144041501.svg)](https://zenodo.org/badge/latestdoi/144041501)


***Code and tutorials to visualise your data in a way that is both beautiful *and* statistically valid.***

![](images/10repanvplot_cropped.jpg)

### Table of contents

* [Read the preprint](#read-the-preprint)
* [Give us feedback](#give-us-feedback)
* [Citing RainCloud plots](#citing-raincloud-plots)
* [Interactive tutorials online](#interactive-tutorials-online)
* [RainCloud plots in the wild](#raincloud-plots-in-the-wild)
* [Read more about RainCloud Plots](#read-more-about-raincloud-plots)
* [Installing and running on your local machine](#installing-and-running-on-your-local-machine)
  * [Download from github](#download-from-github) (needed for all tutorials)
  * [Python environment](#python-environment)
  * [R environment](#r-environment)
  * [Matlab environment](#matlab-environment)

## Read the preprint

We originally published Raincloud plots as a [preprint at PeerJ](https://peerj.com/preprints/27137v1/).
:heart_eyes: THANK YOU :heart_eyes: to everyone who left comments and gave us feedback on that document.

In March we submitted a revised preprint to [Wellcome Open Research](https://doi.org/10.12688/wellcomeopenres.15191.1).
Thank you to reviewers Lisa M. DeBruine and Elena Allen for their constructive feedback :pray::sparkles:.

In January 2021, we submitted a revised version to [Wellcome Open Research](https://doi.org/10.12688/wellcomeopenres.15191.2), 
which now includes a fully functional R-package [raincloudplots](https://github.com/jorvlan/raincloudplots).


To cite Raincloud plots please use the following information:

> Allen M, Poggiali D, Whitaker K et al. Raincloud plots: a multi-platform tool for robust data visualization [version 2; peer review: 2 approved]. Wellcome Open Res 2021, 4:63. DOI: [10.12688/wellcomeopenres.15191.2](https://doi.org/10.12688/wellcomeopenres.15191.2)

## Give us feedback

We'd love to hear your thoughts and any feedback you have.
The best place to leave comments on the paper and the project in general is at the [Wellcome Open Research preprint](https://doi.org/10.12688/wellcomeopenres.15191.2).
Just scroll to the bottom of that page (or click on the link at the side) and leave us feedback or ask a question.

You can also open an issue or submit a pull request to this repository if you find a bug!
Just check out our [contributing guidelines](CONTRIBUTING.md) for help getting started.

## Citing RainCloud plots

We really hope you find these tutorials helpful and want to use the code in your next paper or presentation!
This repository is made available under the [MIT license](LICENSE) which means you're welcome to use and remix the contents so long as you credit the creators: [Micah Allen](https://twitter.com/micahgallen?lang=en), [Davide Poggiali](https://twitter.com/dav1d3p0g?lang=en), [Kirstie Whitaker](https://twitter.com/kirstie_j?lang=en), [Tom Rhys Marshall](https://twitter.com/tomrhysmarshall?lang=en), [Jordy van Langen](https://twitter.com/jordyvanlangen?lang=en) and [Rogier Kievit](https://twitter.com/rogierk?lang=en).

There is a [zenodo archive](https://zenodo.org/badge/latestdoi/144041501) of the codebase and we ask that you cite the published paper along with the version of the code you used when referring to Raincloud plots.

>  Allen M, Poggiali D, Whitaker K et al. Raincloud plots: a multi-platform tool for robust data visualization [version 2; peer review: 2 approved]. Wellcome Open Res 2021, 4:63. DOI: [10.12688/wellcomeopenres.15191.2](https://doi.org/10.12688/wellcomeopenres.15191.2)
>
> Allen M, Poggiali D, Whitaker K, Marshall TR, Kievit R. (2018) RainCloudPlots tutorials and codebase (Version v1.1). Zenodo. http://doi.org/10.5281/zenodo.3368186

Get in touch with [Kirstie Whitaker](https://github.com/KirstieJane) if you need help citing a particular version of this codebase.

## Interactive tutorials online

You don't have to take our word for it, you can use Project Jupyter's [binder](https://mybinder.org) to interact with the python and R tutorials yourself.

Just follow either of the links below.

* [![Binder](https://img.shields.io/badge/binder%20tutorial-python-fb62f6.svg)](https://mybinder.org/v2/gh/RainCloudPlots/RainCloudPlots/master?filepath=tutorial_python%2Fraincloud_tutorial_python.ipynb) will open the python tutorial as an online jupyter notebook.
* [![Binder](https://img.shields.io/badge/binder%20tutorial-R-c62e65.svg)](https://mybinder.org/v2/gh/RainCloudPlots/RainCloudPlots/master?urlpath=rstudio) will open an online version of RStudio. You'll need to navigate to the [R tutorial](https://github.com/RainCloudPlots/RainCloudPlots/blob/master/tutorial_R/raincloud_tutorial_r.Rmd) (`/tutorial_R/raincloud_tutorial_r.Rmd`) from within RStudio and open the file to run it.

## Raincloud plots in the wild

We are delighted by how popular RainCloud plots have been!
In the six months since we published our [preprint at PeerJ](https://peerj.com/preprints/27137v1/) we have seen the following uses of RainCloud plots "in the wild":

* There's a [shiny app](https://gabrifc.shinyapps.io/raincloudplots/) by [Gabriel Forn-Cuní](https://github.com/gabrifc) and hosted on GitHub at [github.com/gabrifc/raincloud-shiny](https://github.com/gabrifc/raincloud-shiny).
* There's an accessible tutorial [hosted on Kaggle](https://www.kaggle.com/sbajew/raincloud-plots-iris-data) and using native R datasets by [Simon Bajew](https://www.kaggle.com/sbajew).
* RainCloud plots have been incorporated in the [PupillometryR](https://github.com/samhforbes/PupillometryR) package by [Sam Forbes](https://github.com/samhforbes).
* There's a lovely [animated demonstration](https://twitter.com/page_eco/status/1064891967077789703) showcasing how easy it is for humans to read signal into noise for small samples (code available as a [gist](https://gist.github.com/ajstewartlang/89dcdf01c4512a213141a16e9243626d) by [Andrew Stewart](https://github.com/ajstewartlang).

## Read more about RainCloud Plots

You can read more about RainCloud plots in the following blog posts:

* The original [Introducing RainCloud Plots](https://micahallen.org/2018/03/15/introducing-raincloud-plots/) post by [Micah Allen](https://micahallen.org/) in March 2018.
* A great [summary of our preprint](https://prelights.biologists.com/highlights/raincloud-plots-multi-platform-tool-robust-data-visualization/) is at [Prelights](https://prelights.biologists.com/), an inititative to showcase the best preprints in the biological sciences.
* Raincloud Plots were included in [Helena Jambor's](https://helenajambor.wordpress.com/) blog post ["Pick'n'mix plots"](https://helenajambor.wordpress.com/2018/08/28/pick-n-mix-plots/) which compares a few different visualisation types.

## Installing and running on your local machine

### Download from GitHub

The easiest way to get the code you need is to [download](https://github.com/RainCloudPlots/RainCloudPlots/archive/master.zip) a copy of this repository to your computer. (You can also [clone the repository](https://help.github.com/articles/cloning-a-repository/) if you're used to using git and GitHub.)

You'll notice that we've included three copies of the sampled data files, one for each language. This is to hopefully make it as easy for you as possible to run the tutorials and edit the code yourself.

Once you have the repository downloaded and unzipped, jump to the instructions for setting up the enviroment you're most comfortable with: [python](#python-environment), [R](#r-environment) or [matlab](#matlab-environment).

### Python environment

The code for RainCloud plots is packaged in the [ptitprince](https://github.com/pog87/PtitPrince) python package. It can be installed via pip using: `pip install ptitprince`.

There are a couple of other dependencies for the raincloud plots tutorial: they're listed in the [requirements.txt](requirements.txt) file in this repository. Note in particular that you must have [seaborn](https://seaborn.pydata.org/) version `0.9.0` or above to run the tutorial.

The following instructions will help you install all the necessary dependencies and get up and running really easily :sparkles:.

First, if you don't already have it, we recommend that you install [anaconda](https://conda.io/docs/user-guide/install/index.html) which will automatically install the [jupyter notebook](https://jupyter.readthedocs.io/en/latest/install.html#installing-jupyter-using-anaconda-and-conda) for you.

Then, from inside the `RainCloudPlots` folder type:

```
conda create --name rainpy python=3.6

activate rainpy

pip install -r requirements.txt

conda install nb_conda
```

This will create (and activate) a conda environment with all the the specific packages you need to run the tutorial.

A little note about jupyter notebooks and conda environments. If you have installed `nb_conda` as described above, you'll be able to choose the `rainpy` kernel in your jupyter notebook once it's open. Don't forget to switch from the default kernel when you open up the notebook.


From inside the `tutorial_python` direcotry, open up a jupyter notebook server by typing:

```
jupyter notebook
```

Double click on `raincloud_tutorial_python.ipynb` in your browser, make sure you're using the `rainpy` kernel, and execute the cells in the notebook.

### R environment

There are two ways to make it rain in R: through a series of specific easy to modify scripts, and through
our new tailored package, [raincloudplots](https://github.com/jorvlan/raincloudplots). The former provides a step-by-step walkthrough with individual scripts which can be modified as needed. The latter provides an
easy-to-use set of functions for the most common experimental designs and data formats.

#### `raincloudplots` - R package <img src="https://github.com/jorvlan/open-visualizations/blob/master/R/package_figures/rainclouds_highres.png" width="150" height="160" align="right"/>


Here's how to install the R-package [raincloudplots](https://github.com/jorvlan/raincloudplots). 
```r
if (!require(remotes)) {
    install.packages("remotes")
}
remotes::install_github('jorvlan/raincloudplots')

library(raincloudplots)
```
Further package-details and visualization-examples can be found on the GitHub repository that hosts the package.

#### R tutorial
We recommend that you run the R tutorial through RStudio. You can download the appropriate version of **RStudio Desktop** for your operating system [here](https://www.rstudio.com/products/rstudio/download/).

If you already have RStudio please check that you have [knitr](https://cran.r-project.org/web/packages/knitr/index.html) version `1.20` or higher.

The following packages will be read in when you run `raincloud_tutorial_r.Rmd`. They'll be installed if you don't already have them.

```
packages <- c("cowplot", "readr", "ggplot2" ,
              "dplyr", "lavaan")
```

From inside the `tutorial_R` directory, run `raincloud_tutorial_r.Rmd`.

### Matlab environment

You'll need two dependencies to run the matlab tutorial: `cbrewer` which can be downloaded [here](https://uk.mathworks.com/matlabcentral/fileexchange/34087-cbrewer-colorbrewer-schemes-for-matlab) and `robust_statistical_toolbox` which should be downloaded [from GitHub](https://github.com/CPernet/Robust_Statistical_Toolbox) in the same way you [downloaded this repository](#download-from-github).

**NOTE**: the robust statistical toolbox is made available under the [GNU General Public License](https://github.com/CPernet/Robust_Statistical_Toolbox/blob/master/LICENSE) which is a ["copyleft"](https://en.wikipedia.org/wiki/Copyleft) license. GPL is compatible with [MIT](LICENSE) (the license for this repository) but supersedes it. Make sure that you are not violating this license when you run the matlab tutorial. :smiley:

Put both of these dependencies in the `tutorial_matlab` folder and then, from the parent directory of that directory, run `raincloud_tutorial_matlab.mlx`.

