const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://scdawte3fzdmtidapebjrhzcvi.appsync-api.us-east-1.amazonaws.com/graphql",
                        "Region": "us-east-1",
                        "AuthMode": "API_KEY",
                        "ApiKey": "da2-eciwubkkqzeajgywysldvkljuq",
                        "ClientDatabasePrefix": "myappTestDS_API_KEY"
                    },
                    "myappTestDS_AWS_IAM": {
                        "ApiUrl": "https://scdawte3fzdmtidapebjrhzcvi.appsync-api.us-east-1.amazonaws.com/graphql",
                        "Region": "us-east-1",
                        "AuthMode": "AWS_IAM",
                        "ClientDatabasePrefix": "myappTestDS_AWS_IAM"
                    }
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "us-east-1:5d30ccef-c359-4a16-9e30-32b3d2fe9b29",
                            "Region": "us-east-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "us-east-1_yYVg7Nkmb",
                        "AppClientId": "1v0iqceicbp5q7sh9gu3stnecg",
                        "Region": "us-east-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "OAuth": {
                            "WebDomain": "fasoft-dev.auth.us-east-1.amazoncognito.com",
                            "AppClientId": "1v0iqceicbp5q7sh9gu3stnecg",
                            "SignInRedirectURI": "myapp://callback/",
                            "SignOutRedirectURI": "myapp://signout/",
                            "Scopes": [
                                "phone",
                                "email",
                                "openid",
                                "profile",
                                "aws.cognito.signin.user.admin"
                            ]
                        },
                        "authenticationFlowType": "USER_SRP_AUTH",
                        "mfaConfiguration": "OFF",
                        "mfaTypes": [
                            "SMS"
                        ],
                        "passwordProtectionSettings": {
                            "passwordPolicyMinLength": 8,
                            "passwordPolicyCharacters": []
                        },
                        "signupAttributes": [
                            "EMAIL"
                        ],
                        "socialProviders": [],
                        "usernameAttributes": [],
                        "verificationMechanisms": [
                            "EMAIL"
                        ]
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "myapp-storage-3c3e0bd371442-dev",
                        "Region": "us-east-1"
                    }
                }
            }
        }
    },
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "myappTestDS": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://scdawte3fzdmtidapebjrhzcvi.appsync-api.us-east-1.amazonaws.com/graphql",
                    "region": "us-east-1",
                    "authorizationType": "API_KEY",
                    "apiKey": "da2-eciwubkkqzeajgywysldvkljuq"
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "myapp-storage-3c3e0bd371442-dev",
                "region": "us-east-1",
                "defaultAccessLevel": "guest"
            }
        }
    }
}''';