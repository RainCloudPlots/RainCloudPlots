# RaincloudPlots

Code and tutorials to visualise your data that is both beautiful *and* statistically valid.

***add a lovely picture here***

## Interactive tutorials online

You don't have to take our word for it, you can use Project Jupyter's [binder](https://mybinder.org) to interact with the python and R tutorials yourself.

* Python tutorial: [![Binder](http://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/RainCloudPlots/RainCloudPlots/master?filepath=tutorial_python%2Fraincloud_tutorial_python.ipynb)
* R markdown tutorial: [![Binder](http://mybinder.org/badge.svg)](https://mybinder.org/v2/gh/RainCloudPlots/RainCloudPlots/master?urlpath=rstudio)

## Installing and running on your local machine

### Downloading from GitHub

The easiest way to get the code you need is to [download](https://github.com/RainCloudPlots/RainCloudPlots/archive/master.zip) a copy of this repository to your computer. (You can also [clone the repository](https://help.github.com/articles/cloning-a-repository/) if you're used to using git and GitHub.)

You'll notice that we've included three copies of the sampled data files, one for each language. This is to hopefully make it as easy for you as possible to run the tutorials and edit the code yourself.

Once you have the repository downloaded and unzipped, jump to the instructions for setting up the enviroment you're most comfortable with: [python](#python-environment), [R](#r-environment) or [matlab](#matlab-environment).

### Python environment

First, if you don't already have it, we recommend that you install [anaconda](https://conda.io/docs/user-guide/install/index.html) which will automatically install the [jupyter notebook](https://jupyter.readthedocs.io/en/latest/install.html#installing-jupyter-using-anaconda-and-conda) for you.

Then, from inside the `RainCloudPlots` folder type:

```
conda env create -n rainpy python=3.6 -f requirements.txt

conda install nb_conda

activate rainpy
```

This will create (and activate) a conda environment with all the the specific packages you need to run the tutorial.

A little note about jupyter notebooks and conda environments. If you have installed `nb_conda` as described above, you'll be able to choose the `rainpy` kernel in your jupyter notebook once it's open. Don't forget to switch from the default kernel when you open up the notebook.

You can install the requirements individually, but do note that you must have [seaborn](https://seaborn.pydata.org/) version `0.9.0` or above to run the tutorial.

From inside the `tutorial_python` direcotry, open up a jupyter notebook server by typing:

```
jupyter notebook
```

Double click on `raincloud_tutorial_python.ipynb` in your browser and execute the cells in the notebook.

### R environment

We recommend that you run the R tutorial through RStudio. You can download the appropriate version of **RStudio Desktop** for your operating system [here](https://www.rstudio.com/products/rstudio/download/).

If you already have RStudio please check that you have [knitr](https://cran.r-project.org/web/packages/knitr/index.html) version `1.20` or higher.

The following packages will be read in when you run `raincloud_tutorial_r.Rmd`. They'll be installed if you don't already have them.

```
packages <- c("cowplot", "readr", "ggplot2" ,
              "dplyr", "lavaan")
```

From inside the `tutorial_R` directory, run `raincloud_tutorial_r.Rmd`.

### Matlab environment

***to be completed***

From inside the `tutorial_matlab` directory, run `raincloud_tutorial_matlab.mlx`.
