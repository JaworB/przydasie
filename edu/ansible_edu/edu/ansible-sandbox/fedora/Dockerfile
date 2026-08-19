FROM registry.fedoraproject.org/fedora:latest
RUN dnf -y install systemd openssh-server sudo passwd python3 cronie && \
    dnf clean all && \
    systemctl enable sshd && \
    ssh-keygen -A
RUN useradd -m -s /bin/bash ansible && \
    echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible && \
    mkdir -p /home/ansible/.ssh && chmod 700 /home/ansible/.ssh
COPY authorized_keys /home/ansible/.ssh/authorized_keys
RUN chown -R ansible:ansible /home/ansible/.ssh && chmod 600 /home/ansible/.ssh/authorized_keys
STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
