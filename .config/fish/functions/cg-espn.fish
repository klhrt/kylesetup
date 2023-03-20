function cg-espn --wraps='sudo cyberghostvpn --streaming espn+ --country-code US --connect' --description 'alias cg-espn=sudo cyberghostvpn --streaming espn+ --country-code US --connect'
  sudo cyberghostvpn --streaming espn+ --country-code US --connect $argv; 
end
