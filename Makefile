imx6q-wandboard.dtb: imx6q-wandboard.i
	../dtc/dtc --out-format dtb -i include --out imx6q-wandboard.dtb imx6q-wandboard.i

imx6q-wandboard.i:
	gcc -E -MD imx6q-wandboard.dts -nostdinc -undef -D__DTS__ -x assembler-with-cpp -Iinclude -o imx6q-wandboard.i imx6q-wandboard.dts

clean:
	rm -f *.i *.dtb

send: imx6q-wandboard.dtb
	scp imx6q-wandboard.dtb pi@10.6.1.173:/home/pi/

try: send
	ssh -t pi@10.6.1.173 "sudo chown root:root /home/pi/*.dtb && sudo mv /home/pi/*.dtb /boot/dtbs/ && sudo reboot"

.PHONY: clean send try
