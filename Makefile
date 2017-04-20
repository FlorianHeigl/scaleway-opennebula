NAME                = opennebula
VERSION             = latest
VERSION_ALIASES     = 5.2.2 5.2 5
TITLE               = OpenNebula 5.2.1
DESCRIPTION         = OpenNebula 5.2.1
SOURCE_URL          = https://github.com/FlorianHeigl/scaleway-opennebula
VENDOR_URL          = https://www.opennebula.org/
DEFAULT_IMAGE_ARCH  = x86_64

# make sure that your attached volume will be 50G (some instances will have 150)
IMAGE_VOLUME_SIZE = 50G
IMAGE_BOOTSCRIPT = latest
IMAGE_NAME = OpenNebula 5.2


# This is specific to distribution images
# -- to fetch latest code, run 'make sync-image-tools'
IMAGE_TOOLS_FLAVORS =   systemd,common,docker-based
IMAGE_TOOLS_CHECKOUT =  276916c5288895ab02e753e138f3701c94141f64


## Image tools  (https://github.com/scaleway/image-tools)
all:    docker-rules.mk
docker-rules.mk:
	wget -qO - http://j.mp/scw-builder | bash
-include docker-rules.mk
