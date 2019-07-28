#! /bin/bash
echo $SOME_VAR >> /usr/share/nginx/html/index.html
nginx -g 'daemon off;'
