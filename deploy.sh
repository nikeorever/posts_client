#!/usr/bin/env bash

flutter build web
if [ $? -eq 0 ]; then
  echo 'Generate release build OK'

  cp ./build/web/* -r ~/nikeo.cn/
  if [ $? -eq 0 ]; then
    echo 'Copy web resources OK'
  else
    echo 'Copy web resources FAIL'
  fi
else
  echo 'Generate release build FAIL'
fi