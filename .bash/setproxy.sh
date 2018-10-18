function setproxy() {
	proxy_url='http://proxy-src.research.ge.com:8080'
	no_proxy_urls='127.0.0.1,10.*,3.*,localhost,github.build.ge.com,openge.ge.com,ice.ge.com,g2ua6181mjne.logon.ds.ge.com'

	export {http,https,ftp,all}_proxy=$proxy_url
	export {HTTP,HTTPS,FTP,ALL}_PROXY=$proxy_url
	export no_proxy=$no_proxy_urls
	export NO_PROXY=$no_proxy_urls
}

function unsetproxy() {
	unset {http,https,ftp,all}_proxy
	unset {HTTP,HTTPS,FTP,ALL}_PROXY
	unset {no_proxy,NO_PROXY}
}
