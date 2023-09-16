DATABASES = {
    'default': {
        'ATOMIC_REQUESTS': True,
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': "awx",
        'USER': "awx",
        'PASSWORD': "awxpass",
        'HOST': "192.168.121.235",
        'PORT': "5432",
    }
}

BROADCAST_WEBSOCKET_SECRET = "dGcuY0oyMnZkZy1oTy1aal90S1ZhSWFfOko2SkpUOnJ4Z3o0VzA3REVlZGNxMm9DWllzZkdIQlRPdGFNX2RuWW1XbzlGV0lqWHloaXNiNndIOm5IbkpwcXQtTVU5UU10SEtMZ09vV0pOaEtVMmVUcjJTdkpBT3Rnb21VdzNvX08="
