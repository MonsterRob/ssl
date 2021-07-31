#!/bin/sh

keytool -import -keystore client.jks -storetype JKS -file ssl/ca.crt -alias CARoot 
keytool -import -keystore client.jks -file ssl/client.crt -alias client
keytool -list -v -keystore client.jks