Vim Plugin Manager
==================

Vim Plugin
----------

### What?

A Vim Plugin is a package that contains vim scripts and a vim plugin specification, a.k.a. "vbspec".


### Why?

To allow proper distribution of vim scripts. For example, versioning of
vim scripts.

### How?

A vbspec, like a [gemspec](http://docs.rubygems.org/read/chapter/20), consists of several attributes.
For example, a description, example usage, notes, and more.

The directory structure of a vim bundle constains a file ending with *.vbspec in the root directory:

    - command-t.vbspec
    - ...

Vim Plugin Manager
------------------

### What?

Vim Plugin Manager (VPM) keeps track of installed vim scripts,
installs/updates vim scripts from [vim-plugins.org](http://vim-plugins.org), uninstalls vim scripts and searches vim
scripts by name.

### Why?

Managing vim scripts is difficult without a manager. For example,
installing or updating a version of a vim script.

### How?

With Vim Plugin Manager, you are able to manipulate Vim Plugins like this:

    $ vpm install command-t
    $ vpm update command-t
    $ vpm list
    $ vpm search command-t
    $ vpm uninstall command-t

You are also able to install a certain version of a vim bundle:

    $ vpm install command-t v1.0

Vim-Plugins.org
--------------

Vim-Plugins.org is a community vim bundle host. Vim Plugin authors
publish their bundled vim scripts to the host and keep track of basic statistics
of their vim bundles.

To publish/yank a Vim Plugin:

    $ vpm publish
    $ vpm yank

Similar Projects
----------------

* <https://github.com/gmarik/vundle>
* <http://vim-scripts.org/vim/tools.html>
* <http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen>
