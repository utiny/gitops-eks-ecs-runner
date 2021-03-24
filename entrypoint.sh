#!/usr/bin/env bash

RUNNER_TOKEN="$(curl -XPOST -fsSL \
            -H "Authorization: token ${GITHUB_ACCESS_TOKEN}" \
            -H "Accept: application/vnd.github.v3+json" \
            "https://api.github.com/${SCOPE}/${_PATH}/actions/runners/registration-token" \
            | jq -r '.token')"

./config.sh \
        --url $GH_REPOSITORY \
        --token $RUNNER_TOKEN \
        --labels ${GH_RUNNER_LABELS}\
        --unattended

./run.sh --once

echo "Removing runner..."
./config.sh remove --unattended --token ${RUNNER_TOKEN}

