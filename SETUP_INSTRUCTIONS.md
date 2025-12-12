# Boggle Game - Full Stack Setup Instructions

This project consists of a React frontend and Django backend.

## Prerequisites

- Python 3.11 or higher
- Node.js 18 or higher
- pip (Python package manager)
- npm (Node package manager)

## Backend Setup (Django)

### 1. Navigate to Django project
```bash
cd boggle_backend
```

### 2. Install Python dependencies
```bash
pip install -r requirements.txt
```

Or install manually:
```bash
pip install django djangorestframework django-cors-headers
```

### 3. Run database migrations
```bash
python manage.py makemigrations
python manage.py migrate
```

### 4. Create superuser (optional, for admin access)
```bash
python manage.py createsuperuser
```

### 5. Start Django server

**For local development:**
```bash
python manage.py runserver
```
Server will run at: `http://localhost:8000`

**For Codio:**
```bash
python manage.py runserver 0.0.0.0:8000
```
Server will run at: `https://YOUR-BOX-NAME-8000.codio.io`

## Frontend Setup (React)

### 1. Navigate to React project
```bash
cd myboggle-app
```

### 2. Install dependencies
```bash
npm install --legacy-peer-deps
```

### 3. Update API URL in App.js

If using Codio, update the URL in `myboggle-app/src/App.js`:
```javascript
const url = "https://YOUR-BOX-NAME-8000.codio.io/api/game/create/" + size;
```

For local development, it should already be:
```javascript
const url = "http://localhost:8000/api/game/create/" + size;
```

### 4. Start React development server
```bash
npm start
```
App will run at: `http://localhost:3000`

## Running Both Servers

You need to run both servers simultaneously:

1. **Terminal 1 - Django Backend:**
   ```bash
   cd boggle_backend
   python manage.py runserver
   ```

2. **Terminal 2 - React Frontend:**
   ```bash
   cd myboggle-app
   npm start
   ```

## API Endpoints

Once Django is running, you can test the API endpoints:

- **Create Game:** `GET http://localhost:8000/api/game/create/4`
- **List All Games:** `GET http://localhost:8000/api/games/`
- **Get Game by ID:** `GET http://localhost:8000/api/game/1`
- **Delete Game:** `DELETE http://localhost:8000/api/game/1`

## Dictionary File

Make sure the dictionary file exists at:
`boggle_backend/boggle_backend/static/data/full-wordlist.json`

The file should contain a JSON object with a "words" array. You can add more words to this file.

## Troubleshooting

### CORS Errors
If you see CORS errors, make sure:
1. `django-cors-headers` is installed
2. `corsheaders` is in `INSTALLED_APPS`
3. `CorsMiddleware` is in `MIDDLEWARE`
4. `CORS_ALLOWED_ORIGINS` includes your frontend URL

### Database Errors
If you see database errors:
```bash
cd boggle_backend
python manage.py makemigrations
python manage.py migrate
```

### Port Already in Use
If port 8000 is already in use:
```bash
python manage.py runserver 8001
```
Then update the URL in React App.js to use port 8001.

## Testing

1. Start Django server
2. Start React app
3. Open browser to `http://localhost:3000`
4. Click "Start a new game!"
5. Select a grid size
6. Play the game!

