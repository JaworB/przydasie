FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    openssh-server \
    python3 \
    python3-pip \
    rsyslog \
    sudo \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --break-system-packages passlib

RUN mkdir /var/run/sshd

RUN ssh-keygen -A

RUN useradd -m -s /bin/bash ansible_user && \
    echo 'ansible_user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

COPY authorized_keys /home/ansible_user/.ssh/authorized_keys
RUN chown ansible_user:ansible_user /home/ansible_user/.ssh/authorized_keys && \
    chmod 600 /home/ansible_user/.ssh/authorized_keys

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
