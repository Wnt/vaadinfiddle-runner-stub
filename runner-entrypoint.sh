#!/usr/bin/env bash

set -o errexit
set -o pipefail
set -o nounset

chown vaadin:vaadin /fiddleapp
su vaadin -c "cd /fiddleapp; mvn jetty:run"
