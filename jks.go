package main

import (
	"fmt"

	"github.com/square/certigo/jceks"
)

func main() {

	ks, err := jceks.LoadFromFile("client.jks", []byte("1234567890"))
	if err != nil {
		fmt.Println(err, "  ---->")
		return
	}
	fmt.Println(ks.ListCerts())
	for _, name := range ks.ListCerts() {
		crt, err := ks.GetCert(name)
		if err != nil {
			fmt.Println(err)
			return
		}
		fmt.Println(crt.Subject)
	}
	

}
