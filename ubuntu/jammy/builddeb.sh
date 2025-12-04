cd build

echo "[*] Creating .deb package..."
sudo checkinstall \
    --default \
    --type=debian \
    --install=no \
    --pkgname=wivrn-server \
    --pkgversion="25.11.1" \
    --pkglicense=GPL3 \
    --pakdir=. \
    --fstrans=no \
    ninja install
