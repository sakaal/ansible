<!--- file: README.md -->

ansible
=======

Public examples of some of my simplest Ansible playbooks

This is how to quickly set up a Java development environment
based on Fedora, Oracle JDK 8, Git, Maven and Eclipse Luna.

Install Fedora on a desktop or laptop.
If you don't create a developer user account during install,
this playbook will do it for you.

As `root` on the newly installed machine:

    yum install git ansible
    git clone https://github.com/sakaal/ansible.git
    cd ansible
    cp host_vars/localhost.sample host_vars/localhost

Edit `host_vars/localhost` with your profile details. Then run:

    ansible-playbook local_desktop.yml -i local

As the developer user, add your repository server host key to your `~/.ssh/known_hosts` and then run:

    ansible-playbook local_projects.yml -i local

These are incomplete examples just to help you get started with Ansible.

* [Best Practices for Ansible playbooks](http://www.ansibleworks.com/docs/playbooks_best_practices.html)
