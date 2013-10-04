# ILR Vagrant Development VM

## About

This repository is based on [Zivtech's development virtual server](https://github.com/zivtech/vagrant-development-vm).

## Requirements

  * On Windows, you will need to have access to an ssh client, such as [Git bash](http://windows.github.com/) (which is installed with GitHub for Windows), [Cygwin](http://www.cygwin.com/), or [PuTTY](http://www.chiark.greenend.org.uk/~sgtatham/putty/download.html). 
  * [Vagrant](http://vagrantup.com) (tested on V1.2.7)
  * [VirtualBox](https://www.virtualbox.org/) 

## Installation

  1. Navigate to your GitHub directory (if installed with GitHub for windows), or your standard development directory. *Note that the current vhost setup fails if you're using the ~/Sites folder on OSX*
  2. Clone this repository `git@github.com:ilrWebServices/vagrant-development-vm.git`
  3. Clone a website respository (such as the [ILR Website](https://github.com/ilrWebServices/ilr-website)). Be sure to uncomment the `# RewriteBase /` (around line 110) of the .htaccess file of the repository. 
  4. `cd vagrant-development-vm`
  4. `cp Vagrantfile.example Vagrantfile`. This creates a working copy Vagrantfile in the root of this repository that points your virtual web server's docroot to vm's parent folder.
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

## Working with Multiple Sites

This project is currently set up to initialize with the [apache2-default file](puppet-modules/php53/files/apache2-default), which configures a VirtualDocumentRoot to serve sites. We set it up this way so we can configure and run multiple websites within this one virtual environment. 

The important line in that file sets the VirtualDocumentRoot to `/var/www/%2/docroot/`, which uses the `%2` wildcard to grab the 2nd dot segment of the url and look for a folder with that name (i.e. www.ilr-website.dev will look for a folder called 'ilr-website' in the parent folder of the vagrant-development-vm). This also means that you'll need to [edit your hosts file](http://www.howtogeek.com/howto/27350/beginner-geek-how-to-edit-your-hosts-file/) to point www.ilr-website.dev to 33.33.33.40.

If you're working with a Drupal multi-site configuration (such as the [Projects bucket](https://github.com/ilrWebServices/projects)), you can create a subdomain to point to the correct multi-site (i.e. hoc.projects.dev would look in for a settings.php file in `projects/docroot/sites/hoc.projects.dev`).
