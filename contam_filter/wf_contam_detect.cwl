#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  - $import: typedefs.yaml
  - class: SubworkflowFeatureRequirement
  - class: ScatterFeatureRequirement
  - class: MultipleInputFeatureRequirement
  - class: StepInputExpressionRequirement
    
inputs:
  query: File
  karyot_type: "typedefs.yaml#KaryotType"
  default_fastas: "typedefs.yaml#SettingsType"
  
  
outputs:
  result:
    type: File
    outputSource: tar_output/output

steps:
  make_list:
    run: create_blast_list.cwl
    in:
      common:
        source: default_fastas
        valueFrom: $(self.common)
      karyot: karyot_type
      euk:
        source: default_fastas
        valueFrom: $(self.euk)
      prok:
        source: default_fastas
        valueFrom: $(self.prok)
    out:
      [output]
    
  blastit:
    run: wf_blastit.cwl
    scatter: dbfasta
    in:
      dbfasta: make_list/output
      query: query
    out: [output]

  vecscreen:
    run: wf_vecscreen.cwl
    in:
      karyot_type: karyot_type
      euk_adapt:
        source: default_fastas
        valueFrom: $(self.euk_adapt)
      prok_adapt:
        source: default_fastas
        valueFrom: $(self.prok_adapt)
      query: query
    out: [output]

  tar_output:
    in:
      blastin: blastit/output
      vecin: vecscreen/output
    out: [output]
    run:
      class: CommandLineTool
      baseCommand: [tar, chf, outputs.tar, '--transform=s/.*\///g']
      inputs:
        blastin:
          type:
            type: array
            items: File
          inputBinding:
            position: 1
        vecin:
          type: File
          inputBinding:
            position: 2
      outputs:
        output:
          type: File
          outputBinding:
            glob: outputs.tar
            
