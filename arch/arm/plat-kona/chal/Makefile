#*****************************************************************************
# Copyright 2003 - 2008 Broadcom Corporation.  All rights reserved.
#
# Unless you and Broadcom execute a separate written software license
# agreement governing use of this software, this software is licensed to you
# under the terms of the GNU General Public License version 2, available at
# http://www.broadcom.com/licenses/GPLv2.php (the "GPL").
#
# Notwithstanding the above, under no circumstances may you combine this
# software in any way with any other Broadcom software provided under a
# license other than the GPL, without Broadcom's express prior written
# consent.
#*****************************************************************************
ifneq ($(CONFIG_ARCH_CAPRI),y)
obj-y += chal_keypad.o
endif
obj-$(CONFIG_ARCH_RHEA) += chal_aci.o
obj-$(CONFIG_ARCH_CAPRI) += chal_aci.o
obj-$(CONFIG_FB_BRCM_RHEA) += chal_dsi.o chal_smi.o chal_dma_vc4lite.o \
	chal_tectl_vc4lite.o chal_spi_vc4lite.o chal_keypad.o
obj-$(CONFIG_BCM_STM) += chal_trace.o
ifdef CONFIG_MAP_PCM_CHAL
obj-y += chal_sspi.o
else ifdef CONFIG_SPI_SSPI_KONA
obj-y += chal_sspi.o
else ifdef CONFIG_I2C_BRCM_SSPI
obj-y += chal_sspi.o
endif
obj-$(CONFIG_KEYBOARD_BCM)	+= chal_keypad.o
#obj-$(CONFIG_BRCM_SOUND_BIG_ISLAND_ALSA) += chal_sspi.o
# Turn off over zealous gcc warnings
EXTRA_CFLAGS += -D_RHEA_ -Wno-format -Wno-missing-braces
EXTRA_CFLAGS += -DtempINTERFACE_OSDAL_KEYPAD

