# FROM jupyter/r-notebook # or datascience-notebook
FROM jupyter/datascience-notebook:bfb2be718a58

# install nbrsessionproxy extension
RUN conda install -yq -c conda-forge nbrsessionproxy && \
    conda clean -tipsy

# install rstudio-server
USER root
RUN apt-get update && \
    curl --silent -L --fail https://download2.rstudio.org/rstudio-server-1.1.419-amd64.deb > /tmp/rstudio.deb && \
    echo '24cd11f0405d8372b4168fc9956e0386 /tmp/rstudio.deb' | md5sum -c - && \
    apt-get install -y /tmp/rstudio.deb && \
    rm /tmp/rstudio.deb && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# RUN pip install jupyterhub jupyter-rsession-proxy \
#   && jupyter labextension install jupyterlab-server-proxy

## Install S3 Fuse

# ## Some utilities
# RUN apt-get -y update && \
#     apt-get -y install \
#         build-essential \
#         libfuse-dev \
#         libcurl4-openssl-dev \
#         libxml2-dev \
#         pkg-config \
#         libssl-dev \
#         mime-support \
#         automake \
#         libtool \
#         wget \
#         tar \
#         git \
#         unzip

# RUN rm -rf /tmp/s3fs-fuse
# RUN git clone https://github.com/s3fs-fuse/s3fs-fuse/ /tmp/s3fs-fuse
# WORKDIR /tmp/s3fs-fuse 
# RUN ./autogen.sh && ./configure && make && make install

# ## Create folder
# WORKDIR /var/www
# RUN mkdir s3
# ## Set Your AWS Access credentials
# ENV AWS_ACCESS_KEY=FJOY6ZTJ6I4BCK5MSGF4
# ENV AWS_SECRET_ACCESS_KEY=v0XMPDzxvuu/lT+tQN4TgZswCPqwE4SkUdQKxPW7M8E

# ## Set the directory where you want to mount your s3 bucket
# ENV S3_MOUNT_DIRECTORY=/var/www/s3

# ## Replace with your s3 bucket name
# ENV S3_BUCKET_NAME=sebago

# ## S3fs-fuse credential config
# RUN echo $AWS_ACCESS_KEY:$AWS_SECRET_ACCESS_KEY > /root/.passwd-s3fs && \
#     chmod 600 /root/.passwd-s3fs

# ## change workdir to /
# WORKDIR /

# ## Entry Point
# ADD start-script.sh /start-script.sh
# RUN chmod 755 /start-script.sh 
# CMD ["/start-script.sh"]

## End rocker image
ENV PATH=$PATH:/usr/lib/rstudio-server/bin
USER $NB_USER