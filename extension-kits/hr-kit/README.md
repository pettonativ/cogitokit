# HR Kit - Automated Sourcing & Recruitment

This kit provides AI-powered tools for technical recruitment and candidate sourcing using OSINT techniques and X-Ray search patterns.

## 🚀 Features

- **Autonomous Sourcing**: Find candidates on LinkedIn and other platforms without a browser.
- **X-Ray Search**: Advanced boolean query construction for technical roles.
- **Automated Reporting**: Generates structured Markdown reports with candidate details.

## 🛠 Project Structure

- `.agent/agents/`: Specialized agents (e.g., `hr-recruiter`).
- `.agent/skills/`: Sourcing methodologies and search patterns.
- `.agent/scripts/`: Execution scripts for Serper.dev and other tools.
- `candidates_{tech}_{location}_report.md`: Output reports.

## 📋 Usage

### /source-candidates

Finds candidates for a specific technology and location.

```bash
/source-candidates [technology] [location]
```

## 🔐 Configuration

Ensure you have a `SERPER_API_KEY` configured or available in `.agent/scripts/serper_search.py`.
