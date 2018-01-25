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
  karyot: "typedefs.yaml#KaryotType"
  euk: "typedefs.yaml#BlastnType"
  prok: "typedefs.yaml#BlastnType"

outputs:
  output:
    type:
      type: array
      items: "typedefs.yaml#BlastnType"


expression: |
   ${
      var newArray = inputs.common;
      if (inputs.karyot == "pro")
        newArray.push(inputs.prok)
      else
        newArray.push(inputs.euk)
      return {'output': newArray}
    }
