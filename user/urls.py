from django.urls import path

from user import views

urlpatterns = [
    path('register', views.register),
    path('login', views.login),
    path('userinfo', views.user_info),
    path('change_pwd', views.change_password)
]
