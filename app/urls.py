"""
URL configuration for app project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.2/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path,include
from rest_framework import permissions
from drf_yasg.views import get_schema_view
from drf_yasg import openapi


SchemaView = get_schema_view(
    openapi.Info(
        title="Base API",
        default_version="v1",
        description="API documentation.",
    ),
    public=True,
    permission_classes=(permissions.AllowAny,),
)


api_v1_url_patterns = [
    path("docs/swagger/", SchemaView.with_ui("swagger", cache_timeout=0), name="schema-swagger-ui"),
    path("docs/redoc/", SchemaView.with_ui("redoc", cache_timeout=0), name="schema-redoc"),
]


urlpatterns = [
    path("v1/", include(api_v1_url_patterns)),
    path("admin/", admin.site.urls),
]
