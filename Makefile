project_path = arduino-nano-ICSP-shield/arduino-nano-ICSP-shield.kicad_pro
pcb_path = arduino-nano-ICSP-shield/arduino-nano-ICSP-shield.kicad_pcb

kicad_path := $(shell which kicad)
ifeq ($(kicad_path),)
    kicad_path = /Applications/KiCad/KiCad.app/Contents/MacOS/kicad
endif

.PHONY: docs

help:
	@echo "Use the following commands:"
	@echo "  make edit - Open the project in KiCad"
	@echo "  make docs - Generate the interactive html BOM"

edit:
	$(kicad_path) $(project_path) &

build_container:
	docker build -t interactive_bom:latest .

ensure_docs:
	mkdir -p docs

docs: ensure_docs
	docker run -v $(PWD):/mnt -e PCB_PATH=${pcb_path} --rm interactive_bom:latest
