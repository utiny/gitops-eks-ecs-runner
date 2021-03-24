FROM ubuntu:18.04

ARG RUNNER_VERSION=2.277.1

ENV GH_REPOSITORY=
ENV GH_RUNNER_LABELS=
ENV GITHUB_ACCESS_TOKEN=
ENV SCOPE=
ENV _PATH=

RUN useradd -m actions
RUN apt-get -yqq update && apt-get install -yqq curl jq wget

RUN \
  cd /home/actions && mkdir actions-runner && cd actions-runner \
    && wget https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz \
    && tar xzf ./actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz

WORKDIR /home/actions/actions-runner
RUN chown -R actions ~actions && /home/actions/actions-runner/bin/installdependencies.sh

USER actions
COPY entrypoint.sh .
#RUN chmod +x entrypoint.sh
ENTRYPOINT ["./entrypoint.sh"]


