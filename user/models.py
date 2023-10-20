from django.contrib.auth.models import AbstractUser
from django.db import models
from rest_framework_simplejwt.tokens import RefreshToken
from django.contrib.auth.hashers import check_password as django_check_password


class UserPermission(models.Model):
    name = models.CharField(max_length=255, null=False)
    type = models.IntegerField(default=3,unique=True)


class UserProfile(AbstractUser):
    avatar = models.CharField(max_length=200, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    permission = models.ForeignKey(
        UserPermission,
        to_field='type',  # 设置外键使用type作为关联字段
        on_delete=models.CASCADE
    )

    def generate_token(self):
        refresh = RefreshToken.for_user(self)

        # 修改有效载荷，添加额外的用户信息
        payload = {
            'user_id': self.id,
            'username': self.username,
        }
        refresh.access_token.payload.update(payload)

        # 获取Access Token字符串
        access_token = str(refresh.access_token)

        # 返回Token
        return access_token

    def check_password(self, raw_password):
        # 检查密码是否正确
        return django_check_password(raw_password, self.password)


# 菜单表
class UserMenu(models.Model):
    name = models.CharField(max_length=255)
    icon = models.CharField(max_length=255, null=True)
    child = models.CharField(max_length=255, null=True)
    permission_type = models.IntegerField(default=3)

    def permission(self):
        return UserPermission.objects.get(type=self.permission_type)


