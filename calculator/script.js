/* eslint-env browser */

// Basic calculator logic

const display = document.getElementById('display');
const keys = document.querySelector('.calculator__keys');

// Maintain the current expression as a string
let expression = '';

// Map button actions to operator symbols
const operatorMap = {
  add: '+',
  subtract: '-',
  multiply: '*',
  divide: '/',
};

function updateDisplay() {
  display.value = expression || '0';
}

function appendSymbol(symbol) {
  expression += symbol;
  updateDisplay();
}

function clearDisplay() {
  expression = '';
  updateDisplay();
}

function deleteLast() {
  expression = expression.slice(0, -1);
  updateDisplay();
}

function calculate() {
  if (!expression) return;

  try {
    // eslint-disable-next-line no-eval
    const result = Function(`"use strict"; return (${expression})`)();
    expression = String(result);
    updateDisplay();
  } catch (err) {
    display.value = 'Error';
    expression = '';
  }
}

// Handle click events using event delegation
keys.addEventListener('click', (e) => {
  if (!e.target.matches('button')) return;

  const { action } = e.target.dataset;
  const buttonContent = e.target.textContent;

  if (!action) {
    // A number or dot key
    appendSymbol(buttonContent);
    return;
  }

  switch (action) {
    case 'add':
    case 'subtract':
    case 'multiply':
    case 'divide':
      appendSymbol(operatorMap[action]);
      break;
    case 'decimal':
      appendSymbol('.');
      break;
    case 'clear':
      clearDisplay();
      break;
    case 'delete':
      deleteLast();
      break;
    case 'calculate':
      calculate();
      break;
    default:
      break;
  }
});

// Allow keyboard input as well
document.addEventListener('keydown', (e) => {
  const { key } = e;

  if (/^[0-9]$/.test(key)) {
    appendSymbol(key);
  } else if (key === '.') {
    appendSymbol('.');
  } else if (['+', '-', '*', '/'].includes(key)) {
    appendSymbol(key);
  } else if (key === 'Enter') {
    calculate();
  } else if (key === 'Backspace') {
    deleteLast();
  } else if (key === 'Escape') {
    clearDisplay();
  }
});

