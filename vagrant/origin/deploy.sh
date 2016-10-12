ssh-keygen -b 2048 -t rsa -f /root/.ssh/id_rsa -q -N ""
for host in admin1.example.com master1.example.com node1.example.com node2.example.com; \
    do ssh-copy-id -i /root/.ssh/id_rsa.pub $host; \
    done
ansible-playbook /usr/share/ansible/openshift-ansible/playbooks/byo/config.yml



