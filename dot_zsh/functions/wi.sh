function wi() {
  curl "https://api.whoisproxy.info/whois/$1"
  curl "https://api.whoisproxy.info/dig/$1"
  curl "http://api.db-ip.com/v2/free/$1"
}
