FROM maven:3.6-jdk-8-slim

ENV STOCATOR_VERSION 1.0.31-ibm-sdk

WORKDIR /

RUN set -ex \
    && apt-get update -yqq \
    && mkdir /stocator-${STOCATOR_VERSION} \
    && curl -L https://api.github.com/repos/CODAIT/stocator/tarball/${STOCATOR_VERSION} | tar zxf - -C /stocator-${STOCATOR_VERSION} --strip=1 \
    && cd stocator-${STOCATOR_VERSION} \
    && mvn clean package -Pall-in-one \
    && upper=$(echo ${STOCATOR_VERSION} | awk '{print toupper($0)}') \
    && cp /stocator-${STOCATOR_VERSION}/target/stocator-${upper}.jar /stocator-${STOCATOR_VERSION}/target/stocator-${STOCATOR_VERSION}.jar

CMD ["cp", "/stocator-${STOCATOR_VERSION}/target/stocator-${STOCATOR_VERSION}.jar", "/stocator-${STOCATOR_VERSION}.jar"]