FROM ubuntu:22.04

RUN apt update && apt install -y openssh-server sudo python3 python3-pip vim iputils-ping net-tools

RUN useradd -m -s /bin/bash ansible && \
    echo 'ansible:ansible' | chpasswd && \
    echo 'ansible ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

RUN mkdir /var/run/sshd
EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
COPY setup.sh /setup.sh
RUN chmod +x /setup.sh

#ENTRYPOINT ["/setup.sh"]
