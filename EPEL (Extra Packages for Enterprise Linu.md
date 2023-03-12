EPEL (Extra Packages for Enterprise Linux) is a repository of additional software packages for Red Hat Enterprise Linux (RHEL) and its derivatives such as CentOS, Fedora, and Scientific Linux. 
It is maintained by the Fedora project and is designed to provide users with additional packages that are not included in the standard RHEL/CentOS repositories.

In Ansible, the EPEL repository can be managed using the "yum_repository" module. 
This module allows Ansible to manage the configuration of the repository, such as enabling or disabling it, configuring the base URL and other settings, and ensuring that the appropriate GPG keys are installed to verify packages.

Using the EPEL repository in Ansible can be useful for installing additional packages that may not be available in the default repositories, such as development tools, system administration utilities, and other software packages.



The configuration file

Changes can be made and used in a configuration file which will be searched for in the following order:

ANSIBLE_CONFIG (environment variable if set)

ansible.cfg (in the current directory)

~/.ansible.cfg (in the home directory)

/etc/ansible/ansible.cfg

Ansible will process the above list and use the first file found, all others are ignored.



how to change hostname of amazon linux instance Permenent ?

1. Open the /etc/hostname file with a text editor that is vi
# vi /etc/hostname
Here you need to replace the existing hostname with the new hostname you want to use, then save and exit the file.


2. Open the /etc/hosts file with a text editor that is vi
# vi /etc/hosts
Here you need replace the old hostname with the new hostname you want to use, for example
Syntax: 127.0.0.1   new-hostname     Example: 127.0.0.1  AnsibleServer
Save and exit the file.

3. Run the following command to update the current hostname
# hostnamectl set-hostname new-hostname
Example: # hostnamectl set-hostname AnsibleServer
Replace new-hostname with the hostname you want to use. In my case I have used AnsibleServer as my new hostname

4. Verify that the new hostname has been set by running the following command
# hostname

5. Reboot Your System to show changes



