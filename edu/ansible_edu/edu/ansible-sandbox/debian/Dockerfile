FROM docker.io/library/debian:12
RUN apt-get update && \
    apt-get install -y systemd systemd-sysv openssh-server sudo python3 cron && \
    apt-get clean && \
    ssh-keygen -A
RUN useradd -m -s /bin/bash ansible && \
    echo "ansible ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/ansible && \
    mkdir -p /home/ansible/.ssh && chmod 700 /home/ansible/.ssh
COPY authorized_keys /home/ansible/.ssh/authorized_keys
RUN chown -R ansible:ansible /home/ansible/.ssh && chmod 600 /home/ansible/.ssh/authorized_keys
STOPSIGNAL SIGRTMIN+3
CMD ["/lib/systemd/systemd"]
