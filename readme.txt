How to test the Token Based Authentication Rails based REST API

with curl (http://curl.haxx.se/download.html) you can test the REST API

    curl -H "Authorization: Token token=5e01946a5bbdd4474769b0377bedc64c" http://127.0.0.1:3001//api/v1/patients.json

How to post a request with curl

curl --data "email=joost.van.averbeke@telenet.be&password=mips1234" http://127.0.0.1:3001//api/v1/login