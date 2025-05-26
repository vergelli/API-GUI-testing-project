from robot.api.deco import keyword
from dotenv import load_dotenv
import os

@keyword("load env file")
def load_env_file(dotenv_path=".env"):
    """Carga variables de entorno desde un archivo .env"""
    if not os.path.exists(dotenv_path):
        raise FileNotFoundError(f"El archivo {dotenv_path} no fue encontrado.")
    load_dotenv(dotenv_path, override=False)  # No sobrescribir si ya están seteadas
    return f"Variables de entorno cargadas desde {dotenv_path}"

@keyword("get env variable")
def get_env_variable(name, dotenv_path=None):
    """
    Devuelve una variable de entorno.
    Si no está definida, intenta cargar desde dotenv_path (si se pasa).
    """
    value = os.getenv(name)
    if value is not None:
        return value

    if dotenv_path:
        if not os.path.exists(dotenv_path):
            raise FileNotFoundError(f"El archivo {dotenv_path} no fue encontrado.")
        load_dotenv(dotenv_path, override=False)
        value = os.getenv(name)
        if value is not None:
            return value

    raise KeyError(f"La variable de entorno '{name}' no está definida.")
