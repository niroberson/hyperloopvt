# Hyperloop at Virginia Tech Github Repository
Welcome to the GitHub repository for Hyperloop at Virginia. All of your analysis, control, comm, etc. code can be stored here to have a singular reference point and documentation ability for all engineers on this project. If you are not familiar with GitHub it will be helpful to follow the steps below to get started.

###Contributing to the repository

To be able to contribute and modify code in the repository it would be helpful to

1. Download Git ( https://git-scm.com/downloads ) 

2. Learn Git ( https://git-scm.com/doc )


### Remember to pull the latest changes before you push

##### Pull
<pre></code>git pull</code></pre>

##### Push
<pre><code>
git add <filename>
git commit -m '<message>'
git push
</code></pre>

### NASA OpenMDAO Submodule
After you add a submodule, or whenever someone does a fresh checkout of your repository, you'll need to do:

<pre><code>git submodule init
git submodule update</code></pre>

And then all submodules you've added will be checked out at the same revision you have.

When you want to update to a newer version of one of the libraries, cd into the submodule and pull:

 <pre> <code>
  cd lib/some_lib
  git pull
  </code> </pre>
