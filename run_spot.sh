#!/bin/bash
export LD_PRELOAD=/usr/lib/xcbstub.so
/usr/bin/spotify --enable-features=UseOzonePlatform --ozone-platform=wayland --uri=%U
