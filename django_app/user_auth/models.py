from django.db import models

class Login(models.Model):
    username = models.CharField(max_length=150, unique=True)
    # Store hashed passwords, NEVER plain text in real applications!
    password_hash = models.CharField(max_length=128)
    email = models.EmailField(unique=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.username
