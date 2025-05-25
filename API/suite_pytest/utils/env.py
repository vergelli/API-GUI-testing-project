import os
from dotenv import load_dotenv

load_dotenv()

def get_env_variable(key: str, default: str = None) -> str:
    """Returns the value of an environment variable, or a default value."""
    value = os.getenv(key, default)
    print("value: ", value)
    if value is None:
        raise EnvironmentError(f"Falta la variable de entorno: {key}")
    return value
