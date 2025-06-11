FROM ubuntu:questing-20250601

ARG ZIG_VERSION
ARG MINISIGN_VERSION

RUN mkdir -p /opt/build
COPY /tools/build.sh /opt/build
RUN chmod +x /opt/build/build.sh \
  && /opt/build/build.sh

#RUN apt-get update -yqq && apt-get install -yqq \
#    gdb

USER developer
WORKDIR /home/dev
ENV PATH="$PATH:/home/dev/.local/bin"

#ADD --chown=developer:developer install-zig.sh install-zig.sh
#RUN chmod +x install-zig.sh && ./install-zig.sh ${ZIG_VERSION} ${MINISIGN_VERSION}
