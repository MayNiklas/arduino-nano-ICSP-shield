FROM python:3.11

ENV DEBIAN_FRONTEND=noninteractive

RUN echo "deb http://deb.debian.org/debian bookworm-backports main" >> /etc/apt/sources.list && \
    echo "Package: kicad\nPin: version 9.*\nPin-Priority: 600" > /etc/apt/preferences.d/kicad && \
    apt-get update && \
    apt-get install -y libgtk-3-dev git kicad xvfb

RUN pip install \
    attrdict3 \
    wxPython

RUN git clone https://github.com/openscopeproject/InteractiveHtmlBom.git

ENV PCB_PATH=arduino-nano-ICSP-shield/arduino-nano-ICSP-shield.kicad_pcb

CMD PYTHONPATH=/usr/lib/python3/dist-packages/ xvfb-run python3 /InteractiveHtmlBom/InteractiveHtmlBom/generate_interactive_bom.py /mnt/${PCB_PATH} --extra-data-file /mnt/${PCB_PATH} --dark-mode --dest-dir ../docs/ --name-format index --highlight-pin1 selected --no-compression --no-browser --include-tracks --include-nets --extra-fields Description,LCSC
