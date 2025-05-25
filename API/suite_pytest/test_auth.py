"""
Test cases for authentication endpoints.
"""
from settings import API_BASE_URL, AUTH_ENDPOINT
from utils.env import get_env_variable

import requests

API_USER = get_env_variable("API_USER", "admin")
API_PASS = get_env_variable("API_PASS", "password")

def test_valid_authentication():
    payload = {"username": API_USER, "password": API_PASS}
    response = requests.post(f"{API_BASE_URL}/{AUTH_ENDPOINT}", json=payload)
    assert response.status_code == 200
    assert "token" in response.json()
