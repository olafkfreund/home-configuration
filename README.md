# Home configuration

This project contains my personal home configuration files including aliases, git, vim, mc and others.

# Requirements

The software used and configured in this repo are the following:

* vim
* screen
* git
* most
* midnight commander (a.k.a. mc)
* glances
* intellij idea
* less
* tmux

# Usage

In order to deploy my configuration, simply run:

``` bash
[0][2019-02-28 09:15:26][0][florentclarret@dana:~/Documents/Dev/Shell/home-configuration] (branch: master)  
 $ ./install_home_configuration.bash
```

If you want the aliases and variables to be loaded automatically, add this to your .bashrc (or .profile, or whatever you are using) :

``` bash
source ~/.aliases/load.sh
```

# Sources

To create my configuration, I used some already existing configs from other repos :

* completion: [Bash-it/bash-it](https://github.com/Bash-it/bash-it "Bash-it/bash-it")
* tmux configuration: [Marthym's blog](https://blog.ght1pc9kc.fr/2019/ma-configuration-tmux.html "Marthym's blog")
* tmux theme: [https://gist.github.com/rajanand02/9407361](https://gist.github.com/rajanand02/9407361"https://gist.github.com/rajanand02/9407361")
