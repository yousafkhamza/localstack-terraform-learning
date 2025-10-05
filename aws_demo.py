#!/usr/bin/env python3
"""
LocalStack AWS Learning Script
This script demonstrates various AWS operations using boto3 with LocalStack
"""

import boto3
import json
import time
from datetime import datetime

# LocalStack configuration
LOCALSTACK_ENDPOINT = "http://localhost:4566"
AWS_REGION = "us-east-1"
AWS_ACCESS_KEY = "test"
AWS_SECRET_KEY = "test"

def create_aws_client(service_name):
    """Create an AWS client configured for LocalStack"""
    return boto3.client(
        service_name,
        endpoint_url=LOCALSTACK_ENDPOINT,
        aws_access_key_id=AWS_ACCESS_KEY,
        aws_secret_access_key=AWS_SECRET_KEY,
        region_name=AWS_REGION
    )

def demonstrate_s3_operations():
    """Demonstrate S3 operations"""
    print("\n📦 S3 Operations Demo")
    print("-" * 30)
    
    s3 = create_aws_client('s3')
    bucket_name = 'localstack-demo-bucket'
    
    try:
        # List buckets
        buckets = s3.list_buckets()
        print(f"📋 Available buckets: {[b['Name'] for b in buckets['Buckets']]}")
        
        # Upload a test file
        test_content = f"Hello from Python script! Generated at {datetime.now()}"
        test_key = f"python-test-{int(time.time())}.txt"
        
        s3.put_object(
            Bucket=bucket_name,
            Key=test_key,
            Body=test_content,
            ContentType='text/plain'
        )
        print(f"📤 Uploaded: {test_key}")
        
        # List objects
        objects = s3.list_objects_v2(Bucket=bucket_name)
        if 'Contents' in objects:
            print(f"📁 Objects in bucket: {len(objects['Contents'])}")
            for obj in objects['Contents'][:5]:  # Show first 5
                print(f"   - {obj['Key']} ({obj['Size']} bytes)")
        
        # Download and read the file we just uploaded
        response = s3.get_object(Bucket=bucket_name, Key=test_key)
        content = response['Body'].read().decode('utf-8')
        print(f"📥 Downloaded content: {content}")
        
    except Exception as e:
        print(f"❌ S3 Error: {e}")

def demonstrate_lambda_operations():
    """Demonstrate Lambda operations"""
    print("\n⚡ Lambda Operations Demo")
    print("-" * 30)
    
    lambda_client = create_aws_client('lambda')
    
    try:
        # List functions
        functions = lambda_client.list_functions()
        print(f"📋 Available functions: {len(functions['Functions'])}")
        
        for func in functions['Functions']:
            print(f"   - {func['FunctionName']} (Runtime: {func['Runtime']})")
        
        # Invoke the demo function
        if functions['Functions']:
            function_name = functions['Functions'][0]['FunctionName']
            print(f"🚀 Invoking function: {function_name}")
            
            response = lambda_client.invoke(
                FunctionName=function_name,
                InvocationType='RequestResponse',
                Payload=json.dumps({"test": "data from Python script"})
            )
            
            payload = json.loads(response['Payload'].read())
            print(f"📨 Response: {json.dumps(payload, indent=2)}")
        
    except Exception as e:
        print(f"❌ Lambda Error: {e}")

def demonstrate_iam_operations():
    """Demonstrate IAM operations"""
    print("\n🔐 IAM Operations Demo")
    print("-" * 30)
    
    iam = create_aws_client('iam')
    
    try:
        # List roles
        roles = iam.list_roles()
        print(f"👥 Available roles: {len(roles['Roles'])}")
        
        for role in roles['Roles']:
            print(f"   - {role['RoleName']} (Created: {role['CreateDate']})")
        
        # List policies (if any)
        policies = iam.list_policies(Scope='Local')
        print(f"📋 Local policies: {len(policies['Policies'])}")
        
    except Exception as e:
        print(f"❌ IAM Error: {e}")

def demonstrate_cloudwatch_operations():
    """Demonstrate CloudWatch operations"""
    print("\n📊 CloudWatch Operations Demo")
    print("-" * 30)
    
    logs = create_aws_client('logs')
    
    try:
        # List log groups
        log_groups = logs.describe_log_groups()
        print(f"📝 Log groups: {len(log_groups['logGroups'])}")
        
        for group in log_groups['logGroups']:
            print(f"   - {group['logGroupName']}")
            
            # Get recent log streams
            streams = logs.describe_log_streams(
                logGroupName=group['logGroupName'],
                orderBy='LastEventTime',
                descending=True,
                limit=3
            )
            
            for stream in streams['logStreams']:
                print(f"     Stream: {stream['logStreamName']}")
        
    except Exception as e:
        print(f"❌ CloudWatch Error: {e}")

def main():
    """Main demonstration function"""
    print("🎓 LocalStack AWS Learning Script")
    print("=" * 40)
    print(f"🔗 Endpoint: {LOCALSTACK_ENDPOINT}")
    print(f"🌍 Region: {AWS_REGION}")
    
    # Check LocalStack connectivity
    try:
        import requests
        response = requests.get(f"{LOCALSTACK_ENDPOINT}/_localstack/health")
        if response.status_code == 200:
            print("✅ LocalStack is running and accessible")
        else:
            print("❌ LocalStack health check failed")
            return
    except Exception as e:
        print(f"❌ Cannot connect to LocalStack: {e}")
        return
    
    # Run demonstrations
    demonstrate_s3_operations()
    demonstrate_lambda_operations()
    demonstrate_iam_operations()
    demonstrate_cloudwatch_operations()
    
    print("\n🎉 Demo completed!")
    print("💡 Try modifying this script to explore more AWS services!")

if __name__ == "__main__":
    main()