# Using AI inside GitHub Actions

This repository contains various GitHub Actions that utilize AI models to enhance your workflows. The primary focus is on using AI for code reviews, pull request comments, and other automation tasks.

All the major AI providers have GitHub Actions that allow you to use their models directly in your workflows. Here are some of the most popular ones:

- [OpenAI Codex](https://github.com/openai/codex/tree/main/.github/actions/codex)
- [Anthropic Claude Code](https://github.com/anthropics/claude-code-action)
- [Google Gemini CLI](https://github.com/google-gemini/gemini-cli-action)

## Use Cases

- **Automated Code Reviews**: Use AI to review pull requests and provide feedback on code quality, style, and potential issues.
- **Issue Triage**: Automatically triage issues based on their content and assign them to
- **Investigate Issues**: Use AI to analyze issues and suggest potential fixes or improvements.

View [the workflows](.github/workflows), [the issues](../../issues), and [the pull requests](../../pulls) to see how these actions are used in practice.

---

## 📟 Basic Calculator Web App

This repository now includes a very small, self-contained calculator web application that you can open in any modern browser.

### How to use

1. Clone or download the repository.
2. Open `calculator/index.html` in your favourite browser (double-clicking the file is fine).
3. Start calculating! You can use either the on-screen buttons **or your keyboard** (digits, operators, `Enter`, `Backspace`, `Esc`).

No build step or server is required – everything is plain HTML, CSS and JavaScript.

### File overview

* `calculator/index.html` – markup for the calculator.
* `calculator/style.css` – basic styling.
* `calculator/script.js` – client-side logic (expression building & evaluation).

The calculator deliberately avoids external dependencies to keep the example simple and portable.
