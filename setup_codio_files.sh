#!/bin/bash
# Script to create all missing React files in Codio
# Run this in Codio: bash setup_codio_files.sh

cd ~/workspace/boggle-app || cd ~/workspace/myboggle-app

# Create src directory if it doesn't exist
mkdir -p src
mkdir -p public

# Create GameState.js
cat > src/GameState.js << 'EOF'
const GAME_STATE = {
  BEFORE: 'before',
  IN_PROGRESS: 'in_progress',
  ENDED: 'ended',
};

export {GAME_STATE};
EOF

# Create Board.js
cat > src/Board.js << 'EOF'
import Grid from "@material-ui/core/Grid";
import Paper from "@material-ui/core/Paper";
import React from 'react';
import './Board.css';

function Board({board}) {
  function tile(id, letter) {
    return(
      <Grid key={id} item xs={1} className="Tile">
        <Paper elevation={4}>
         {letter}
        </Paper>
      </Grid>);
  }

  function rowOfTiles(id, rowObj) {
    return (
      <Grid key={id} container spacing={1} justify="space-around">
        {Object.keys(rowObj).map((letterKey) => {
          return tile(letterKey + id, rowObj[letterKey])
        })}
      </Grid>);
  }

  function gridOfRows(board) {
    if (!board || board.length === 0) {
      return null;
    }
    // Handle both array and object formats
    const boardKeys = Array.isArray(board) ? board.map((_, i) => i.toString()) : Object.keys(board);
    return (
      <Grid item xs={12}>
        {boardKeys.map((rowKey) => {
          const row = Array.isArray(board) ? board[parseInt(rowKey)] : board[rowKey];
          return rowOfTiles(rowKey, row);
        })}
      </Grid>);
  }

  return (
    <div className="Board-div">
      <Grid container justify="center">
        {gridOfRows(board)}
      </Grid>
    </div>
  );
}

export default Board;
EOF

# Create GuessInput.js
cat > src/GuessInput.js << 'EOF'
import React, { useState } from 'react';
import TextField from "@material-ui/core/TextField";
import './GuessInput.css';

function GuessInput({allSolutions, foundSolutions, correctAnswerCallback}) {
  const [labelText, setLabelText] = useState("Make your first guess!");
  const [input, setInput] = useState("");

  function evaluateInput() {
    const upperInput = input.toUpperCase().trim();
    if (upperInput === "") {
      return;
    }
    if (foundSolutions.includes(upperInput)) {
      setLabelText(upperInput + " has already been found!");
    } else if (allSolutions.includes(upperInput)) {
      correctAnswerCallback(upperInput);
      setLabelText(upperInput + " is correct!");
    } else {
      setLabelText(upperInput + " is incorrect!");
    }
  }

  function keyPress(e) {
    if (e.key === 'Enter') {
      e.target.value = "";
      evaluateInput();
      setInput(""); // Clear the input state as well
    }
  }

  return (
    <div className="Guess-input">
      <div>
        {labelText}
      </div>
      <TextField 
        value={input}
        onKeyPress={(e) => keyPress(e)} 
        onChange={(event) => setInput(event.target.value)} 
        placeholder="Type a word and press ENTER"
      />
    </div>
  );
}

export default GuessInput;
EOF

# Create FoundSolutions.js
cat > src/FoundSolutions.js << 'EOF'
import React from 'react';
import './FoundSolutions.css';

function FoundSolutions({ words, headerText}) {
  const wordsList = words || [];
  // Filter words with length > 3 if showing missed words
  const displayWords = headerText && headerText.includes('Missed') 
    ? wordsList.filter(word => word && word.length > 3)
    : wordsList;
  
  return (
    <div className="Found-solutions-list">
      {displayWords.length > 0 &&
        <h4>{headerText}: {displayWords.length}</h4>
      }
      <ul>
        {displayWords.length > 0 ? (
          displayWords.map((solution) => {return <li key={solution}>{solution}</li>})
        ) : (
          <li>No words found</li>
        )}
      </ul>
    </div>
  );
}

export default FoundSolutions;
EOF

# Create SummaryResults.js
cat > src/SummaryResults.js << 'EOF'
import React from 'react';
import './SummaryResults.css';

function SummaryResults({ words, totalTime}) {
  return (
    <div className="Summary-results-list">
      <h2>SUMMARY</h2>
      <div>
        <li key="12">Total Words Found: {words ? words.length : 0}</li>
      </div>
      <div>
        <li key="15">Total Time: {totalTime ? totalTime.toFixed(2) : '0.00'} secs</li>
      </div>    
    </div>
  );
}

export default SummaryResults;
EOF

# Create ToggleGameState.js
cat > src/ToggleGameState.js << 'EOF'
import React, {useState} from 'react';
import Button from "@material-ui/core/Button";
import {GAME_STATE} from './GameState.js';
import MenuItem from '@material-ui/core/MenuItem';
import FormHelperText from '@material-ui/core/FormHelperText';
import Select from '@material-ui/core/Select';
import FormControl from '@material-ui/core/FormControl';
import './ToggleGameState.css';

function ToggleGameState({gameState, setGameState, setSize, setTotalTime}) {
  const [buttonText, setButtonText] = useState("Start a new game!");
  const [startTime, setStartTime] = useState(0);
  const [currentSize, setCurrentSize] = useState(3);
  let deltaTime;

  function updateGameState(endTime) {
    if (gameState === GAME_STATE.BEFORE || gameState === GAME_STATE.ENDED) {
      setStartTime(Date.now());
      setGameState(GAME_STATE.IN_PROGRESS);
      setButtonText("End game");
    } else if (gameState === GAME_STATE.IN_PROGRESS) {
      deltaTime = (endTime - startTime) / 1000.0;
      setTotalTime(deltaTime); 
      setGameState(GAME_STATE.ENDED);
      setButtonText("Start a new game!");
    }
  }

  const handleChange = (event) => {
    const newSize = event.target.value;
    setCurrentSize(newSize);
    setSize(newSize);
  };

  return (
    <div className="Toggle-game-state">
      <Button variant="outlined" onClick={() => updateGameState(Date.now())}>
        {buttonText}
      </Button>

      { (gameState === GAME_STATE.BEFORE || gameState === GAME_STATE.ENDED) &&
        <div className="Input-select-size">
          <FormControl>
            <Select
              labelId="sizelabel"
              id="sizemenu"
              value={currentSize}
              onChange={handleChange}
            >
              <MenuItem value={3}>3</MenuItem>
              <MenuItem value={4}>4</MenuItem>
              <MenuItem value={5}>5</MenuItem>
              <MenuItem value={6}>6</MenuItem>
              <MenuItem value={7}>7</MenuItem>
              <MenuItem value={8}>8</MenuItem>
              <MenuItem value={9}>9</MenuItem>
              <MenuItem value={10}>10</MenuItem>
            </Select>
            <FormHelperText>Set Grid Size</FormHelperText>
          </FormControl>
        </div>
      }
    </div>
  );
}

export default ToggleGameState;
EOF

# Create index.js
cat > src/index.js << 'EOF'
import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import App from './App';

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOF

# Create CSS files
cat > src/App.css << 'EOF'
.App {
  color: #282c34;
  width: 60%;
  margin: auto;
  padding: 20px;
  text-align: center;
}

.logo {
  display: block;
  margin: 20px auto;
  max-width: 200px;
}
EOF

cat > src/Board.css << 'EOF'
.Board-div {
  width: 700px;
  margin: auto;
  font-size: 40pt;
}

.Tile {
  text-align: center;
  line-height: 50pt;
  vertical-align: middle;
}
EOF

cat > src/GuessInput.css << 'EOF'
.Guess-input {
  border: 15px solid grey;
  margin: 30px;
  text-align: center;
  padding: 30px;
  padding-left: 20px;
  padding-right: 20px;
  width: 10;
}
EOF

cat > src/FoundSolutions.css << 'EOF'
.Found-solutions-list {
  text-align: center;
  margin: 25pt;
}

.Found-solutions-list ul {
  list-style-type: none;
}

.Found-solutions-list li {
  font-size: 14pt;
  line-height: 20pt;
}
EOF

cat > src/SummaryResults.css << 'EOF'
.Summary-results-list {
  text-align: center;
  margin: 25pt;
}

.Summary-results-list ul {
  list-style-type: none;
}

.Summary-results-list li {
  font-size: 14pt;
  line-height: 20pt;
}
EOF

cat > src/ToggleGameState.css << 'EOF'
.Toggle-game-state {
  text-align: center;
  margin-top: -50pt;
  margin-bottom: 25pt;
}

.Input-select-size {
  margin-top: -28.4pt;
  margin-left: 200pt;
  margin-bottom: 25pt;
}
EOF

cat > src/index.css << 'EOF'
body {
  margin: 0;
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Oxygen',
    'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',
    sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

code {
  font-family: source-code-pro, Menlo, Monaco, Consolas, 'Courier New',
    monospace;
}
EOF

# Create public/index.html
cat > public/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="theme-color" content="#000000" />
    <meta
      name="description"
      content="Bison Boggle Word Game"
    />
    <title>Bison Boggle</title>
  </head>
  <body>
    <noscript>You need to enable JavaScript to run this app.</noscript>
    <div id="root"></div>
  </body>
</html>
EOF

# Create a simple logo.svg placeholder
cat > src/logo.svg << 'EOF'
<svg width="200" height="200" xmlns="http://www.w3.org/2000/svg">
  <rect width="200" height="200" fill="#4CAF50"/>
  <text x="100" y="120" font-family="Arial" font-size="48" font-weight="bold" fill="white" text-anchor="middle">BB</text>
  <text x="100" y="160" font-family="Arial" font-size="24" fill="white" text-anchor="middle">BOGGLE</text>
</svg>
EOF

echo "All files created successfully!"
echo "Run 'npm start' to start the React app"

