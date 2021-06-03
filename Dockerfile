FROM nvidia/cuda:10.2-base


# set bash as current shell
RUN chsh -s /bin/bash
SHELL ["/bin/bash", "-c"]

# install anaconda
RUN apt-get update
RUN apt-get install -y wget bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 git mercurial curl subversion && \
        apt-get clean
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh -O ~/anaconda.sh && \
        /bin/bash ~/anaconda.sh -b -p /opt/conda && \
        rm ~/anaconda.sh && \
        ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
        echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
        find /opt/conda/ -follow -type f -name '*.a' -delete && \
        find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
        /opt/conda/bin/conda clean -afy

# set path to conda
ENV PATH /opt/conda/bin:$PATH


# setup conda virtual environment
COPY ./requirements.yaml /tmp/requirements.yaml
RUN conda update conda \
    && conda env create --name camera-seg -f /tmp/requirements.yaml

RUN echo "conda activate camera-seg" >> ~/.bashrc
ENV PATH /opt/conda/envs/camera-seg/bin:$PATH
ENV CONDA_DEFAULT_ENV $camera-seg

# Copy dependencies to web server.
USER root
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g npm@7.15.1
COPY ./src /src
RUN apt-get install -y nodejs
WORKDIR /src
RUN npm install