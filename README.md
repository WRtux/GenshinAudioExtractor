# Genshin Impact Audio Extractor

A tool to automate the extraction and the conversion of audio resources in Genshin Impact.

## Introduction

This tool is designed to automatically extract the audio resources from `.pck` files in Genshin Impact (PC), convert the Vorbis-encoded ones to `.ogg` files losslessly (no re-encoding) and ADPCM-encoded ones to `.wav` or `.flac` files.

## Getting Started

Binary files are not included in the repository. It's recommended to begin with the latest release.  
Java environment is required to run this tool.

**Graphical interface (in Windows Explorer):** Drop one `.pck` file or directory containing `.pck` files to `extract.cmd`, wait for the process to finish. Extracted files will be in `output/`, located in the same directory with `extract.cmd`.

**Command line usage:** `extract.cmd [input [output]]`, where `input` can be a `.pck` file or a directory containing `.pck` files (default: current directory), and `output` should be a writable directory (default: `output/`).

## License

The extracting script `extract.cmd` and PtADPCMInflate are provided under the MIT License. Please refer to [`/copy/`](/copy/) for the documents of other applications used in this project.
