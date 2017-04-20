FROM scaleway/centos:amd64-latest

# Environment
ENV SCW_BASE_IMAGE scaleway/centos:latest

# Adding and calling builder-enter
COPY ./overlay-image-tools/usr/local/sbin/scw-builder-enter /usr/local/sbin/
RUN set -e; case "${ARCH}" in \
    armv7l|armhf|arm) \
        touch /tmp/lsb-release; \
	chmod +x /tmp/lsb-release; \
	PATH="$PATH:/tmp" /bin/sh -e /usr/local/sbin/scw-builder-enter; \
	rm -f /tmp/lsb-release; \
      ;; \
    x86_64|amd64) \
        yum install -y redhat-lsb-core; \
        /bin/sh -e /usr/local/sbin/scw-builder-enter; \
        yum clean all; \
      ;; \
    esac

# Update the base OS, but skip parts that have problems if run in Docker
RUN yum --exclude=openssh-\* --exclude=policycoreutils\* --exclude=libsemanage-\* --exclude=selinux-\* --exclude=iputils update -y

# Install OpenNebula
COPY ./install-opennebula.sh /
COPY ./firstboot-opennebula.sh /
RUN bash -x /install-opennebula.sh

# Clean rootfs from image-builder
RUN /usr/local/sbin/scw-builder-leave
