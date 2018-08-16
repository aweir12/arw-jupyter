FROM jupyter/minimal-notebook:latest

USER root
# Install Updates and Grab Oracle Client Prerequisites
RUN apt-get update && apt-get install -y apt-utils libaio1 ssh curl



USER jovyan
# Copy Config Directory Used for Setup
COPY --chown=jovyan:users config $HOME/config

# Install Oracle Instant Client
COPY --chown=jovyan:users /bin/instantclient-basic-linux.x64-18.3.0.0.0dbru.zip $HOME/client.zip
RUN unzip client.zip && rm client.zip
ENV LD_LIBRARY_PATH $HOME/instantclient_18_3

# Setup SSH for GitHub and API Token
COPY --chown=jovyan:users /bin/id_rsa $HOME/.ssh/
RUN chmod 700 $HOME/.ssh/id_rsa && echo "Host github.com\n\tStrictHostKeyChecking no\n" >> $HOME/.ssh/config
COPY --chown=jovyan:users /bin/api-token.txt $HOME/api-token.txt

# Register GIT and Configure .gitignore_global to Keep Repos Clean
RUN mv config/.gitignore_global $HOME
RUN git config --global user.email "austin.weir@gmail.com" && git config --global user.name "aweir12" && git config --global core.excludesfile ~/.gitignore_global

# Add Jupyter Hook to AutoSave .py Files
RUN cat $HOME/config/jupyter-hook.py >> $HOME/.jupyter/jupyter_notebook_config.py && rm $HOME/config/jupyter-hook.py

# Install Python Packages
RUN pip install --upgrade pip && pip install -r $HOME/config/requirements.txt && rm $HOME/config/requirements.txt

# Last Couple Steps (see .sh script for documentation)
ENV STATUS=new
ENV REPO=jessica
WORKDIR /home/jovyan/work
RUN chmod 700 $HOME/config/configure.sh

# Execute on Startup!
CMD $HOME/config/configure.sh && /bin/bash

# /usr/local/bin/start-notebook.sh