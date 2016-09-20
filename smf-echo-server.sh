#!/usr/bin/bash

$PORT=$(/usr/bin/svcprop -p config/port $SMF_FMRI)
$FIFO=$(/usr/bin/svcprop -p config/fifo $SMF_FMRI)
mkfio $FIFO
exec /usr/bin/nc -kl localhost 2000 > echoserver < echoserver
