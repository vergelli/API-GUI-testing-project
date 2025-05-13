from robot.api.deco import keyword
from dotenv import load_dotenv
import os

@keyword("load env file")
def load_env_file(dotenv_path=".env"):
    """Carga variables de entorno desde un archivo .env"""
    if not os.path.exists(dotenv_path):
        raise FileNotFoundError(f"El archivo {dotenv_path} no fue encontrado.")
    load_dotenv(dotenv_path)
    return f"Variables de entorno cargadas desde {dotenv_path}"

@keyword("get env variable")
def get_env_variable(name):
    """Devuelve una variable de entorno"""
    value = os.getenv(name)
    if value is None:
        raise KeyError(f"La variable de entorno '{name}' no está definida.")
    return value
