add_header Strict-Transport-Security "max-age=31449600; includeSubDomains" always;
# add_header Content-Security-Policy "object-src 'none'; script-src 'self'; script-src-elem 'self'; base-uri 'self'; require-trusted-types-for 'script'" always;
add_header Content-Security-Policy "object-src 'none'; script-src 'self'; script-src-elem 'self'; base-uri 'self'" always;
add_header X-Frame-Options "DENY" always;
add_header X-Content-Type-Options "nosniff" always;
add_header Referrer-Policy "strict-origin" always;
add_header Feature-Policy "microphone 'none'; geolocation 'none'; camera 'none'" always;
