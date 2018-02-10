cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: ncbi/blast_contamfilter
    
baseCommand: vecscreen

inputs:
  query:
    type: File
    inputBinding:
      prefix: -i
  db:
    type: string
    inputBinding:
      prefix: -d
  outfmt:
    type: string?
    default: "3"
    inputBinding:
      prefix: -f
  outfile:
    type: string?
    default: "vecscreen.out"
    inputBinding:
      prefix: -o
      
outputs:
  - id: output
    type: File
    outputBinding:
      glob: $(inputs.outfile)
