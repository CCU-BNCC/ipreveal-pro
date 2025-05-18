#!/bin/bash

# Banner
echo -e "\e[1;31m"
echo "     A"
echo -e "\e[0m"

# Check internet connection
ping -q -c 1 -W 1 google.com > /dev/null
if [ $? -ne 0 ]; then
  echo -e "\e[1;31m[!] ইন্টারনেট সংযোগ নেই! অনুগ্রহ করে ইন্টারনেট চালু করুন।\e[0m"
  exit 1
fi

# Install curl if not available
if ! command -v curl &> /dev/null; then
  echo -e "\e[1;33m[*] curl ইনস্টল করা হচ্ছে...\e[0m"
  pkg install curl -y
fi

# Make script executable
chmod +x ipreveal-pro.sh

# Run the main script
bash ipreveal-pro.sh
