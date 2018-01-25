#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: gzip

requirements:
  - class: InlineJavascriptRequirement
    
inputs:
  input_file:
    type: File
    inputBinding:
      position: 1
      prefix: -dcf

outputs:
  output:
    type: stdout

stdout: $((inputs.input_file.basename).replace('.gz',''))
