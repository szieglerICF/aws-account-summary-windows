echo off
Title AWS
color 2f

echo %date% %time%
echo ***
echo *** API Gateway
call aws apigateway get-rest-apis --output json | findstr "name"

echo ***
echo *** Cloudfront
call aws cloudfront list-distributions --output json| findstr "DomainName"

echo ***
echo *** Cloudwatch
call aws logs describe-log-groups | findstr "logGroupName"

echo ***
echo *** Running EC2 instance
call aws ec2 describe-instances --filters "Name=instance-state-name,Values=running" --query "Reservations[*].Instances[*].[ImageId,Tags[*],State[*]]"  --output json | jq ".[][][1][1] | select(.Key | . and contains(\"Name\")).Value"

echo ***
echo *** Elasticsearch Domains
call aws es list-domain-names --output text

echo ***
echo *** Firehose
call aws firehose list-delivery-streams --output json

echo ***
echo *** Lambdas
call aws lambda list-functions --output json | findstr "FunctionName"

echo ***
echo *** RDS
call aws rds describe-db-instances --output json | findstr "DBName"

echo ***
echo *** S3 Buckets
call  aws s3api list-buckets | find "Name"

echo ***
echo *** Sagemaker
call aws sagemaker list-notebook-instances  --output json | findstr "NotebookInstanceName"

echo ***
echo *** Secretsmanager
call aws secretsmanager list-secrets  --output json | findstr  "Name"

echo ***
echo *** SQS
call aws sqs list-queues --output json

echo ***
echo *** Users
call aws iam list-users --output json | findstr "UserName"


echo on
