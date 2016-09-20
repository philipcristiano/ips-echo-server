#!/usr/bin/bash

mkfio echoserver
exec /usr/bin/nc -kl localhost 2000 > echoserver < echoserver
