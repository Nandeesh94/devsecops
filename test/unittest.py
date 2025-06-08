import unittest
from app import app

class FlaskAppTestCase(unittest.Testcase):
    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True

    def test_homepage(self):
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"welcome to nandeesh" response.data.lower())

    def test_login_get(self):
        response = self.app.get('/login')
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"Enter username", response.data)

    def test_login_post(self):
        response = self.app.post('/login', data={'username': 'nandeesh'})
        self.assertEqual(response.status_code, 200)
        self.assertIn(b"hello, nandeesh", response.data.lower())

if __name__ == '__main__':
    unittest.main()
