# Description: Generate .gitignore via toptal API (e.g. gi node,python)
function gi() { curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;}