FROM rocker/verse:4.2.1
RUN apt-get update

# Install wget
RUN apt-get -y install wget

# Install some useful R packages
RUN install2.r --error --skipinstalled --ncpus -1 \
    dplyr ggplot2 JuliaConnectoR languageserver readr

# Install julia 1.6.1
WORKDIR /opt/
ARG JULIA_TAR=julia-1.6.1-linux-x86_64.tar.gz
RUN wget -nv https://julialang-s3.julialang.org/bin/linux/x64/1.6/${JULIA_TAR}
RUN tar -xzf ${JULIA_TAR}
RUN rm -rf ${JULIA_TAR}
RUN ln -s /opt/julia-1.6.1/bin/julia /usr/local/bin/julia

# To build this image, run
    # docker build -t anovabnptestr:0.1 .

# To create a container using this Docker image, run (on terminal)
    # sudo docker run <docker/rocker options> anovabnptestr:0.1
# for example:
    # docker run \
    #   --rm -d \
    #   -p 8787:8787 \
    #   -e "ROOT=TRUE" \
    #   -e USER=rstudio \
    #   -e PASSWORD=123 \
    #   -v $HOME/.gitconfig:/home/rstudio/.gitconfig \
    #   -v $HOME/.ssh:/home/rstudio/.ssh \
    #   anovabnptestr:0.1
# Visit https://www.rocker-project.org/ for more details.
