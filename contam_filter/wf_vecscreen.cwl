#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  - $import: typedefs.yaml
  - class: StepInputExpressionRequirement
  - class: InlineJavascriptRequirement
    
inputs:
  karyot_type: "typedefs.yaml#KaryotType" 
  query: File
  euk_adapt: "typedefs.yaml#BlastnType"
  prok_adapt: "typedefs.yaml#BlastnType"

outputs:
  output:
    type: File
    outputSource: filter/output

steps:
  choose_adapt:
    in:
      karyot: karyot_type
      euk: euk_adapt
      prok: prok_adapt
    out: [output]
    run:
      class: ExpressionTool
      inputs:
        karyot: "typedefs.yaml#KaryotType"
        euk: "typedefs.yaml#BlastnType"
        prok: "typedefs.yaml#BlastnType"
      outputs:
        output: "typedefs.yaml#BlastnType"
      expression: |
        ${
          if (inputs.karyot == "pro") return {'output': inputs.prok}
          return {'output': inputs.euk}
        }
        
  vecscreen:
    in:
      query: query
      db:
        source: choose_adapt/output
        valueFrom: $(self.db)
      #db:
      #  source: dbfasta
      #  valueFrom: $(self.db)
      #db: decompress/output
      #db_aux: makeblastdb/output
    out: [output]
    run: vecscreen.cwl

  filter:
    in:
      infile: vecscreen/output
    out: [output]
    run:
      class: CommandLineTool
      hints:
        DockerRequirement:
          dockerPull: ncbi/contamfilter
      baseCommand: VSlistTo1HitPerLine.awk
      stdout: vecscreen.output
      inputs:
        infile:
          type: File
          inputBinding:
            position: 1
      outputs:
        output:
          type: stdout
          
          
