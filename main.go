package main

import (
	"encoding/base64"
	"fmt"

	"github.com/DataDog/zstd"
)

func main() {
	in := []byte("Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.")
	out, err := zstd.Compress(nil, in)
	if err != nil {
		panic(err)
	}
	fmt.Println("in:", base64.StdEncoding.EncodeToString(in))
	fmt.Println()
	fmt.Println("out:", base64.StdEncoding.EncodeToString(out))
	fmt.Println()

	decompressed, err := zstd.Decompress(nil, out)
	if err != nil {
		panic(err)
	}
	fmt.Println("decompressed:", string(decompressed))
}
