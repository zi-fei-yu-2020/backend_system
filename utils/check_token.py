import jwt
from user.models import UserProfile
from backend_system.settings import SECRET_KEY
from utils.response_utils import Response


def validate_token(view_func):
    def wrapper(request, *args, **kwargs):
        try:
            # 验证请求头中的Authorization是否存在
            authorization_header = request.headers.get('Authorization')
            if not authorization_header:
                return Response(code=401, message='Unauthorized', result={'data': 'Token is missing'})

            # 提取Token
            token = authorization_header.split(' ')[1]

            # 验证Token的有效性
            secret_key = SECRET_KEY  # 这里需要替换为你的实际密钥
            decoded_token = jwt.decode(token, secret_key, algorithms=['HS256'])
            info = UserProfile.objects.filter(id=decoded_token["user_id"]).first()
            request.info = info

            if info is None:
                return Response(code=500, message="error", result={"data": "Invalid token"})
            return view_func(request, *args, **kwargs)
        except jwt.ExpiredSignatureError:
            return Response(code=401, message="error", result={"data": "Token has expired"})

        except jwt.InvalidTokenError:
            return Response(code=401, message="error", result={"data": "Invalid token"})

    return wrapper
