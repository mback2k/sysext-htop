build: torcx.tgz torcx.squashfs


ncurses.tar.gz:
	wget -q https://invisible-island.net/datafiles/release/ncurses.tar.gz -O ncurses.tar.gz

ncurses: ncurses.tar.gz
	tar -xzf ncurses.tar.gz
	mv ncurses-* ncurses
	cd ncurses && ./configure --enable-const --enable-getcap --enable-termcap --enable-widec \
		--with-default-terminfo-dir=/etc/terminfo --with-terminfo-dirs=/etc/terminfo:/lib/terminfo:/usr/share/terminfo \
		--with-xterm-kbs=del --without-debug --without-profile --without-progs --without-tests
	cd ncurses && make CFLAGS="-static"
	cd ncurses/include && ln -s curses.h ncurses.h


htop.tar.gz:
	wget -q https://github.com/htop-dev/htop/archive/3.0.3.tar.gz -O htop.tar.gz

htop: htop.tar.gz ncurses
	tar -xzf htop.tar.gz
	mv htop-* htop
	cd htop && ./autogen.sh && ./configure --enable-unicode CPPFLAGS="-I../ncurses/include" LDFLAGS="-L../ncurses/lib"
	cd htop && make


torcx: htop
	mkdir -p rootfs/bin
	cp -a htop/htop rootfs/bin/

torcx.tgz: torcx
	tar -C rootfs -czf torcx.tgz .

torcx.squashfs: torcx
	mksquashfs rootfs torcx.squashfs
