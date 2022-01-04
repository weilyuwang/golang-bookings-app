#!/bin/bash

go build -o bookings cmd/web/*.go
./bookings -cache=true -production=true
