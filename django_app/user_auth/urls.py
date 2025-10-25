from django.urls import path
from . import views # Import views from the current directory (user_auth/views.py)

urlpatterns = [
    # This maps the URL '/login/' (relative to the app) to the login_view function
    path('login/', views.login_view, name='login'),

    # This maps the root URL '/' (relative to the app) to the home_view function
    path('', views.home_view, name='home'),

    # Add other URLs for your app here (e.g., registration, logout) later
]
