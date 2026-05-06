# Megan Life 5.0 — Brain Architecture Clean

Estrutura limpa com:

- `android-app/`: app Flutter Android com Brain local.
- `backend/`: backend Node.js/Express pronto para Render.

## Rodar backend local

```powershell
cd backend
npm install
copy .env.example .env
npm run dev
```

Teste:

```powershell
Invoke-RestMethod http://localhost:10000/api/health
```

## Rodar Android

```powershell
cd android-app
flutter pub get
flutter run
```

No arquivo `android-app/lib/core/config/app_config.dart`, altere a URL da API quando o backend estiver no Render.
