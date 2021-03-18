#!/bin/bash
set -e 

# Replace Environmental Variables 
# ($AWS_DEFAULT_REGION) with acutal env passed as arg

#============= Environmental Variables =============
export AWS_ACCOUNT_ID=$1
export AWS_DEFAULT_REGION=$2
export SERVICE_NAME=$3
export CONTAINER_NAME=$4
export CONTAINER_PORT=$5


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


