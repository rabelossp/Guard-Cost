import boto3


def lambda_handler(event, context):
ec2 = boto3.client("ec2")


# Lista instâncias em execução
instances = ec2.describe_instances(Filters=[{"Name": "instance-state-name", "Values": ["running"]}])
ids = [i["InstanceId"] for r in instances["Reservations"] for i in r["Instances"]]


if ids:
ec2.stop_instances(InstanceIds=ids)
print(f"Parando instâncias: {ids}")
else:
print("Nenhuma instância em execução")