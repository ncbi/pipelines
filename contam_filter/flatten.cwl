#!/usr/bin/env cwl-runner

cwlVersion: v1.0

requirements:
  - $import: typedefs.yaml
  - class: InlineJavascriptRequirement

class: ExpressionTool

inputs:
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
