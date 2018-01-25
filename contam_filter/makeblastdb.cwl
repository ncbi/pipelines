#!/usr/bin/env cwl-runner

cwlVersion: v1.0
class: CommandLineTool
baseCommand: makeblastdb
#  makeblastdb [-h] [-help] [-in input_file] [-input_type type]
#    -dbtype molecule_type [-title database_title] [-parse_seqids]    
#    [-hash_index] [-mask_data mask_data_files] [-mask_id mask_algo_ids]
#    [-mask_desc mask_algo_descriptions] [-gi_mask]
#    [-gi_mask_name gi_based_mask_names] [-out database_name]
#    [-max_file_sz number_of_bytes] [-logfile File_Name] [-taxid TaxID]
#    [-taxid_map TaxIDMapFile] [-version]

requirements:
  - class: InitialWorkDirRequirement
    listing:
      - $(inputs.input_file)

hints:
  DockerRequirement:
    dockerPull: ncbi/blast
      
inputs:
  input_file:
    type: File
    inputBinding:
      position: 1
      prefix: -in
  input_type:
    type: string?
    inputBinding:
      position: 2
      prefix: -input_type
  dbtype:
    type: string
    inputBinding:
      position: 3
      prefix: -dbtype
  title:
    type: string?
    inputBinding:
      position: 4
      prefix: -title
  outdb:
    type: string?
    #default: "blastdb"
    inputBinding:
      position: 5
      prefix: -out
      
outputs:
  output:
    type:
      type: array
      items: File
    outputBinding:
      glob: "$(inputs.input_file.basename).*"



