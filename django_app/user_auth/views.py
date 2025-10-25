from django.shortcuts import render, redirect
from django.contrib.auth import authenticate, login as auth_login # Rename login to avoid conflict
from django.contrib.auth.forms import AuthenticationForm

def login_view(request):
    if request.method == 'POST':
        # Use Django's built-in AuthenticationForm
        # It expects 'username' field, even if we use email in the template input
        form = AuthenticationForm(request, data=request.POST)
        if form.is_valid():
            username = form.cleaned_data.get('username')
            password = form.cleaned_data.get('password')
            # Authenticate using username (which is email in our case) and password
            user = authenticate(request, username=username, password=password)
            if user is not None:
                auth_login(request, user)
                # Redirect to a success page (change 'home' to your desired landing page)
                # We'll need to define a URL named 'home' later
                return redirect('home')
            else:
                # Invalid login - form.errors will be populated
                pass # Fall through to render form with errors
        else:
            # Form validation failed
            pass # Fall through to render form with errors
    else:
        # GET request: Show an empty login form
        form = AuthenticationForm()

    return render(request, 'user_auth/login.html', {'form': form})

# Add a simple view for the home page (or wherever you redirect after login)
def home_view(request):
    # This requires a template named 'home.html'
    # Create user_auth/templates/user_auth/home.html later
    return render(request, 'user_auth/home.html')
