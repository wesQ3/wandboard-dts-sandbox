TARGET=10.6.1.88
USER=wandboard

imx6q-wandboard.dtb: imx6q-wandboard.i
	../dtc/dtc --out-format dtb -i include --out imx6q-wandboard.dtb imx6q-wandboard.i

imx6q-wandboard.i:
	gcc -E -MD imx6q-wandboard.dts -nostdinc -undef -D__DTS__ -x assembler-with-cpp -Iinclude -o imx6q-wandboard.i imx6q-wandboard.dts

imx6dl-wandboard.dtb: imx6dl-wandboard.i
	../dtc/dtc --out-format dtb -i include --out imx6dl-wandboard.dtb imx6dl-wandboard.i

imx6dl-wandboard.i:
	gcc -E -MD imx6dl-wandboard.dts -nostdinc -undef -D__DTS__ -x assembler-with-cpp -Iinclude -o imx6dl-wandboard.i imx6dl-wandboard.dts

clean:
	rm -f *.i *.dtb *.d

send: imx6q-wandboard.dtb imx6dl-wandboard.dtb
	scp *.dtb $(USER)@$(TARGET):/home/$(USER)/

try: send
	ssh -t $(USER)@$(TARGET) "sudo chown root:root /home/$(USER)/*.dtb && sudo mv /home/$(USER)/*.dtb /boot/boot/ && sudo reboot"

.PHONY: clean send try
