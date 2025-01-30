####
import os
import random
import string
import sys
from datetime import datetime, timedelta
##Two types of Random: 
## If we use VM, we can use os.urandom() to generate random numbers.

## Task 1: (Secret Owner)
# - It Should be able to Generate a Secret. 
# - It Should Return a Unique path and a PIN. 
# - It should allow generation of multiple distinct urls and corresponding pins.

## Task 2: (Secret Reader)
# - It Should receive Unique path and PIN. 
# - Validate the PIN. 
# - It Should Return the Secret. 


## Conditions: 
# - 1.1 The URLs should not be easy to guess.
# - 1.2 Secrets should only be one-time accessible and expire.
# - 1.3 Allow 3 attempts for a PIN.  
# - 1.4 Secrets should expire after 24 hours.
# - 1.5 The secret can only be text. 
# - 1.6 Text length should be of less than 1KB and a maximum length of 100KB. 
# - 1.7 Users can be advised to base64-encode other formats for sharing as text, and to be decoded locally by the recipient.


class SecretOwner:
    def __init__(self):
        # Initialize a dictionary to store secrets
        self.unique_path = {}

    def generate_secret(self, secret_text, expiry_time=None):
        # Ensure the secret text is within the allowed length
        secret_size = sys.getsizeof(secret_text)
        print(f"Secret size: {secret_size / 1024} KB")
        if not (1 <= secret_size <= 100 * 1024): # - 1.6 Text length should be of less than 1KB and a maximum length of 100KB. 
            raise ValueError("Secret text length must be between 1 byte and 100KB")
        
        # Generate a random secret
        unique_path = ''.join(random.choices(string.ascii_letters + string.digits, k=16))
        # Create a unique path for the secret
        # - 1.1 The URLs should not be easy to guess.
        path = f"/secrets/{unique_path}"
        # Generate a random 4-digit PIN. This can be customized as needed.
        pin = ''.join(random.choices(string.digits, k=4))
        #If expiry time given from user use that else use standard.
        if expiry_time is not None:
            expiry = expiry_time
        else:
            expiry = datetime.now() + timedelta(hours=24)
        # Store the secret, its corresponding PIN, and metadata
        self.unique_path[path] = {
            'pin': pin,
            'secret_text': secret_text,
            'attempts': 0,
            'expiry': expiry
        }
        # Return the path and PIN
        return path, pin

    def get_secret_info(self, path):
        return self.unique_path.get(path)

class SecretReader:
    def __init__(self, secret_owner):
        # Initialize with a reference to the SecretOwner instance
        self.secret_owner = secret_owner

    def retrieve_secret(self, path, pin):
        # Check if the path exists
        if path in self.secret_owner.unique_path:
            secret_info = self.secret_owner.unique_path[path]
            # Check if the secret has expired
            if datetime.now() > secret_info['expiry']:
                del self.secret_owner.unique_path[path]
                return "Secret has expired"
            # Check if the PIN is correct
            if secret_info['pin'] == pin:
                # Return the secret text and delete it to ensure one-time access
                secret_text = secret_info['secret_text']
                del self.secret_owner.unique_path[path]
                return secret_text
            else:
                # Increment the attempt counter
                secret_info['attempts'] += 1 #- 1.2 Secrets should only be one-time accessible and expire.
                # Check if the maximum attempts have been reached
                if secret_info['attempts'] >= 3: #- 1.3 Allow 3 attempts for a PIN.  
                    del self.secret_owner.unique_path[path]
                    return "Maximum PIN attempts reached. Secret is now inaccessible."
                return "Invalid PIN"
        else:
            return "Invalid path"

# Example usage:
# Create an instance of SecretOwner
owner = SecretOwner()
# Allow user to type his own secret
secret_text = input("Enter the secret text: ")
if not isinstance(secret_text, str):  # - 1.5 The secret can only be text.
    raise ValueError("Secret must be text")
if not secret_text.isalpha():
    raise ValueError("Secret must contain only alphabetic characters with no numbers or special characters")
expiry_input = input("Enter expiry time in hours (leave empty for default 24 hours, maximum 24 hours): ")
if expiry_input:
    try:
        expiry_hours = int(expiry_input)
        #- 1.4 Secrets should expire after 24 hours.
        if expiry_hours > 24:
            print("Expiry time cannot exceed 24 hours. Please enter a valid expiry time.")
            expiry_time = datetime.now() + timedelta(hours=24)
        expiry_time = datetime.now() + timedelta(hours=expiry_hours)
    except ValueError as e:
        print(e)
        expiry_time = datetime.now() + timedelta(hours=24)
else:
    expiry_time = datetime.now() + timedelta(hours=24)
# Generate a secret and get its path and PIN
path, pin = owner.generate_secret(secret_text, expiry_time)
# Print the secret path and PIN
print(f"Secret Path: {path}, PIN: {pin}")
print(f"# Please use base64-encode other formats for sharing as text, and to be decoded locally by the recipient.") # - 1.7 Users can be advised to base64-encode other formats for sharing as text, and to be decoded locally by the recipient.

# Create an instance of SecretReader with the SecretOwner instance
reader = SecretReader(owner)
# Retrieve the secret using the path and PIN
retrieved_secret = reader.retrieve_secret(path, pin)
# Print the retrieved secret
print(f"Retrieved Secret: {retrieved_secret}")