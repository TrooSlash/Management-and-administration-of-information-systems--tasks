from app import app

def test_home():
    client = app.test_client()
    response = client.get('/')
    assert response.status_code == 400
    assert response.data == b'Hello'
