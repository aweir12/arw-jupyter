# arw-jupyter
Jupypter Notebook for Development Purposes

<h2>About This Repository</h2>
This repository contains all the necessary code to create a Docker image for Python development using Jupyter Notebook. The image is based on jupyter/minimal-notebook:latest.


<h2>Features</h2>
<h4>Why these features</h4>
These are my personal preferences for Python development in Jupyter Notebook.

<h4>Remove Jupyter Notebook Output Before Commiting Changes</h4>
Using nbstripout (https://github.com/kynan/nbstripout) the container always removes Jupyter Notebook output prior to commiting any changes.

<h4>Auto Export Jupyter Notebooks as .py's</h4>
When a developer executes a "Save" in Jupyter Notebook, the notebook will automatically be exported as a .py file also. The .ipynb remains, but this is handy to keep your .py files and .ipnyb's in sync. This is achieved using a Jupyter post-save-hook.

<h4>Auto Install Oracle Client & cx_Oracle Python Packages</h4>
Almost everything I do uses data from an Oracle Database. That said, I decided to include the client installation in the image. Also because setting up cx_Oracle isn't as simple as just a pip install.

<h4>Function With GitHub</h4>
I'm notorious for losing my code, and working on "side projects" that inevitably result in usefull snippets. This notebook has the functionality to:
* Clone a repo on startup.
* Just create a scratch notebook using no repo.
* Create a new repo on startup.
* Push to GitHub without a password.

<h4>Create Global .gitignore</h4>
Since aiming to quickly check-in code on the fly, I've created a global .gitignore to keep unwanted installs and/or secrets from being committed to the repository.


<h2>Installation & Configuration<h2>
<h5>Step 1: Pull Base Docker Image</h5>

```
docker pull jupyter/minimal-notebook:latest 
```

<h5>Step 2: Setup Prerequisites</h5>
* Create bin directory in the arw-jupyter/ directory.

```
mkdir bin 
```

* SSH Key and Personal Access Token
  - Your personal access token for GitHub needs to be the ONLY line in the file bin/api-token.txt
  - Your SSH Key needs to be located at /bin/id_rsa

* Oracle Client
  - The Oracle Client needs to be instantclient-basic-linux.x64-18.3.0.0.0dbru.zip
  - The .zip needs to be located at /bin/instantclient-basic-linux.x64-18.3.0.0.0dbru.zip

* Install Necessary Python Packages
  - Create the file /bin/requirements.txt
  - List all python packages (each on their own line) to be installed at image build time

* Build the Image
  - In the arw-jupyter execute the following:
 
``` docker build -t arw/jupyter:latest . ```

<h2>Using the Image</h2>

<h4>Pull an Existing Repo</h4>

``` docker run -e REPO='test-repo' -e STATUS='clone' --rm -p 8888:8888 -it arw/jupyter:latest ```

<h4>Creating a New Repo</h4>

``` docker run -e REPO='my-new-repo' -e STATUS='new' --rm -p 8888:8888 -it arw/jupyter:latest ```

<h4>Scratch Notebook</h4>

``` docker run --rm -p 8888:8888 -it arw/jupyter:latest ```
