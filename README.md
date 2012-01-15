Vim Plugin Manager
==================

Vim Plugin Manager is an awesome utility for managing Vim plugins

Vim Plugin
----------

### What?

A Vim plugin is a package that contains vim scripts and a vim plugin specification, a.k.a. "vpspec".


### Why?

To allow proper distribution of vim scripts. For example, versioning of
vim scripts.

### How?

A vpspec, like a [gemspec](http://docs.rubygems.org/read/chapter/20), consists of several attributes.
For example, a description, example usage, notes, and more.

The directory structure of a vim plugin constains a file ending with *.vpspec in the root directory:

    - command-t.vpspec
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

With Vim Plugin Manager, you are able to manipulate Vim plugins like this:

    $ vpm install command-t
    $ vpm update command-t
    $ vpm list
    $ vpm search command-t
    $ vpm remove command-t

You are also able to install a certain version of a vim bundle:

    $ vpm install command-t v1.0

Vim-Plugins.org
---------------

[vim-plugins.org](http://vim-plugins.org) is a community vim plugin host. Vim plugin authors
publish their vim scripts to the host and keep track of basic statistics
of their vim plugins.

To publish/yank a Vim plugin:

    $ vpm publish
    $ vpm yank

Similar Projects
----------------

* <https://github.com/gmarik/vundle>
* <http://vim-scripts.org/vim/tools.html>
* <http://vimcasts.org/episodes/synchronizing-plugins-with-git-submodules-and-pathogen>
