# Boggle Backend - Django REST API

This is the Django backend for the Boggle word game application.

## Setup Instructions

### 1. Install Python Dependencies

```bash
pip install -r requirements.txt
```

Or install individually:
```bash
pip install django djangorestframework django-cors-headers
```

### 2. Run Migrations

Create the database tables:

```bash
cd boggle_backend
python manage.py makemigrations
python manage.py migrate
```

### 3. Create Superuser (Optional)

To access the Django admin panel:

```bash
python manage.py createsuperuser
```

### 4. Run the Server

```bash
python manage.py runserver 0.0.0.0:8000
```

For Codio:
```bash
python manage.py runserver 0.0.0.0:8000
```

Then access at: `https://YOUR-BOX-NAME-8000.codio.io`

For local development:
```bash
python manage.py runserver
```

Then access at: `http://localhost:8000`

## API Endpoints

### Create a Random Game
```
GET /api/game/create/{size}
```
Example: `http://localhost:8000/api/game/create/4`

### Get All Games
```
GET /api/games/
```
Example: `http://localhost:8000/api/games/`

### Get a Specific Game
```
GET /api/game/{id}
```
Example: `http://localhost:8000/api/game/1`

### Delete a Game
```
DELETE /api/game/{id}
```
Example: `DELETE http://localhost:8000/api/game/1`

## Configuration

### For Codio Platform

The settings.py file is already configured for Codio with:
- CORS headers enabled
- CSRF protection adjusted for Codio
- Static files configured

### For Local Development

Update `CORS_ALLOWED_ORIGINS` in `boggle_backend/settings.py`:

```python
CORS_ALLOWED_ORIGINS = [
    'http://localhost:3000',
]
```

## Dictionary File

The dictionary file should be located at:
`boggle_backend/boggle_backend/static/data/full-wordlist.json`

Make sure this file exists and contains a JSON object with a "words" key containing an array of words.

