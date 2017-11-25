<!--- file: README.md -->

# ansible

Public examples of some of my simplest Ansible playbooks

This is how to quickly set up a configuration management node
based on Fedora, Git, and Ansible.

Install Fedora on a desktop, laptop, or server.
If you didn't create a non-root user account during install,
this playbook will do it for you.

As `root` on the newly installed machine:

    dnf install ansible git
    cd /etc/ansible
    git init .
    git remote add -t \* -f origin https://github.com/sakaal/ansible.git
    git fetch --all
    git reset --hard origin/master
    cp host_vars/localhost.sample host_vars/localhost

Edit `host_vars/localhost` with your profile details. Then run:

    ansible-playbook -v -i local local_node.yaml

Add the repository server host keys to `~/.ssh/known_hosts` and then run:

    ansible-playbook -v -i local working_copies.yaml

These are incomplete examples just to help you get started with Ansible.

* [Ansible Best Practices](https://docs.ansible.com/ansible/latest/playbooks_best_practices.html)
