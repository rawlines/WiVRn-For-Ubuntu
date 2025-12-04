echo "[*] Installing Clang 17..."
sudo apt update
sudo apt install -y lsb-release wget software-properties-common gnupg
wget https://apt.llvm.org/llvm.sh
chmod +x llvm.sh
sudo ./llvm.sh 17
rm llvm.sh

echo "[*] Adding Ubuntu Toolchain PPA for Libstdc++-13..."
sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
sudo apt update
sudo apt install -y libstdc++-13-dev

echo "[*] Adding LunarG Vulkan SDK Repository..."
wget -qO- https://packages.lunarg.com/lunarg-signing-key-pub.asc | sudo tee /etc/apt/trusted.gpg.d/lunarg.asc > /dev/null
sudo wget -qO /etc/apt/sources.list.d/lunarg-vulkan-jammy.list http://packages.lunarg.com/vulkan/lunarg-vulkan-jammy.list
sudo apt update

echo "[*] Adding Boost PPA..."
sudo add-apt-repository -y ppa:mhier/libboost-latest
sudo apt update

echo "[*] Installing System Dependencies..."
sudo apt install -y \
    build-essential cmake ninja-build pkg-config git curl wget \
    vulkan-sdk \
    libxrandr-dev libx11-xcb-dev libxcb-randr0-dev libxcb-dri2-0-dev libxcb-dri3-dev libxcb-present-dev \
    libwayland-dev wayland-protocols \
    libdrm-dev libudev-dev libusb-1.0-0-dev \
    libgl-dev libegl-dev \
    libopencv-dev libeigen3-dev \
    libavcodec-dev libavdevice-dev libavfilter-dev libavutil-dev libswscale-dev \
    libva-dev libssl-dev libdbus-1-dev \
    nvidia-cuda-toolkit \
    libx264-dev \
    libavahi-glib-dev libavahi-client-dev gettext \
    libpulse-dev libsystemd-dev librsvg2-dev \
    libcli11-dev \
    libboost1.83-all-dev \
    libpipewire-0.3-dev \
    libglib2.0-dev \
    checkinstall

JSON_INSTALL_DIR="$(pwd)/json_install"
if [ ! -d "$JSON_INSTALL_DIR" ]; then
    echo "[*] Downloading nlohmann-json 3.11.3..."
    git clone -b v3.11.3 --depth 1 https://github.com/nlohmann/json.git nlohmann_json_src
    mkdir -p nlohmann_json_src/build
    cd nlohmann_json_src/build
    cmake .. -DCMAKE_INSTALL_PREFIX="$JSON_INSTALL_DIR" -DJSON_BuildTests=OFF -DCMAKE_CXX_COMPILER=clang++-17
    make install
    cd ../..
    rm -rf nlohmann_json_src
fi
echo "[*] nlohmann-json installed to $JSON_INSTALL_DIR"
export JSON_INSTALL_DIR
