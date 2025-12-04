if [ -d "build" ]; then
    echo "[*] Cleaning old build cache..."
    rm -rf build
fi
mkdir build
cd build

echo "[*] Configuring WiVRn Server Build with Clang 17..."
cmake .. -GNinja \
    -DCMAKE_C_COMPILER=clang-17 \
    -DCMAKE_CXX_COMPILER=clang++-17 \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/usr \
    -DCMAKE_PREFIX_PATH="$JSON_INSTALL_DIR" \
    -DWIVRN_BUILD_CLIENT=OFF \
    -DWIVRN_BUILD_DASHBOARD=OFF \
    -DWIVRN_USE_VAAPI=ON \
    -DWIVRN_USE_NVENC=ON \
    -Wno-dev

echo "[*] Compiling WiVRn Server... (This may take time)"
ninja

echo "[*] Done!"
cd ..
