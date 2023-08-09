# linux-docker-librespot-app
A lightweight, Dockerized Librespot application for Linux.

This application provides a seamless integration of the Librespot Spotify client for Linux distributions using Docker. Designed for minimalism and efficiency, this app is especially tailored for Alpine Linux on x86 architecture.

## Host Machine Compatibility
The project has been successfully tested on:
- **OS**: Alpine Linux (x86 architecture)

## Prerequisites

Before proceeding, ensure your system meets the following:

1. **Installed Utilities**: Ensure `alsa-utils`, `docker`, and `docker-compose` are installed on your host machine.
   
2. **Audio Configuration**: A proper configuration for your audio devices is essential. This is done via `/etc/asound.conf`. The configuration provided below has been tested and is confirmed to work with HDMI output:

```bash
pcm.!default {
    type plug
    slave.pcm "softvol"
}

pcm.softvol {
    type softvol
    slave {
        pcm "hw:0,3"
    }
    control {
        name "Master"
        card 0
    }
}

ctl.!default {
    type hw
    card 0
}
```
> **Note**: The above configuration is specific to the HDMI port used in testing. It might not work for your setup, so ensure you test thoroughly. With `alsa-utils` installed, you can use `speaker-test` on the host to test the audio. Once the host audio is working correctly, it should also work in the Docker environment.

## Quick Start

1. Clone the repository: git clone https://github.com/Gismogy/linux-docker-librespot.git
2. Navigate to the project directory: cd linux-docker-librespot
3. Start the application using Docker Compose: docker-compose up -d
