FROM kevindarby/linux_docker


# Set version with --build-arg SDK_VERSION=X
# This lets us query an image to see when it was built
ARG SDK_VERSION=0
ARG SDK_BUILD_DATE=0

# configure build_examples
env SDK_ROOT=/sdk \
    SDK_VERSION=$SDK_VERSION \
    SDK_BUILD_DATE=$SDK_BUILD_DATE

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
    chmod +777 /sparkbin/plugins \
    chown -R algo.algo /sparkdata 

# copy sdk
# fuck why isn't this working
#COPY include/ /sdk/include/
#COPY lib/ /sparkbin/
#COPY externals /sdk/externals/
COPY sdk_spark.conf /sparkdata/conf/
COPY --chown=bts futures.coconut /sparkdata/data/replay/futures.coconut
