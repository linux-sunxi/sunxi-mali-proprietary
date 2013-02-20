#
# This Makefile tries to autodetect some things, but since i am not that
# knowledgable about make, it probably does rather unconventional things.
#
# It tries to detect the mali driver version from the kernel, but this can
# be overridden at the commandline with VERSION=
#
# Through gcc -dumpmachine, this Makefile tries to detect whether it needs
# the 'armel' or 'armhf' ABI. Override with ABI=
#

# Try to detect whether to install armel or armhf libs.
ifeq ($(ABI),)
	dumpmachine := $(shell gcc -dumpmachine)
	ifeq ($(dumpmachine),arm-linux-gnueabi)
		ABI = armel
	else ifeq ($(dumpmachine),arm-linux-gnueabihf)
		ABI = armhf
	endif
endif

# Sanitize ABI, even when passed from the commandline.
ifeq ($(ABI),armel)
else ifeq ($(ABI),armhf)
else
	override ABI = UNKNOWN_ABI
	ifeq ($(VERSION),)
		VERSION = UNKNOWN_VERSION
	endif
endif

# Detect mali driver version by talking to the mali kernel driver.
ifeq ($(VERSION),)
	bleh := $(shell make -C ../version)
	VERSION = $(shell ../version/version)
endif

# Sanitize mali driver version, even when passed from the commandline.
ifeq ($(VERSION),r2p4)
else ifeq ($(VERSION),r3p0)
else ifeq ($(VERSION),r3p1)
else
	override VERSION = UNKNOWN_VERSION
endif

# Warn
$(VERSION)/$(ABI)/framebuffer/Makefile:
	@echo ""
	@echo "No framebuffer libraries exist for $(VERSION), $(ABI)."
	@echo ""

framebuffer: $(VERSION)/$(ABI)/framebuffer/Makefile
	$(MAKE) -C $(VERSION)/$(ABI)/framebuffer/

# Warn
$(VERSION)/$(ABI)/x11/Makefile:
	@echo ""
	@echo "No x11 libraries exist for $(VERSION), $(ABI)."
	@echo ""

x11: $(VERSION)/$(ABI)/x11/Makefile
	$(MAKE) -C $(VERSION)/$(ABI)/x11/
