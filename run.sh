#!/bin/bash

pipe=/tmp/pipe0

shutdown() {
    rm $pipe
    3<&-
}
trap shutdown EXIT

go build .

mkfifo $pipe


./simulate_stdin < $pipe &

# keeps pipe open by assigning it to file descriptor
exec 3> $pipe

while true
do
    echo "fsdfs" > $pipe
    sleep 1
done

# echo "hello" >&3

wait