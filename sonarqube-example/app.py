import os

def insecure():
    password = "hardcoded123"  # SonarQube akan flag ini
    os.system(f"echo {input('Command: ')}")  # Command injection

insecure()
