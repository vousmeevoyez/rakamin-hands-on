#!/bin/bash
for i in {1..5}; do
  curl -s -o /dev/null -w "%{http_code}\n" -X GET https://9gpg4lpj-80.asse.devtunnels.ms/
  sleep 1
done
