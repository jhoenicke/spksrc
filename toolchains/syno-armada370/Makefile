TC_NAME = syno-armada370

TC_DIST_NAME = gcc464_glibc215_hard_armada-GPL.tgz

TC_EXT = tgz
TC_DIST_SITE = http://sourceforge.net/projects/dsgpl/files/DSM%205.0%20Tool%20Chains/Marvell%20armada%20370%20Linux%203.2.40

TC_BASE_DIR = arm-marvell-linux-gnueabi
TC_PREFIX = arm-marvell-linux-gnueabi
TC_TARGET = arm-marvell-linux-gnueabi
TC_ENV_DIRS = $(WORK_DIR)/usr/syno $(WORK_DIR)/usr/syno/sqlite3
TC_INCLUDE_DIRS = $(addsuffix /include,$(TC_ENV_DIRS))
TC_LIB_DIRS = $(addsuffix /lib,$(TC_ENV_DIRS))
TC_INCLUDES = $(addprefix -I,$(TC_INCLUDE_DIRS)) -I$(WORK_DIR)/$(TC_BASE_DIR)/$(TC_BASE_DIR)/libc/include
comma:=,

TC_CFLAGS = $(TC_INCLUDES) -mcpu=marvell-pj4 -march=armv7-a -mfpu=vfpv3-d16 -mfloat-abi=hard -DSYNO_MARVELL_ARMADA370 -DSYNO_PLATFORM=MARVELL_ARMADA370
TC_CPPFLAGS = $(TC_INCLUDES) -mcpu=marvell-pj4 -march=armv7-a -mfpu=vfpv3-d16 -mfloat-abi=hard -DSYNO_MARVELL_ARMADA370 -DSYNO_PLATFORM=MARVELL_ARMADA370
TC_CXXFLAGS = $(TC_INCLUDES) -mcpu=marvell-pj4 -march=armv7-a -mfpu=vfpv3-d16 -mfloat-abi=hard -DSYNO_MARVELL_ARMADA370 -DSYNO_PLATFORM=MARVELL_ARMADA370
TC_LDFLAGS = $(addprefix -L,$(TC_LIB_DIRS)) -L$(WORK_DIR)/$(TC_BASE_DIR)/$(TC_BASE_DIR)/libc/lib -mcpu=marvell-pj4 -march=armv7-a -mfpu=vfpv3-d16 -mfloat-abi=hard $(addprefix -Wl$(comma)--rpath-link$(comma),$(TC_LIB_DIRS))

include ../../mk/spksrc.tc.mk
