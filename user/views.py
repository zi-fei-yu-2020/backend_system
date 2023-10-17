import json
from datetime import datetime

from rest_framework.decorators import api_view
from rest_framework_simplejwt.tokens import RefreshToken
from utils.response_utils import Response
from django.contrib.auth.hashers import make_password
from user.models import UserProfile, UserPermission, UserMenu
from utils.check_token import validate_token


# Create your views here.
@api_view(['POST'])
def register(request):
    username = request.data.get('username')
    password = request.data.get('password')

    if UserProfile.objects.filter(username=username).exists():
        return Response({'error': 'Username already exists'}, status=400)

    hashed_password = make_password(password)

    created_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    avatar = "https://cdn.acwing.com/media/user/profile/photo/91657_lg_941861e133.jpeg"

    # 创建用户权限
    permission_type = 3
    permission = UserPermission.objects.get(type=permission_type)

    user = UserProfile.objects.create(
        username=username,
        password=hashed_password,
        avatar=avatar,
        created_at=created_time,
        permission=permission
    )

    return Response(code=200, message="success", result={"data": "register successful!"})


@api_view(['POST'])
def login(request):
    username = request.data.get('username')
    password = request.data.get('password')

    try:
        user = UserProfile.objects.get(username=username)
    except UserProfile.DoesNotExist:
        return Response(code=500, message="error", result={'data': 'Invalid username or password'})

    if not user.check_password(password):
        return Response(code=500, message="error", result={'data': 'Invalid username or password'})

    refresh = RefreshToken.for_user(user)
    token = str(refresh.access_token)

    return Response(code=200, message="success", result={'token': token})


@validate_token
@api_view(['GET'])
def user_info(request):
    token_name = request.info
    info = UserProfile.objects.filter(username=token_name).first()
    if info is None:
        return Response(code=500, message="error", result={"data": "User not found"})

    perm = info.permission_id
    menus = UserMenu.objects.filter(permission_type=perm)

    result = []
    for menu in menus:
        menu_data = {
            "name": menu.name,
            "icon": menu.icon,
            "child": json.loads(menu.child.replace("'", "\""))
        }
        result.append(menu_data)

    data = {
        "id": info.id,
        "username": info.username,
        "avatar": info.avatar,
        "permission": info.permission_id,
        "menus": result
    }

    return Response(code=200, message="success", result={"data": data})


@validate_token
@api_view(['POST'])
def change_password(request):
    print(1)
    old_password = request.data.get('oldpassword')
    print(old_password)
    new_password = request.data.get('password')
    print(new_password)
    confirm_password = request.data.get('repassword')
    print(confirm_password)

    # 获取当前用户对象
    user = request.user

    # 检查旧密码是否正确
    if not user.check_password(old_password):
        return Response(code=500, message="error", result={"data": "请检查你的旧密码是否正确"})

    # 检查新密码和确认密码是否一致
    if new_password != confirm_password:
        return Response(code=500, message="error", result={"data": "请检查你的新密码和确认密码是否正确"})

    # 对新密码进行哈希处理
    hashed_password = make_password(new_password)

    # 更新用户的密码
    user.password = hashed_password
    user.save()

    return Response(code=200, message="success", result={"data": "修改密码成功!!!"})
