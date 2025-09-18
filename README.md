# Overleaf & GitHub Sync

This repository is automatically synchronized with an Overleaf project.

## Required Setup

### GitHub Secrets Configuration

Before the sync workflow can function, you need to configure the following secrets in your GitHub repository:

| Secret Name | Description | Required | Example Value |
|-------------|-------------|----------|---------------|
| `OVERLEAF_ID` | Your Overleaf project ID (from git URL) | Yes | `507f1f77bcf86cd799439011` |
| `OVERLEAF_TOKEN` | Your Overleaf git access token | Yes | `your-overleaf-token` |
| `GH_TOKEN` | GitHub Personal Access Token for repository access | Yes | `ghp_xxxxxxxxxxxxxxxxxxxx` |
| `GIT_USER_NAME` | Git committer name | Yes | `Your Name` |
| `GIT_USER_EMAIL` | Git committer email | Yes | `your-email@example.com` |
| `GEMINI_TOKEN` | Google AI Studio API key for commit messages | Optional | `AIzaSyxxxxxxxxxxxxxxxxx` |

### How to Set Up Secrets

1. **Navigate to Repository Settings**:
   - Go to your GitHub repository
   - Click on **Settings** tab
   - In the left sidebar, click **Secrets and variables** → **Actions**

2. **Add Each Secret**:
   - Click **New repository secret**
   - Enter the secret name (e.g., `OVERLEAF_ID`)
   - Enter the corresponding value
   - Click **Add secret**
   - Repeat for all secrets

### How to Obtain Required Tokens

#### 1. Overleaf Project ID and Token

1. **Find Project ID**:
   - Open your Overleaf project
   - Click **Menu** → **Git**
   - Copy the git URL: `https://git.overleaf.com/YOUR_PROJECT_ID`
   - The `YOUR_PROJECT_ID` part is your `OVERLEAF_ID`

2. **Get Overleaf Token**:
   - Go to [Overleaf Account Settings](https://www.overleaf.com/user/settings)
   - Navigate to **Git Integration** section
   - Generate or copy your **Git access token**
   - Use this as `OVERLEAF_TOKEN`

#### 2. GitHub Personal Access Token

1. **Create GitHub Token**:
   - Go to [GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)](https://github.com/settings/tokens)
   - Click **Generate new token (classic)**
   - Set expiration (recommend 90 days or no expiration)
   - Select scopes:
     - ✅ `repo` (Full control of private repositories)
     - ✅ `workflow` (Update GitHub Action workflows)
   - Click **Generate token**
   - Copy the token immediately (you won't see it again)
   - Use this as `GH_TOKEN`

#### 3. Google AI Studio API Key (Optional)

1. **Get Gemini API Key**:
   - Go to [Google AI Studio](https://aistudio.google.com/)
   - Sign in with your Google account
   - Click **Get API key** in the left sidebar
   - Click **Create API key**
   - Select a Google Cloud project or create a new one
   - Copy the generated API key
   - Use this as `GEMINI_TOKEN`

> **Note**: The Gemini token is optional. If not provided, the workflow will use default commit messages.

### Security Best Practices

- **Never share your tokens** or commit them to your repository
- **Set token expiration** where possible and renew regularly
- **Use minimal required permissions** for GitHub tokens
- **Monitor token usage** in your account settings

## How it Works

A GitHub Actions workflow (`.github/workflows/sync-overleaf.yml`) is set up to keep this repository in sync with the corresponding Overleaf project.

### Synchronization Process

1.  **Scheduled Sync**: The workflow runs automatically every hour. It can also be triggered manually from the Actions tab.
2.  **Fetch from Overleaf**: It fetches the latest changes from the Overleaf project's git repository.
3.  **Merge**: It merges the changes from Overleaf into the `master` branch of this GitHub repository.
4.  **Conflict Resolution**: In case of merge conflicts between the GitHub repository and the Overleaf project, the workflow is configured to automatically favor the changes from Overleaf.
5.  **Push to GitHub**: The final merged version is pushed to the `master` branch of this repository.

This setup ensures that the GitHub repository serves as a reliable backup and version history for the Overleaf project.


