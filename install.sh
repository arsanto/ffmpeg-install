yum install autoconf automake cmake freetype-devel gcc gcc-c++ git libtool make mercurial nasm pkgconfig zlib-devel -y

mkdir /usr/local/ffmpeg_build

cd /usr/local/ffmpeg_build
git clone --depth 1 https://github.com/arsanto/yasm.git
cd yasm
autoreconf -fiv
./configure --prefix="/usr/local/ffmpeg_build" --bindir="/usr/local/bin"
make
make install
make distclean

cd /usr/local/ffmpeg_build
git clone --depth 1 https://github.com/arsanto/x264.git
cd x264
./configure --prefix="/usr/local/ffmpeg_build" --bindir="/usr/local/bin" --enable-static
make
make install
make distclean

cd /usr/local/ffmpeg_build
#hg clone https://bitbucket.org/multicoreware/x265
git clone --depth 1 https://github.com/arsanto/x265.git
cd x265/build/linux
cmake -G "Unix Makefiles" -DCMAKE_INSTALL_PREFIX="/usr/local/ffmpeg_build" -DENABLE_SHARED:bool=off ../../source
make
make install

cd /usr/local/ffmpeg_build
git clone --depth 1 https://github.com/arsanto/fdk-aac.git
cd fdk-aac
autoreconf -fiv
./configure --prefix="/usr/local/ffmpeg_build" --disable-shared
make
make install
make distclean


cd /usr/local/ffmpeg_build
git clone --depth 1 https://github.com/arsanto/lame.git
cd lame
./configure --prefix="/usr/local/ffmpeg_build" --bindir="/usr/local/bin" --disable-shared --enable-nasm
make
make install
make distclean

cd ~/ffmpeg_sources
git clone --depth 1 https://github.com/arsanto/opus.git
cd opus
autoreconf -fiv
./configure --prefix="/usr/local/ffmpeg_build" --disable-shared
make
make install
make distclean

cd /usr/local/ffmpeg_build
git clone --depth 1 https://github.com/arsanto/libogg.git
cd libogg
./configure --prefix="/usr/local/ffmpeg_build" --disable-shared
make
make install
make distclean

cd /usr/local/ffmpeg_build
git clone --depth 1 https://github.com/arsanto/libvorbis.git
cd libvorbis
LDFLAGS="-L$HOME/ffmeg_build/lib" CPPFLAGS="-I/usr/local/ffmpeg_build/include" ./configure --prefix="/usr/local/ffmpeg_build" --with-ogg="/usr/local/ffmpeg_build" --disable-shared
make
make install
make distclean

cd /usr/local/ffmpeg_build
git clone --depth 1 https://github.com/arsanto/libvpx.git
cd libvpx
./configure --prefix="/usr/local/ffmpeg_build" --disable-examples
make
make install
make clean

cd /usr/local/ffmpeg_build
git clone --depth 1 https://github.com/arsanto/ffmpeg.git
cd ffmpeg
PKG_CONFIG_PATH="/usr/local/ffmpeg_build/lib/pkgconfig" ./configure --prefix="/usr/local/ffmpeg_build" --extra-cflags="-I/usr/local/ffmpeg_build/include" --extra-ldflags="-L/usr/local/ffmpeg_build/lib" --bindir="/usr/local/bin" --pkg-config-flags="--static" --enable-gpl --enable-nonfree --enable-libfdk-aac --enable-libfreetype --enable-libmp3lame --enable-libvorbis --enable-libvpx --enable-libx264 --enable-libx265
make
make install
make distclean
hash -r

clear

ffmpeg --version
