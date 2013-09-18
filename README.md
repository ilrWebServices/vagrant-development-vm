# ILR Vagrant Development VM

## About

This repository is based on [Zivtech's development virtual server](https://github.com/zivtech/vagrant-development-vm).

## Requirements

  * On Windows, you will need to have access to an ssh client, such as [Git bash](http://windows.github.com/) (which is installed with GitHub for Windows), [Cygwin](http://www.cygwin.com/), or [PuTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html). 
  * [Vagrant](http://vagrantup.com)
  * [VirtualBox](https://www.virtualbox.org/) (tested on V1.2.7)

## Installation

  1. Navigate to your GitHub directory (if installed with GitHub for windows), or your usual development directory. 
  2. Clone this repository `git@github.com:ilrWebServices/vagrant-development-vm.git`
  3. Clone a website respository (such as the [ILR Website](https://github.com/ilrWebServices/ilr-website))
  4. Type `cp Vagrantfile.example Vagrantfile`. This creates a working copy Vagrantfile in the root of this repository that points your virtual web server's docroot to the website you cloned in step 3.
  5. Run `vagrant up`
  6. ssh into the server with `vagrant ssh`
  7. Run `sudo apt-get update && sudo apt-get upgrade` on the server (click space-bar and hit enter if/when asked about grub)
  8. Enable Drush on the server (see section below)
  9. `exit` the server
  10. Finish the build with `vagrant provision`
  11. Reload vagrant with `vagrant reload`
 
You should now have a working Virtual Server, which can be accessed at `33.33.33.40`. If you are setting up the [ILR Website](https://github.com/ilrWebServices/ilr-website), follow additional instructions there.

## Enabling Drush

Assuming you are setting up the site for a project such as the [ILR Website](https://github.com/ilrWebServices/ilr-website), you will need to configure mysql on vagrant to accept connections from your host environment. The instructions are as follows: 

  1. Type `mysql`
  2. Issue the command `GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;`
  3. Drush commands run on your host machine now have rights to connect as `root` to the mysql service on the virtual server
  4. `exit` ssh and `vagrant reload` (or `vagrant provision`, if following installation steps)
