Vim Bundle Manager
==================

Vim Bundle
----------

### What?

A Vim Bundle is a package that contains vim scripts and a vim bundle specification, a.k.a. "vbspec".


### Why?

To allow proper distribution of vim scripts. For example, versioning of
vim scripts.

### How?

A vbspec, like a [gemspec](http://docs.rubygems.org/read/chapter/20), consists of several attributes.
For example, a description, example usage, notes, and more.

The directory structure of a vim bundle constains a file ending with *.vbspec in the root directory:

    - command-t.vbspec
    - ...

Vim Bundle Manager
------------------

### What?

Vim Bundle Manager (VBM) keeps track of installed vim scripts,
installs/updates vim scripts from <vimbundles.org>, uninstalls vim scripts and searches vim
scripts by name.

### Why?

Managing vim scripts is difficult without a manager. For example,
installing or updating a version of a vim script.

### How?

With Vim Bundle Manager, you are able to manipulate Vim Bundles like this:

    $ vbm install command-t
    $ vbm update command-t
    $ vbm list
    $ vbm search command-t
    $ vbm uninstall command-t

You are also able to manipulate a certain version of a vim bundle:

    $ vbm install command-t v1.0

VimBundles.org
--------------

VimBundles.org is a community vim bundle host. Vim Bundle authors
publish their bundled vim scripts to the host and keep track of basic statistics
of their vim bundles.

To publish/yank a Vim Bundle:

    $ vbm publish
    $ vbm yank

Similar Projects
----------------

* <https://github.com/gmarik/vundle>
* <http://vim-scripts.org/vim/tools.html>
* <http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen>
