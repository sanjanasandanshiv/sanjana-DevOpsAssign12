"""
URL configuration for main_project project.
"""
from django.contrib import admin
from django.urls import path, include # Make sure include is imported

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('user_auth.urls')), # Include your app's URLs
]
