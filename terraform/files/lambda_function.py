import json
import os
import random
from datetime import datetime

def lambda_handler(event, context):
    """
    A simple demo Lambda function for LocalStack learning.
    This function demonstrates:
    - Environment variables access
    - JSON response handling
    - Event processing
    - Basic Python operations
    """
    
    # Get environment variables
    demo_bucket = os.environ.get('DEMO_BUCKET', 'localstack-demo-bucket')
    environment = os.environ.get('ENVIRONMENT', 'localstack')
    
    # Process the incoming event
    event_data = event if event else {}
    
    # Generate some sample data
    sample_data = {
        "random_number": random.randint(1, 100),
        "timestamp": datetime.now().isoformat(),
        "processed_items": random.randint(10, 50),
        "status": "success"
    }
    
    # Simulate some processing
    processing_time = random.uniform(0.1, 0.5)
    
    try:
        print(f"Lambda function executed successfully in {environment}")
        print(f"Processing time: {processing_time:.2f} seconds")
        print(f"Event received: {json.dumps(event_data)}")
        
        response_body = {
            "message": "Hello from LocalStack Lambda!",
            "environment": environment,
            "bucket_name": demo_bucket,
            "function_info": {
                "name": context.function_name if context else "localstack-demo-lambda",
                "version": context.function_version if context else "1.0",
                "remaining_time": context.get_remaining_time_in_millis() if context else 30000
            },
            "event_data": event_data,
            "sample_data": sample_data,
            "timestamp": datetime.now().isoformat(),
            "tips": [
                "This Lambda runs in LocalStack",
                "No AWS charges apply",
                "Perfect for learning and testing",
                "Check CloudWatch logs for more details"
            ]
        }
        
        return {
            "statusCode": 200,
            "headers": {
                "Content-Type": "application/json",
                "X-Custom-Header": "LocalStack-Demo",
                "X-Timestamp": datetime.now().isoformat()
            },
            "body": json.dumps(response_body, indent=2)
        }
        
    except Exception as e:
        print(f"Error in Lambda function: {str(e)}")
        error_response = {
            "error": str(e),
            "message": "An error occurred in the Lambda function",
            "timestamp": datetime.now().isoformat(),
            "help": "Check the CloudWatch logs for more details"
        }
        
        return {
            "statusCode": 500,
            "headers": {
                "Content-Type": "application/json"
            },
            "body": json.dumps(error_response, indent=2)
        }
