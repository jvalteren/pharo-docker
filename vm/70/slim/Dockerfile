#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#
FROM debian:stretch-slim

RUN set -ex \
    && buildDeps='wget unzip' \
    && runtimeDeps='ca-certificates libcairo2:i386 libc6:i386 libfreetype6:i386 libssl1.1:i386' \
    && dpkg --add-architecture i386 \
    && apt-get update \
    && apt-get install -y --no-install-recommends $buildDeps $runtimeDeps \
    && cd /usr/local/bin \
    && wget -O- http://get.pharo.org/vm70 | bash \
    && apt-get purge -y --auto-remove $buildDeps \
    && rm -rf /var/lib/apt/lists/* \
    && true

CMD ["pharo"]
	
