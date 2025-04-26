project_path = arduino-nano-ICSP-shield/arduino-nano-ICSP-shield.kicad_pro
pcb_path = arduino-nano-ICSP-shield/arduino-nano-ICSP-shield.kicad_pcb

kicad_path := $(shell which kicad)
ifeq ($(kicad_path),)
    kicad_path = /Applications/KiCad/KiCad.app/Contents/MacOS/kicad
endif

help:
	@echo "Use the following commands:"
	@echo "  make edit - Open the project in KiCad"

edit:
	$(kicad_path) $(project_path) &
