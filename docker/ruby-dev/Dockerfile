FROM archlinux/base

# Base dependencies
RUN pacman --noconfirm -Sy fish git

ARG UNAME=dev
ARG UID=1000

RUN echo useradd -m $UNAME --uid $UID
RUN useradd -m $UNAME --uid $UID

RUN chsh -s /bin/bash $UNAME

# Specific dependencies for this environment
RUN pacman --noconfirm -Sy ruby ruby-bundler

# Switch over to the user
USER $UNAME
WORKDIR /home/$UNAME