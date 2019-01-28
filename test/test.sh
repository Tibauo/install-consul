#!/bin/bash
docker run --net=host test-consul consul --version
retour=$?

if [ $retour == 0 ]; then
  echo "[SUCCESS]"
else
  echo "[FAILED]"
  exit $retour
fi
