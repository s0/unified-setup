FROM archlinux/base

# Base dependencies
RUN pacman --noconfirm -Sy fish git python awk base-devel

ARG UNAME=dev
ARG UID=1000

RUN useradd -m $UNAME --uid $UID

RUN chsh -s /bin/bash $UNAME

# Specific dependencies for this environment
RUN pacman --noconfirm -S ruby ruby-bundler
RUN pacman --noconfirm -S nodejs npm

# Switch over to the user
USER $UNAME
WORKDIR /home/$UNAME