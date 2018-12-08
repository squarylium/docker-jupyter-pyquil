# Copyright (c) 2018 Squary
# Released under the MIT license
# https://opensource.org/licenses/MIT

FROM jupyter/minimal-notebook

LABEL maintainer="Squary"

ARG FOREST_URL="****"
ARG FOREST_VER="****"

USER root

RUN pip install pyquil && \
    apt-get update && \
    apt-get install -y screen liblapack-dev libblas-dev libffi-dev && \
    apt-get clean && \
    mkdir /tmp/forest-sdk-linux-deb && \
    wget -qO - ${FOREST_URL} | \
    tar -xj -C /tmp/forest-sdk-linux-deb --strip-components=1 && \
    echo y | /tmp/forest-sdk-linux-deb/forest-sdk-${FOREST_VER}-linux-deb.run > /dev/null

USER $NB_UID

CMD ["sh", "-c", "screen -S qvm -dm qvm -S && screen -S quilc -dm quilc -S && start-notebook.sh"]
