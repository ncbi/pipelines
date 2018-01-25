#!/usr/bin/env cwl-runner

cwlVersion: v1.0

requirements:
  - $import: typedefs.yaml
  - class: InlineJavascriptRequirement

class: ExpressionTool

inputs:
  common:
    type:
      type: array
      items: "typedefs.yaml#BlastnType"
  euks:
    type:
      type: array
      items: "typedefs.yaml#BlastnType"
  proks:
    type:
      type: array
      items: "typedefs.yaml#BlastnType"

  input:
    type:
      type: array
      items:
        type: array
        items: "typedefs.yaml#BlastnType"

outputs:
  output:
    type:
      type: array
      items: "typedefs.yaml#BlastnType"


expression: |
   ${
       var myFlatArray = [].concat.apply([], inputs.input);
       return {'output': myFlatArray}
    }
