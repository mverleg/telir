
# Tel IR (schema)

This provides the json schema that describes the intermediate representation (IR) for [Tel](https://github.com/mverleg/tel).

By having a json schema for the IR, the backend codegen does not need to be in the same langauge as the frontend. Most popular languages can take in the IR as json, and do the code generation.

This can perhaps be made easier by generating a parser and dataclasses from the schema, as described at https://jsontypedef.com/docs/jtd-codegen/

