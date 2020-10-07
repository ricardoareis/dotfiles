FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update &&                                               \
        apt-get install --no-install-recommends -y autoconf curl    \
        build-essential file git language-pack-en-base bsdmainutils \
        libbz2-dev libffi-dev libreadline-dev sudo wget cpio        \
        libsqlite3-dev libssl-dev ncurses-dev  ca-certificates      \
        pkg-config subversion zlib1g-dev zsh less automake #tmux

ENV ZINIT_VERSION=v3.1
ENV TERM=xterm
ENV REPO_DIR=repos/dotfiles

# user setup
ARG luser=kings
ENV LUSER=${luser}

RUN groupadd -r ${LUSER} -g 666
RUN useradd -m -u 666 -r -g 666 -s /usr/bin/zsh ${LUSER}
RUN adduser ${LUSER} sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER ${LUSER}
WORKDIR /home/${LUSER}

COPY --chown=666:666 ./ ${REPO_DIR}

WORKDIR /home/${LUSER}/${REPO_DIR}

RUN git -C .zinit/bin checkout ${ZINIT_VERSION}

RUN make zshrc && \
    zsh -c "source .zinit/bin/zinit.zsh && zinit module build"

RUN zsh -i -c "source .zinit/bin/zinit.zsh && @zinit-scheduler burst || true"

WORKDIR /home/${LUSER}
