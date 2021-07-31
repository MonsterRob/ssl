echo "ca"
openssl genrsa -out ca.pem 2048
openssl req -config conf.cnf -newkey rsa:2048 -x509 -days 3650 -key ca.pem -out ca.crt 
echo "server"
openssl genrsa -out server.key 2048
openssl req -config conf.cnf -new -key server.key -out server_reqout.txt 
openssl x509 -req -in server_reqout.txt -days 3650 -sha1 -CAcreateserial -CA ca.crt -CAkey ca.pem -out server.crt -extfile extfile.cnf
echo "client"
openssl genrsa -out client.key 2048
openssl req -config conf.cnf -new -key client.key -out client_reqout.txt 
openssl x509 -req -in client_reqout.txt -days 3650 -sha1 -CAcreateserial -CA ca.crt -CAkey ca.pem -out client.crt
rm -rf *reqout* ca.pem ca.srl 
mkdir ssl
mv ca.crt ssl/ca.crt
mv server.key ssl/server.key
mv server.crt ssl/server.crt
mv client.key ssl/client.key
mv client.crt ssl/client.crt
