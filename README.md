# Playwright Testing Repository

This project demonstrates automated UI and API testing using [Playwright](https://playwright.dev/).
It uses TypeScript for type safety and includes a structured approach to writing and organizing tests.
It includes sample tests, Playwright configuration for multiple browsers, and a GitHub Actions workflow for running tests in CI/CD pipelines.

---

## Installation

1. **Clone the repository:**
   ```bash
   git clone <your-repository-url>
   cd <repository-folder>
   ```

2. **Install dependencies:**
   ```bash
   npm ci
   ```

3. **Install Playwright browsers:**
   ```bash
   npx playwright install --with-deps
   ```

---

## Project Structure

- `tests/`  
  Contains example Playwright test files (e.g., `example.spec.ts`).

- `playwright.config.ts`  
  Playwright configuration (browser setup, test directory, reporting, etc.).

- `.github/workflows/playwright.yml`  
  GitHub Actions workflow for running tests automatically.

---

## Running Tests Locally

To execute tests in all configured browsers:
```bash
npx playwright test
```

A local HTML report is generated. To open the last report:
```bash
npx playwright show-report
```

---

## Continuous Integration (CI)

- **GitHub Actions**:  
  Tests are automatically run on every push or pull request to the `main` or `master` branch.
- **Scheduled Runs**:  
  Tests also execute daily at 00:00 UTC as a scheduled (cron) job.
- **Test Reports**:  
  After each CI run, a Playwright HTML report is uploaded as an artifact.

---

## Additional Resources

- [Playwright Documentation](https://playwright.dev/docs/intro)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)

---
