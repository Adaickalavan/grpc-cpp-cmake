FROM tensorflow/serving

# Author label
LABEL Author Adaickalavan Meiyappan

# Copy model data to the container's model folder
COPY ./resnet /models/tfModel

# Add environment variable
ENV MODEL_NAME tfModel
