# Quick Start Guide for Codio

## 🚀 Fast Setup (3 Steps)

### 1. Install Dependencies
```bash
cd boggle_backend
pip install django djangorestframework django-cors-headers
```

### 2. Setup Database
```bash
python3 manage.py makemigrations
python3 manage.py migrate
```

### 3. Start Servers

**Terminal 1 - Django:**
```bash
cd boggle_backend
python3 manage.py runserver 0.0.0.0:8000
```

**Terminal 2 - React:**
```bash
cd myboggle-app
npm install --legacy-peer-deps
npm start
```

## ✅ That's It!

The app will automatically:
- ✅ Detect Codio environment
- ✅ Configure CORS correctly
- ✅ Connect React to Django
- ✅ Use the correct URLs

## 🔍 Find Your URLs

1. **Django API:** `https://YOUR-BOX-NAME-8000.codio.io`
2. **React App:** `https://YOUR-BOX-NAME-3000.codio.io`

To find YOUR-BOX-NAME: Go to **Project** → **Box Info** in Codio menu

## 🧪 Test It

1. Open React app URL in browser
2. Click "Start a new game!"
3. Select grid size
4. Play!

## ❌ Troubleshooting

**CORS Error?**
- Make sure Django is running on `0.0.0.0:8000` (not just `8000`)
- Check that `corsheaders` is installed

**Connection Failed?**
- Verify Django is running: Check Terminal 1
- Check browser console for specific error
- Make sure both servers are running

**Dictionary Not Found?**
- File should be at: `boggle_backend/boggle_backend/static/data/full-wordlist.json`
- Create it if missing (see README.md)

