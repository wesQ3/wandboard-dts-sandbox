imx6q-wandboard.dtb: imx6q-wandboard.i
	../dtc/dtc --out-format dtb -i include --out imx6q-wandboard.dtb imx6q-wandboard.i

imx6q-wandboard.i:
	gcc -E -MD imx6q-wandboard.dts -nostdinc -undef -D__DTS__ -x assembler-with-cpp -Iinclude -o imx6q-wandboard.i imx6q-wandboard.dts

clean: 
	rm *.i *.dtb

.PHONY: clean
