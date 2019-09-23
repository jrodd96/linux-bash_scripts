#!/bin/bash

echo 6750 | sudo tee /sys/class/backlight/intel_backlight/brightness; 
