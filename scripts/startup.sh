# Update
apt-get upgrade -y
apt-get update -y

# Install main packages
apt-get install git nano curl cargo alsa-utils -y

# Install and configure mDNS (Avahi)
apt-get install -y avahi-daemon avahi-utils
sed -i 's/#use-dbus=yes/use-dbus=no/' /etc/avahi/avahi-daemon.conf
service avahi-daemon start

# Dependencies for librespot
apt-get install g++ pkg-config libx11-dev libasound2-dev libudev-dev -y

# Clone librespot if it doesn't exist
FILE=/app/librespot/Cargo.toml
if test ! -f "$FILE"; then
    git clone https://github.com/librespot-org/librespot.git /app/librespot
fi

# Build librespot if it hasn't been built
FILE=/app/librespot/target/release/librespot
if test ! -f "$FILE"; then
    cd /app/librespot
    cargo build --release
    export PATH=$PATH:/app/librespot/target/release/
    echo 'export PATH=$PATH:/app/librespot/target/release/' >> ~/.bashrc
    source ~/.bashrc
fi

# Update PATH for librespot
export PATH=$PATH:/app/librespot/target/release/
echo 'export PATH=$PATH:/app/librespot/target/release/' >> ~/.bashrc
source ~/.bashrc

# Check if the necessary environment variables are set
if [ -z "$LIBRESPOT_USERNAME" ] || [ -z "$LIBRESPOT_PASSWORD" ] || [ -z "$LIBRESPOT_ARGS" ]; then
    echo "Please ensure LIBRESPOT_USERNAME, LIBRESPOT_PASSWORD, and LIBRESPOT_ARGS are set!"
    exit 1
fi

# Run librespot
librespot -u "$LIBRESPOT_USERNAME" -p "$LIBRESPOT_PASSWORD" $LIBRESPOT_ARGS