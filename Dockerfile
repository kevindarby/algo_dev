FROM kevindarby/linux_docker


# add user algo
RUN groupadd --gid 1000 algo && \
    useradd -s /bin/bash --uid 1000 --gid 1000 -m algo && \
    mkdir -p /sparkbin/plugins && \
    mkdir /sparkdata && \
    mkdir /sdk && \
    ln -s /sparkbin/ /sdk/lib && \
    echo algo ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/algo && \
    chmod 0440 /etc/sudoers.d/algo && \
    chown -R algo.algo /sparkbin/plugins && \
    chmod +777 /sparkbin/plugins && \
    chown -R algo.algo /sparkdata 

# copy bare min for dev
COPY sdk_spark.conf /sparkdata/conf/
COPY --chown=algo futures.coconut /sparkdata/data/replay/futures.coconut
