ARG VERSION_BASE

FROM jrei/systemd-ubuntu

RUN apt-get update

RUN apt-get install -y sudo \
											 apt-utils \
                       net-tools \
                       sudo \
                       openssh-server \
                       vim

RUN apt-get install -y perl \
                       nano \
											 openjdk-8-jdk \
											 ant \
											 samba
                      
COPY smb.conf /etc/samba/smb.conf

# Reference:
# ISO 8601, RFC 3339
#   - Command: $(date -u +'%Y-%m-%dT%H:%M:%SZ')
ARG CREATED

# Reference:
# Semantic Versioning Specification (SemVer)
#  - https://semver.org
#
# A normal version number MUST take the form X.Y.Z where X, Y, and Z are non-negative integers, and MUST NOT contain leading zeroes.
ARG VERSION

# Git commit ID
#   - Command: $(git log -1 --format=%h)
ARG REVISION

# Docker Image Tag
#   - Command: $(git symbolic-ref -q --short HEAD)
#   - or Command: $(git describe --tags --exact-match)
ARG REF_NAME

# Reference:
# OCI Image Format Specification
#   - https://github.com/opencontainers/image-spec/blob/master/annotations.md
LABEL org.opencontainers.image.created=$CREATED \
      org.opencontainers.image.authors="youngjinj@cubrid.com" \
      org.opencontainers.image.url="https://github.com/youngjinj/cubrid-dev-containers.git" \
      org.opencontainers.image.version=$VERSION \
      org.opencontainers.image.revision=$REVISION \
      org.opencontainers.image.vendor="CUBRID" \
      org.opencontainers.image.ref.name=$REF_NAME \
      org.opencontainers.image.title="CUBRID Development Image"

RUN echo $' \
\n# Minimize swap usage \
\n# \
\n#  - Default: vm.swappiness = 60 \
\nvm.swappiness = 1' >> /etc/sysctl.conf

RUN    sed "/# End of file/d" -i /etc/security/limits.conf \
    && echo $' \
\n*               soft    core            unlimited \
\n*               soft    nofile          32768 \
\n*               soft    nproc           16384 \
\n \
\n*               hard    core            unlimited \
\n*               hard    nofile          32768 \
\n*               hard    nproc           16384 \
\n \
\n# End of file' >> /etc/security/limits.conf
#\n# End of file' >> /etc/security/limits.conf \
#    && sed -i "s/^\([*|root].*\)/# \1/" /etc/security/limits.d/20-nproc.conf

#RUN    sed -i "s/^\(%admin[[:space:]]ALL=(ALL)[[:space:]]ALL\)/# \1/" /etc/sudoers \
#    && sed -i "s/^# \(%admin[[:space:]]ALL=(ALL)[[:space:]]NOPASSWD: ALL\)/\1/" /etc/sudoers

RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

COPY create_user_cubrid.sh /root/create_user_cubrid.sh

RUN chmod +x /root/create_user_cubrid.sh

ENTRYPOINT ["/usr/sbin/init"]
