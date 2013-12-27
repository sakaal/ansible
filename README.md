ansible
=======

Public examples of some of my simplest Ansible playbooks

Install Fedora on a desktop or laptop with `root` only (without creating a user account).

As `root` on the newly installed machine:

    yum install git ansible
    git clone https://github.com/sakaal/ansible.git
    cd ansible

Edit `host_vars/localhost` with your profile details. Then run:

    sudo ansible-playbook local_desktop.yml -i local
    ansible-playbook local_projects.yml -i local

These are incomplete examples just to help you get started with Ansible.

* [Best Practices for Ansible playbooks](http://www.ansibleworks.com/docs/playbooks_best_practices.html)
