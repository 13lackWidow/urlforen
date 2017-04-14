#!/usr/bin/env bash

# command line vars
opt=$1
url=$2

# pause funct
function pause() {
	read -sn 1 -p "Press any key to continue..."
}

# unshorten funct
function unshorten {
  curl "https://unshorten.me/s/$url"
  exit
}

# forensics w/ proxy
function foren {
  echo "Obtaining header from "$url"."
  echo
  proxychains-ng curl -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.112 Safari/534.30" -I "$url"
  echo
  echo "Obtaining source from "$url"."
  echo
  proxychains-ng curl -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.112 Safari/534.30" "$url"
  exit
}

# forensics w /o proxy
function noproxy {
  echo "WARNING. YOU ARE PREFORMING FORENSICS ON A URL WITHOUT A PROXY!!!"
  pause
  clear
  echo "Obtaining header from "$url"."
  echo
  curl -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.112 Safari/534.30" -I "$url"
  echo
  echo "Obtaining source from "$url"."
  echo
  curl -A "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_6_8) AppleWebKit/534.30 (KHTML, like Gecko) Chrome/12.0.742.112 Safari/534.30" "$url"
  exit
}

# just in case...
function helpme {
  echo "Usage: urlforen [option] url"
  echo
  echo "-h,  This menu."
  echo "-s,  Unshortens the URL."
  echo "-n,  Preforms forensics on URL without the use of proxychains."
  echo
  echo "Proxychains and curl must be installed for this to work."
  exit
}

# The heart of the script
if [[ $opt == "-s" ]]; then
  unshorten

elif [[ $opt == "-n" ]]; then
  noproxy

elif [[ $opt == "-h" ]]; then
  helpme

else
  url=$opt
  foren

fi
