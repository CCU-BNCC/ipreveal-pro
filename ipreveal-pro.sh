#!/data/data/com.termux/files/usr/bin/bash

#========= Colors ===========#
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

#========= Banner ===========#
clear
echo -e "${RED}
 █████╗ 
██╔══██╗
███████║
██╔══██║
██║  ██║
╚═╝  ╚═╝
${NC}"
echo -e "${CYAN}      RJ Presents: Hidden URL/IP Revealer Pro     ${NC}"
echo -e "${YELLOW}=================================================${NC}"

#========= Internet Check ===========#
echo -e "${BLUE}[~] Checking Internet Connection...${NC}"
ping -c 1 1.1.1.1 > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo -e "${RED}[!] No Internet Connection. Exiting.${NC}"
    exit 1
fi
echo -e "${GREEN}[✓] Internet Connected.${NC}"

#========= URL Input ===========#
echo -e "${YELLOW}[+] Enter multiple shortened URLs separated by space:${NC}"
read -p "> " urls

#========= Input Validation ===========#
if [ -z "$urls" ]; then
    echo -e "${RED}[!] No URLs provided. Exiting.${NC}"
    exit 1
fi

#========= Process URLs ===========#
for url in $urls; do
    echo -e "${CYAN}-------------------------------------------${NC}"
    echo -e "${BLUE}URL: $url${NC}"

    if [[ ! "$url" =~ ^https?:// ]]; then
        echo -e "${RED}[!] Invalid URL. Must start with http:// or https://${NC}"
        continue
    fi

    #========= Reveal Final Destination ===========#
    final_url=$(curl -Ls -o /dev/null -w %{url_effective} "$url")

    #========= HTTP Status Code ===========#
    status_code=$(curl -s -o /dev/null -w "%{http_code}" "$final_url")

    echo -e "${GREEN}[+] Final Destination: $final_url${NC}"
    echo -e "${YELLOW}[i] HTTP Status Code: $status_code${NC}"

    #========= Extract IP ===========#
    domain=$(echo "$final_url" | awk -F/ '{print $3}')
    ip=$(ping -c 1 "$domain" 2>/dev/null | grep -oP '\K[0-9.]+(?=)')

    if [ -n "$ip" ]; then
        echo -e "${GREEN}[+] Resolved IP: $ip${NC}"
    else
        echo -e "${RED}[-] Could not resolve IP.${NC}"
    fi
done

echo -e "${CYAN}===========================================${NC}"
echo -e "${GREEN}[✓] All URLs processed.${NC}"
