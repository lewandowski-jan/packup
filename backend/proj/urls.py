from django.contrib import admin
from django.urls import path, include
from api import views
from rest_framework import routers

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api-auth/', include('rest_framework.urls')),
    path('ping/', views.Ping.as_view())
]
