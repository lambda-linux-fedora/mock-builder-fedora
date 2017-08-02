FROM baseimage-fedora:latest

CMD ["/sbin/my_init"]

COPY [ \
  "./docker-extras/etc-mock-default.cfg", \
  "./docker-extras/etc-sudoers.d-docker", \
  "/tmp/docker-build/" \
]

RUN \
  # yum
  dnf update -y && \
  \
  # install mock
  dnf install -y cpio && \
  dnf install -y git && \
  dnf install -y python2 && \
  dnf install -y sudo && \
  dnf install -y tree && \
  dnf install -y vim && \
  dnf install -y which && \
  dnf install -y mock mock-scm && \
  \
  # setup symbolic link
  ln -s /home/ll-user/mock-builder-fedora/git-blobs /tmp/git-blobs.lambda-linux.io && \
  \
  # copy mock configuration file
  cp /tmp/docker-build/etc-mock-default.cfg /etc/mock/default.cfg && \
  \
  # setup sudo
  usermod -a -G wheel ll-user && \
  cp /tmp/docker-build/etc-sudoers.d-docker /etc/sudoers.d/docker && \
  chmod 440 /etc/sudoers.d/docker && \
  \
  # add ll-user to mock group
  usermod -a -G mock ll-user && \
  \
  # cleanup
  rm -rf /tmp/docker-build && \
  dnf clean all && \
  rm -rf /var/cache/dnf/* && \
  rm -rf /var/tmp/*
