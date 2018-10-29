#!/usr/bin/env bash
function setproxy() {
	local proxy_url='http://proxy-src.research.ge.com:8080'
	local no_proxy_urls='127.0.0.1,10.*,3.*,localhost,github.build.ge.com,openge.ge.com,ice.ge.com,g2ua6181mjne.logon.ds.ge.com'

	export {HTTP,HTTPS,FTP,ALL}_PROXY="${proxy_url}"
	export NO_PROXY="${no_proxy_urls}"
}

function unsetproxy() {
	unset {HTTP,HTTPS,FTP,ALL}_PROXY
	unset NO_PROXY
}
