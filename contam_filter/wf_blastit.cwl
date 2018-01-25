#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: Workflow

requirements:
  - $import: typedefs.yaml
  - class: StepInputExpressionRequirement

inputs:
  dbfasta: "typedefs.yaml#BlastnType"
  query: File
    
outputs:
  output:
    type: File
    outputSource: blastn/output

steps:
  # decompress:
  #   run: decompress.cwl
  #   in:
  #     input_file:
  #       source: dbfasta
  #       valueFrom: $(self.db)
  #   out: [output]
  
  # makeblastdb:
  #   run: makeblastdb.cwl
  #   in:
  #     input_file: decompress/output
  #     dbtype:
  #       source: dbfasta
  #       valueFrom: $(self.dbtype)
  #   out: [output]
    
  blastn:
    run: blastn.cwl
    in:
      query: query
      db:
        source: dbfasta
        valueFrom: $(self.db)
      # db: decompress/output
      # db_aux: makeblastdb/output
      outfmt:
        source: dbfasta
        valueFrom: $(self.outfmt)
      best_hit_overhang:
        source: dbfasta
        valueFrom: $(self.best_hit_overhang)
      best_hit_score_edge:
        source: dbfasta
        valueFrom: $(self.best_hit_score_edge)
      dust:
        source: dbfasta
        valueFrom: $(self.dust)
      evalue:
        source: dbfasta
        valueFrom: $(self.evalue)
      gapextend:
        source: dbfasta
        valueFrom: $(self.gapextend)
      gapopen:
        source: dbfasta
        valueFrom: $(self.gapopen)
      penalty:
        source: dbfasta
        valueFrom: $(self.penalty)
      perc_identity:
        source: dbfasta
        valueFrom: $(self.perc_identity)
      reward:
        source: dbfasta
        valueFrom: $(self.reward)
      soft_masking:
        source: dbfasta
        valueFrom: $(self.soft_masking)
      task:
        source: dbfasta
        valueFrom: $(self.task)
      template_length:
        source: dbfasta
        valueFrom: $(self.template_length)
      template_type:
        source: dbfasta
        valueFrom: $(self.template_type)
      window_size:
        source: dbfasta
        valueFrom: $(self.window_size)
      word_size:
        source: dbfasta
        valueFrom: $(self.word_size)
      xdrop_gap:
        source: dbfasta
        valueFrom: $(self.xdrop_gap)
      no_greedy:
        source: dbfasta
        valueFrom: $(self.no_greedy)
    out: [output]

    
