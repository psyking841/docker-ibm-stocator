FROM maven:3.6-jdk-8-slim

ENV STOCATOR_VERSION 1.0.31-ibm-sdk

WORKDIR /

RUN set -ex \
    && apt-get update -yqq \
    && apt-get install -yqq --no-install-recommends wget zip unzip \
    && wget https://github.com/CODAIT/stocator/archive/${STOCATOR_VERSION}.zip \
    && unzip ${STOCATOR_VERSION}.zip \
    && cd stocator-${STOCATOR_VERSION} \
    && mvn clean package -Pall-in-one \
    && upper=$(echo ${STOCATOR_VERSION} | awk '{print toupper($0)}') \
    && cp /stocator-${STOCATOR_VERSION}/target/stocator-${upper}.jar /stocator-${STOCATOR_VERSION}/target/stocator-${STOCATOR_VERSION}.jar

CMD ["cp", "/stocator-${STOCATOR_VERSION}/target/stocator-${STOCATOR_VERSION}.jar", "/stocator-${STOCATOR_VERSION}.jar"]