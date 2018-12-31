abi_x86:
  makeconf.present:
    - value: 64 32

cpu_flags_x86:
  makeconf.present:
    - value: aes avx avx2 fma3 mmx mmxext popcnt sse sse2 sse3 sse4_1 sse4_2 ssse3

distdir:
  makeconf.present:
    - value: /usr/portage/distfiles

grub_platforms:
  makeconf.present:
    - value: efi-64

# Is this deprecated?
linguas:
  makeconf.present:
    - value: ${LINGUAS} en en_US

l10n:
  makeconf.present:
    - value: ${L10N} en en-US

pkgdir:
  makeconf.present:
    - value: ${PORTDIR}/packages

portdir:
  makeconf.present:
    - value: /usr/portage

python_single_target:
  makeconf.present:
    - value: python3_6

python_targets:
  makeconf.present:
    - value: python2_7 python3_6

ruby_targets:
  makeconf.present:
    - value: ruby23

use_flags:
  makeconf.present:
    - name: use
    - value: -bindist -bluetooth -ldap -qt4 pulseaudio

video_cards:
  makeconf.present:
    - value: vmware
