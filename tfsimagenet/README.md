
## Saved model signature
1.  Run the following command
    ```bash
    $ saved_model_cli show --dir {path to saved_model.pb} --all
    ```
    Output
    ```bash
    MetaGraphDef with tag-set: 'serve' contains the following SignatureDefs:

    signature_def['predict']:
    The given SavedModel SignatureDef contains the following input(s):
        inputs['image_bytes'] tensor_info:
            dtype: DT_STRING
            shape: (-1)
            name: input_tensor:0
    The given SavedModel SignatureDef contains the following output(s):
        outputs['classes'] tensor_info:
            dtype: DT_INT64
            shape: (-1)
            name: ArgMax:0
        outputs['probabilities'] tensor_info:
            dtype: DT_FLOAT
            shape: (-1, 1001)
            name: softmax_tensor:0
    Method name is: tensorflow/serving/predict

    signature_def['serving_default']:
    The given SavedModel SignatureDef contains the following input(s):
        inputs['image_bytes'] tensor_info:
            dtype: DT_STRING
            shape: (-1)
            name: input_tensor:0
    The given SavedModel SignatureDef contains the following output(s):
        outputs['classes'] tensor_info:
            dtype: DT_INT64
            shape: (-1)
            name: ArgMax:0
        outputs['probabilities'] tensor_info:
            dtype: DT_FLOAT
            shape: (-1, 1001)
            name: softmax_tensor:0
    Method name is: tensorflow/serving/predict
    ```  