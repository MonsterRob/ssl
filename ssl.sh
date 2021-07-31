#!/bin/sh
echo "ca"
openssl genrsa -out ca.key 2048
openssl req -config conf.cnf -newkey rsa:2048 -x509 -days 3650 -key ca.key -out ca.crt 
echo "server"
openssl genrsa -out server.key 2048
openssl req -config conf.cnf -new -key server.key -out server.csr
openssl x509 -req -in server.csr -days 3650  -sha256 -CAcreateserial -CA ca.crt -CAkey ca.key -out server.crt 
# openssl x509 -req -in server.csr -days 3650  -CAcreateserial -CA ca.crt -CAkey ca.key -out server.crt -extfile extfile.conf # This is for SANs config 

echo "client"
openssl genrsa -out client.key 2048
openssl req -config conf.cnf -new -key client.key -out client.csr
openssl x509 -req -in client.csr -days 3650  -sha256 -CAcreateserial -CA ca.crt -CAkey ca.key -out client.crt

rm -rf *.csr
rm ca.key
rm ca.srl

rm -rf ssl
mkdir ssl
mv ca.crt ssl/ca.crt
mv server.key ssl/server.key
mv server.crt ssl/server.crt
mv client.key ssl/client.key
mv client.crt ssl/client.crt
