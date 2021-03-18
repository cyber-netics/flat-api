#!/bin/bash
set -e 

# Replace Environmental Variables 
# ($AWS_DEFAULT_REGION) with acutal env passed as arg

#============= Environmental Variables =============
export AWS_ACCOUNT_ID=$1 # accound id in iam 
export AWS_DEFAULT_REGION=$2
export SERVICE_NAME=$3 #  ECS Service name
export CONTAINER_NAME=$4 # ECS Task Definition name
export CONTAINER_PORT=80 # Main port


#============ Template and Output file =============
all_templates=( 
"appSpec.yml"
"taskdef.json"
)

#============ Create File Replacing ENVs=============
for i in "${all_templates[@]}"
do
  finalFile=$i
  template="./aws.templates/${i}"

  rm -f ${finalFile}
  ( echo "cat <<EOF >${finalFile}";
    cat ${template};
  ) >${finalFile}
  . ${finalFile}
done


