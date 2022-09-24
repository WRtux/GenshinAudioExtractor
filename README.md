# Genshin Impact Audio Extractor

A tool to automate the extraction and the conversion of audio resources in Genshin Impact.

## Introduction

This tool is designed to automatically extract the audio resources from `.pck` files in Genshin Impact (PC), convert the Vorbis-encoded ones to `.ogg` files losslessly (no re-encoding) and ADPCM-encoded ones to `.wav` or `.flac` files.

## Getting Started

Binary files are not included in the repository. It's recommended to begin with the latest [release](//github.com/WRtux/GenshinAudioExtractor/releases), which brings out-of-the-box experience with everything needed packed. You can also download and run [`download.cmd`](/download.cmd) to set up the tool from scratch.  
Java environment is required to run this tool.

**Graphical interface (in Windows Explorer):** Drop one `.pck` file or directory containing `.pck` files to `extract.cmd`, wait for the process to finish. Extracted files will be in `output/`, located in the same directory with `extract.cmd`.

**Command line usage:** `extract.cmd [input [output]]`, where `input` can be a `.pck` file or a directory containing `.pck` files (default: current directory), and `output` should be a writable directory (default: `output/`).

## License

The main part of this tool is provided under the [MIT License](/LICENSE.txt). Please refer to `copy/` directory after setting up the tool for the licenses of other projects used in this project.
