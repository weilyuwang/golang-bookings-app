#!/bin/bash

go build -o bookings cmd/web/*.go && ./bookings
./bookings -dbname=bookings -dbuser=weilyuwang -cache=false -production=false
