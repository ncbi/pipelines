cwlVersion: v1.0
class: CommandLineTool
hints:
  DockerRequirement:
    dockerPull: ncbi/blast_contamfilter

baseCommand: blastn
#stdout: $(inputs.db.basename).output
stdout: $(inputs.db).output
inputs:
  query:
    type: File
    inputBinding:
      prefix: -query
  db:
    type: string
    inputBinding:
      prefix: -db
  outfmt:
    type: string?
    default: 6
    inputBinding:
      prefix: -outfmt
  best_hit_overhang:
    type: double?
    inputBinding:
      prefix: -best_hit_overhang
  best_hit_score_edge:
    type: double?
    inputBinding:
      prefix: -best_hit_score_edge
  dust:
    type: string?
    inputBinding:
      prefix: -dust
  evalue:
    type: double?
    inputBinding:
      prefix: -evalue
  gapextend:
    type: int?
    inputBinding:
      prefix: -gapextend 
  gapopen:
    type: int?
    inputBinding:
      prefix: -gapopen
  penalty:
    type: int?
    inputBinding:
      prefix: -penalty 
  perc_identity:
    type: double?
    inputBinding:
      prefix: -perc_identity
  reward:
    type: int?
    inputBinding:
      prefix: -reward 
  soft_masking:
    type: string?
    inputBinding:
      prefix: -soft_masking
  task:
    type: string?
    inputBinding:
      prefix: -task
  template_length:
    type: int?
    inputBinding:
      prefix: -template_length
  template_type:
    type: string?
    inputBinding:
      prefix: -template_type
  window_size:
    type: int?
    inputBinding:
      prefix: -window_size
  word_size:
    type: int?
    inputBinding:
      prefix: -word_size
  xdrop_gap:
    type: int?
    inputBinding:
      prefix: -xdrop_gap 
  no_greedy:
    type: boolean?
    inputBinding:
      prefix: -no_greedy

outputs:
  - id: output
    type: File
    outputBinding:
      glob: "*.output"
