if [ "$AWS_PROFILE" == "prod" ]
then
    SAM_S3_BUCKET="appdevstore"
    AWS_REGION="us-east-1"
else
    SAM_S3_BUCKET="appdevstore20211221-prod"
    AWS_REGION="us-east-1"
fi

version="1.0.3"

echo "Creating package.yaml"
sam package --template-file template.yaml --s3-bucket $SAM_S3_BUCKET  --output-template-file packaged.yaml --s3-prefix "SecurityHubCollectorAWSOrg/v"$version --region $AWS_REGION --profile $AWS_PROFILE

echo "Publishing sumologic-securityhub-forwarder "$version
sam publish --template packaged.yaml --region $AWS_REGION --semantic-version $version

echo "Published sumologic-securityhub-forwarder "$version

# sam deploy --template-file packaged.yaml --stack-name testingsechubawsorg --capabilities CAPABILITY_IAM --region $AWS_REGION --parameter-overrides ParameterKey=SumoEndpoint,ParameterValue=https://collectors.sumologic.com/receiver/v1/http/ZaVnC4dhaV29FhnR-VQyA9mpray7QOE0aRQrtZnuNmMQ0DKr9ZVMGY5WIa0IWSjt_LkiUSjI71WGiDHRHStqwCApBp_49e_W-b6gM0_KnZlxBUBe-1yTFw==

#aws --profile awsorg cloudformation describe-stack-events --stack-name testingsecurityhubcollectorawsorg --region $AWS_REGION
#aws --profile awsorg cloudformation get-template --stack-name testingsecurityhubcollectorawsorg  --region $AWS_REGION
