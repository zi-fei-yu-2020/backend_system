import json
from django.core.serializers.json import DjangoJSONEncoder
from django.http import HttpResponse


class Response(HttpResponse):
    def __init__(self, code, message, result={}, encoder=DjangoJSONEncoder, safe=True,
                 json_dumps_params=None, **kwargs):
        data = {'code': code, 'message': message, 'result': result}
        if safe and not isinstance(data, dict):
            raise TypeError(
                'In order to allow non-dict objects to be serialized, set the '
                'safe parameter to False.'
            )
        if json_dumps_params is None:
            json_dumps_params = {}
        kwargs.setdefault('content_type', 'application/json')
        data = json.dumps(data, cls=encoder, **json_dumps_params)
        super().__init__(content=data, **kwargs)