#!/bin/bash

flutter build web
cp -a build/web/. public/
