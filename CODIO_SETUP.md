# Codio Setup Instructions

This guide will help you set up and run the Boggle game on Codio.

## Prerequisites

1. Python 3.11 or higher
2. Node.js 18 or higher
3. Django and dependencies installed

## Step-by-Step Setup

### 1. Install Python Dependencies

Open a terminal in Codio and run:

```bash
cd boggle_backend
pip install -r requirements.txt
```

If requirements.txt doesn't work, install manually:
```bash
pip install django djangorestframework django-cors-headers
```

### 2. Run Database Migrations

```bash
cd boggle_backend
python3 manage.py makemigrations
python3 manage.py migrate
```

### 3. Create Superuser (Optional)

```bash
python3 manage.py createsuperuser
```

### 4. Start Django Server

**IMPORTANT:** In Codio, you must run the server on `0.0.0.0:8000`:

```bash
cd boggle_backend
python3 manage.py runserver 0.0.0.0:8000
```

The server will be accessible at: `https://YOUR-BOX-NAME-8000.codio.io`

To find your box name:
- Go to **Project** → **Box Info** in the Codio menu
- Your box name will be shown there

### 5. Start React Frontend

Open a **NEW terminal** (keep Django running in the first terminal):

```bash
cd myboggle-app
npm install --legacy-peer-deps
npm start
```

The React app will be accessible at: `https://YOUR-BOX-NAME-3000.codio.io`

## Automatic Configuration

The React app **automatically detects** if it's running in Codio and adjusts the API URL accordingly. You don't need to manually change the URL in `App.js`.

## Testing the Setup

1. **Test Django API:**
   - Open: `https://YOUR-BOX-NAME-8000.codio.io/api/games/`
   - You should see an empty array `[]` or a list of games

2. **Test React App:**
   - Open: `https://YOUR-BOX-NAME-3000.codio.io`
   - Click "Start a new game!"
   - Select a grid size
   - The game should load from Django

## Troubleshooting

### CORS Errors

If you see CORS errors in the browser console:

1. Make sure `django-cors-headers` is installed
2. Check that `corsheaders` is in `INSTALLED_APPS` in `settings.py`
3. Verify `CorsMiddleware` is in `MIDDLEWARE`
4. The settings automatically detect Codio using the `CODIO_HOSTNAME` environment variable

### Connection Refused

If you see "Failed to create game" or connection errors:

1. Make sure Django is running on port 8000
2. Check that you're using `0.0.0.0:8000` (not just `8000`)
3. Verify the React app can access the Django URL
4. Check browser console for specific error messages

### Port Already in Use

If port 8000 is already in use:

```bash
# Find what's using the port
lsof -i :8000

# Or use a different port
python3 manage.py runserver 0.0.0.0:8001
```

Then update the React app to use port 8001 (or configure Codio to use port 8001).

### Dictionary File Not Found

If you see errors about the dictionary file:

1. Make sure the file exists at: `boggle_backend/boggle_backend/static/data/full-wordlist.json`
2. The file should contain: `{"words": ["word1", "word2", ...]}`

## Running Both Servers

You need **two terminals** running simultaneously:

**Terminal 1 - Django:**
```bash
cd boggle_backend
python3 manage.py runserver 0.0.0.0:8000
```

**Terminal 2 - React:**
```bash
cd myboggle-app
npm start
```

## Environment Variables

Codio automatically sets the `CODIO_HOSTNAME` environment variable. The Django settings use this to:
- Configure CORS allowed origins
- Set CSRF trusted origins
- Configure cookie settings

You don't need to manually set this variable.

## Verifying Your Setup

Run these commands to verify everything is set up correctly:

```bash
# Check Python version
python3 --version

# Check Django installation
python3 -c "import django; print(django.get_version())"

# Check Node version
node -v

# Check if Django server is running
curl http://localhost:8000/api/games/
```

If all commands work, your setup is complete!

