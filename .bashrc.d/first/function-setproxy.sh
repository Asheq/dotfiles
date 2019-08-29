function setproxy() {
  local proxy_url=''
  local no_proxy_urls=''

  # Uppercase letters
  export {HTTP,HTTPS,FTP,ALL}_PROXY="${proxy_url}"
  export NO_PROXY="${no_proxy_urls}"

  # Lowercase letters
  export {http,https,ftp,all}_proxy="${proxy_url}"
  export no_proxy="${no_proxy_urls}"
}

function unsetproxy() {
  # Uppercase letters
  unset {HTTP,HTTPS,FTP,ALL}_PROXY
  unset NO_PROXY

  # Lowercase letters
  unset {http,https,ftp,all}_proxy
  unset no_proxy
}
