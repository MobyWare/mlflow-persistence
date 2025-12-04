import sys
import mlflow
from str2bool import str2bool


def main(port:int, skip_exp:bool):
    experiment_id = "0"
    # Point the client to the MLflow server running in Docker
    mlflow.set_tracking_uri(f"http://localhost:{port}")

    # Define the name for our new, specific experiment
    experiment_name = "My_Preconfigured_Experiment"

    if skip_exp:
        print(f"Skipping experiment creation, using default exp_id of {experiment_id}")
    else:
        # Create the experiment.
        # *** NOTE: We are NOT providing the 'artifact_location' argument here. ***
        try:
            experiment_id = mlflow.create_experiment(name=experiment_name)
        except mlflow.exceptions.MlflowException:
            experiment = mlflow.get_experiment_by_name(experiment_name)
            experiment_id = experiment.experiment_id

        print(f"Experiment Name: {experiment_name}")
        print(f"Experiment ID: {experiment_id}")        

    # Start a run within this experiment
    with mlflow.start_run(experiment_id=experiment_id) if len(experiment_id) > 0 else mlflow.start_run():
        mlflow.log_param("configured_by", "docker_image_default")
        # Any artifact logged here will go to the default location
        mlflow.log_artifact("artifacts/test.txt")

    # Let's inspect the experiment to see where its artifacts will be stored
    exp_details = mlflow.get_experiment(experiment_id)
    print(f"Artifact Location for this experiment: {exp_details.artifact_location}")
    
    print(f"\nRun completed. Check the MLflow UI at http://localhost:{port}")

if __name__ == '__main__':
    port = 5000
    skip_exp = False
    if len(sys.argv) > 1:
        port = int(sys.argv[1])
    if len(sys.argv) > 2:
        skip_exp = str2bool(sys.argv[2])
    
    main(port, skip_exp)