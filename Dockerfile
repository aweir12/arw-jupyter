FROM jupyter/minimal-notebook:latest

USER root
RUN apt-get update && apt-get install  -y apt-utils && apt-get install -y libaio1
RUN apt-get install -y ssh
ADD . /home/jovyan/code
RUN unzip /home/jovyan/code/instantclient-basic-linux.x64-18.3.0.0.0dbru.zip
RUN chown -R jovyan:users /home/jovyan/instantclient_18_3
RUN chown -R jovyan:users /home/jovyan/code

USER jovyan
RUN mkdir /home/jovyan/.ssh && mv /home/jovyan/code/id_rsa /home/jovyan/.ssh/
RUN chmod 700 /home/jovyan/.ssh/id_rsa && echo "Host github.com\n\tStrictHostKeyChecking no\n" >> /home/jovyan/.ssh/config
ENV LD_LIBRARY_PATH /home/jovyan/instantclient_18_3
RUN pip install --upgrade pip && pip install -r /home/jovyan/code/requirements.txt
RUN cat /home/jovyan/code/jupyter-hook.py >> /home/jovyan/.jupyter/jupyter_notebook_config.py
ADD .gitignore_global $HOME/
RUN rm -rf /home/jovyan/code
RUN git config --global user.email "austin.weir@gmail.com" && git config --global user.name "aweir12" && git config --global core.excludesfile ~/.gitignore_global
ENV REPO=hello-world
WORKDIR /home/jovyan/work
#CMD git clone git://github.com/aweir12/${REPO} && cd $HOME/work/${REPO} && git remote set-url origin git@github.com:aweir12/${REPO}.git && /bin/bash
CMD git clone git://github.com/aweir12/${REPO} && cd $HOME/work/${REPO} && git remote set-url origin git@github.com:aweir12/${REPO}.git && nbstipout --install --atributes .gitattributes && /usr/local/bin/start-notebook.sh
