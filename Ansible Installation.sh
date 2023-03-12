Ansible Installation

Setup or All module follow Idempotency method internally. 
Do the work one time do not work same work multiple time.

Launch Amazon Linux (no need to install ansible s/w in/on hosts)
yum install wget -y
wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install epel-release-latest-7.noarch.rpm -y
sudo yum update -y
sudo yum install git python python-devel python-pip openssl ansible -y
ansible --version

cd /etc/ansible
ls
ansible.cfg : this is also configuration file
hosts/Inventory: We can call host or invnetory file. We maintainer host machines IP addresses.
roles

vi /etc/ansible/ansible.cfg
inventory      = /etc/ansible/hosts
sudo_user      = root

we have to uncoment # of line sudo user and hosts as like above


Main Configuration File: /etc/ansible/ansible.cfg
Executable Location: /bin/ansible
Ansible Python Module Location: /usr/lib    

=========================================================================================

04/03/2023

chnage the hosts /etc/ansible/hosts file 
Add the both host instance ip address in hosts file of anisble controller node

We have created group called webserver
[webserver]
IP Address
IP Address

syntax for calling this group or host pattron
There are two IP address in webserver group. But now we need to call only one IP from webserver 
webservers[0] - 0 means first server
webservers[1] - 1 means second server
webservers[-1] - last server
webservers[-2] - last second number

webservers[0:9] - 0:9 means it will call first 10 server

all 

group1[1]:group[3] 

Steps need to follow before working on ansible
1. Create ansible user
2. Give Password to ansible user
3. We need to give sudo permission to ansadmin user
4. Establish SSH Connection between ansible server to all host server for secuerly connection
5. Remove the password


Note: 1. We need to create ansible user on every machine including controller and host node.
      2. Provide same password for all users whatever we have created on every machine. 
         It is called Common Password. This is the best approach.

# useradd ansible  // Step 1 - Create ansible user
# passwd ansible   // Step 2 - Give Password to ansible user
# su - ansible
# touch file
# mkdir dir

# sudo su -  (become root user)
# visudo   /etc/sudoers file
ansible  ALL=(ALL)  NOPASSWD:ALL  // Step 3 - We need to give sudo permission to ansible user
We need to add above line on all servers

# su - ansible
# sudo yum install httpd -y 
# sudo yum remove httpd -y 
We are making sure the user anisble has got root permission to perform any command like root

# sudo su -  (become root user)
# vi /etc/ssh/sshd_config       // Step 4 - Establish SSH Connection between ansible server to all host server for secuerly connection
We need to do some chnages in this ssh configuration file as per below
PermitRootLogin Yes           
PasswordAuthentication Yes    (Enable or uncoment both the line)

# systemctl restart sshd
We need to restart ssh service to reflect the chnages.

# su - ansible      // Step 5 - Remove the password (Performing on controller node)
# ssh-keygen
# ls -al 
# cd .ssh/
# ls
# ssh-copy-id ansible@host_ip_address   (We are moving keys from ansibble server to host server)

Now try to login host server without password

# ssh host_ip_address

=========================================================================================

05/03/2023


# ansible all --list-host

# ansible webserver --list-host

# ansible webserver[0]  --list-host

# ansible webserver[1]  --list-host

# ansible webserver[-1]  --list-host

# ansible webserver[-2]  --list-host

# ansible webserver[0:4]  --list-host

# ansible webserver:dbserver --list-host

# ansible webservers -a "ls"

# ansible webservers -a "ls -a"

# ansible webservers -a "ls /home"

# ansible webservers -a "sudo which httpd"

# ansible webservers -a "yum remove httpd -y" -b

# ansible webservers -a "hostname -i"

Using Module 

# ansible webservers -b -m yum -a "pkg=httpd state=present"

# ansible webservers -b -m yum -a "pkg=httpd state=latest"

# ansible webservers -b -m yum -a "name=httpd state=started"

# ansible all -m systemd -a "name=nginx state=started"

# ansible webservers -b -m user -a "name=Raj state=present"

# ansible webservers -a "tail -2 /etc/passwd" -b

# ansible webservers -b -m user -a "name=Raj state=absent"

# ansible webservers -b -m copy -a "src=ansiblefile dest=/tmp"

=========================================================================================

07/03/2023

1. // Installing same package on different OS family using one ansible playbook at the same time 

---
- hosts: all
  become: true

  tasks:
  - name: Installing the httpd package
    yum:
      name: httpd
      state: present
    when: ansible_os_family == "RedHat"

  - name: Starting service 
    service:
      name: httpd
      state: started
    when: ansible_os_family == "RedHat"

  - name: Insatlling Apache package
    apt: 
      name: apache2
      state: present
    when: ansible_os_family == "Debian"
   
  - name: Starting Apache service
    service:
      name: apache2
      state: started
    when: ansible_os_family == "Dabian"

  - name: copyinng index.html
    copy:
      src: /etc/ansible/index.html
      dest: /var/www/html


2. // Installing multiple package at the same time 

---
- hosts: all
  become: true

  tasks:
  - name: Install multiple package
    yum:
      name: ['git', 'tree', 'httpd', 'vsftpd', 'docker', 'java']
      state: present


3. // Installing multiple package at the same time Using Loops

---
- hosts: all
  become: true

  tasks:
  - name: "{{ item }}"
    state: present
  with_items:
    - httpd
    - vsftpd
    - tree
    - docker
    - java

# ansible-vault create gaurav.yml
# ansible-vault view gaurav.yml
# ansible-vault edit gaurav.yml
# ansible-vault decrypt gaurav.yml
# ansible-vault encrypt gaurav.yml

// Setup Tomcat

---
- hosts: all
  become: true
  gather_facts: yes

  tasks: 
  - name: Installing Java on Linux
    yum: 
      name: java
      state: present

  - name: Download Tomcat Package
    get_url:
      url: https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.73/bin/apache-tomcat-9.0.73.tar.gz
      dest: /opt
      mode: 0755

  - name: Extracting tomcat package
    unarchive:
      src: /opt/apache-tomcat-9.0.73.tar.gz
      dest: /opt
      remote_src: yes

  - name: changing the permission
    file:
      path: /opt/apache-tomcat-9.0.73
      mode: 0755
      recurse: yes

  - name: Start the tomcat service
    shell: nohup ./startup.sh
    args:
      chdir: /opt/apache-tomcat-9.0.73/bin


// by passing variable to setup tomcat

# vi tomcat_vars.yml
tomcat_url: "https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.73/bin/apache-tomcat-9.0.73.tar.gz"
tomcat_package: apache-tomcat-9.0.73

# vi tomcat_setup_2.yml

---
- hosts: 172.31.48.162
  become: true
  gather_facts: yes
  
  vars_file: 
  - path: /home/ansadmin/tomcat_vars.yml 

  tasks:
  - name: Installing Java
    yum: 
      name: java
      state: present
  
  - name: Download Tomcat Package
    get_url:
      url: "{{ tomcat_url }}"
      dest: /opt
      mode: 0755

  - name: Extracting the package of tomcat
    unarchive:
      src: /opt/{{ tomcat_package }}.tar.gz
      dest: /opt
      remote_src: yes

  - name: Chnage the permission 
    file: 
      path: /opt/{{ tomcat_package }}
      mode: 0755
      recurse: yes

  - name: Start the tomcat service
    shell: nohup ./startup.sh
    args:
      chdir: /opt/{{ tomcat_package }}/bin


// Setup tomcat by passing variable externally and creating link file to start and restart the tomcat

# vi tomcat_vars.yml
tomcat_url: "https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.73/bin/apache-tomcat-9.0.73.tar.gz"
tomcat_package: apache-tomcat-9.0.73

# vi tomcat_setup_link.yml

---
- hosts: webservers
  become: true
  gather_facts: yes

  vars_file:
    - /home/ansadmin/tomcat_vars.yml    // I am passing variables externally

  tasks:
  - name: Install Java
    yum:
      name: java
      state: present

  - name: Download Apache Tomcat Software
    get_url:
      url: "{{ tomcat_url }}"
      dest: /opt
      mode: 0755

  - name: Extracting Apache Tomcat Software
    unarchive:
      src: /opt/{{ tomcat_package }}.tar.gz
      dest: /opt
      remote_src: yes
  
  - name: Chnaging the permission after extracting tomcat package
    file: 
      path: /opt/{{ tomcat_package }}
      mode: 0755
      recurse: yes 

  - name: Creating link file for start and stop tomcat service
    file: 
      src: /opt/{{ tomcat_package }}/bin/{{ item.tomcat_script }}
      dest: /usr/local/bin/{{ item.tomcat_cmd }}
      state: link

    loop:
      - {tomcat_script: 'startup.sh', tomcat_cmd: 'tomcatup' }
      - {tomcat_script: 'shutdown.sh', tomcat_cmd: 'tomcatdown'}
    notify: Starting Apache Tomcat Service

  - name: Chnage the port number in server.xml file using copy module
    copy:
      src: server.xml
      dest: /opt/{{ tomcat_package }}/conf/server.xml
    notify: Restarting Apache Tomcat Service

  handlers:
    - name: Starting Apache Tomcat Service
      shell: nohup /usr/local/bin/tomcatup

    - name: Restarting Apache Tomcat Service
      shell: /usr/local/bin/tomcatdown; nohup /usr/local/bin/tomcatup
    


# Clone Git repository by passing file externally
---
- name: clone git repository
  hosts:  172.31.43.215
  gather_facts: yes
  become: true
  vars_files:
    - vault1.yml

  tasks: 
  - git: 
      repo: https://{{user_name}}:{{password}}@github.com/gauravbhalekar5/Ansible-Vault.git
      dest: /home/ansadmin/vault

# ansible-playbook git_clone.yml --ask-vault-pass


Roles

# ansible-galaxy init tomcat_setup
