# Goal
My primary goal is to configure MLFlow to persist data in a PVC in k8s. Secondarily, I want to get more familiar with the settings in MLFlow that control how and where tracking data and artifacts are stored.

## Technical Notes
You can setup default locations in MLFlow. For artifacts, the client can determine where the artifact is stored by specifying a location in the `log_artifact` call. 

|Flag |Env Var|Description|
|-----|-----|-----|
|artifacts-destination |- |Default root location for artifact if one is not provided when logged|
|default-artifact-root |- |URI, e.g. 'mlflow://' related to the server acting as a proxy for artifacts |
|backend-store-uri |MLFLOW_TRACKING_URI |Reference, usual DB URI, for tracking details|
|serve-artifacts |- |Configures MLFLow to proxy the transmission of artifacts|

You need to specify the default of `mlflow-artifacts:/` for the `default-artifact-root` flag if you want to use MLFLow as a proxy for artifacts.

You also need to add dependent libraries to your docker image to access remote stores. For example I added boto3 so I could connect to S3 (i.e. minio proxy).

# References
 - [ ] [Artifact Stores (MLFlow)](https://mlflow.org/docs/latest/tracking/artifacts-stores.html)
 - [ ] [MLFlow Experiment, Run, Tracking lifecycle (AI Exp)](https://g.co/gemini/share/57ce92f08423)
 - [ ] [Generating a consistent artifact store (AI Exp)](https://g.co/gemini/share/fa93fb510c7e)

