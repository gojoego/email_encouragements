# Email Encouragements (Rails)

app that emails words of encouragement at specified intervals

---

## Tech Stack

* **Ruby** (see `.ruby-version`)
* **Rails 7**
* **Bundler** for dependency management
* **SQLite** (dev/test)
* **Docker** (optional, via `dockerfile-rails`)

---

## Prerequisites

### macOS (Apple Silicon/Intel)

1. Xcode Command Line Tools

   ```bash
   xcode-select --install
   ```
2. Homebrew packages (rbenv + SQLite)

   ```bash
   brew install rbenv ruby-build sqlite
   ```
3. Initialize rbenv

   ```bash
   echo 'eval "$(rbenv init - zsh)"' >> ~/.zshrc
   exec zsh
   ```

### Linux (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install -y build-essential libsqlite3-dev zlib1g-dev libreadline-dev libssl-dev git
# rbenv install instructions: https://github.com/rbenv/rbenv#installation
```

> **Why rbenv?** Using the system Ruby (e.g., macOS 2.6) causes permission errors and native extension build failures. A per-project Ruby avoids that.

---

## Quick Start (Local)
# 0) Clone
git clone <repo-url>
cd email-encouragements

# 1) Ruby version
rbenv install "$(cat .ruby-version)" -s
rbenv local "$(cat .ruby-version)"
ruby -v

# 2) Bundler
grep -A1 "BUNDLED WITH" Gemfile.lock || true
# If a version is shown, install that exact version; otherwise install latest:
# gem install bundler -v <version>
gem install bundler

# 3) Install gems (add local platforms if lockfile came from another OS)
bundle lock --add-platform ruby || true
bundle lock --add-platform arm64-darwin-23 || true   # Apple Silicon
bundle config set --local force_ruby_platform true
bundle install

# 4) Environment variables (optional for local mail)
cp .env.example .env 2>/dev/null || true
# then edit .env with your SMTP creds if you want to test sending mail

# 5) Database (SQLite)
bin/rails db:prepare    # create + migrate (uses config/database.yml)

# 6) Run the app
bin/rails s
# Visit http://localhost:3000


Describe how to obtain secrets (e.g., from 1Password, team vault, or create test creds).

---

## Running Tests

```bash
# If using Rails default (minitest):
bin/rails test

# If using RSpec:
bundle exec rspec
```

---

## Docker (Optional)

This repo includes **dockerfile-rails** support. Example workflow:

```bash
# 1) Build images
docker compose build

# 2) Set up the database (if using SQLite, ensure a volume is mounted for persistence)
docker compose run --rm web bin/rails db:prepare

# 3) Start services
docker compose up
# App at http://localhost:3000
```

If the app uses SQLite, make sure your `docker-compose.yml` mounts the app directory (so `db/development.sqlite3` persists). If you switch to Postgres, add a `db` service and update `DATABASE_URL` accordingly.

---

## Common Issues & Fixes

### 1) Permission error installing gems (system Ruby)

```
Gem::FilePermissionError: You don't have write permissions for /Library/Ruby/Gems/...
```

**Fix**: Use rbenv (see Prerequisites) and **do not** use `sudo gem install`.

### 2) sqlite3 gem resolved to a yanked platform (e.g., `1.5.3-x86_64-linux`)

```
Your bundle is locked to sqlite3 (1.5.3-x86_64-linux)...
```

**Fix**:

```bash
brew install sqlite # macOS
bundle lock --add-platform ruby arm64-darwin-23 # or x86_64-darwin-23
bundle update sqlite3
```

Optionally loosen the version in `Gemfile`:

```ruby
gem "sqlite3", "~> 1.6"
```

### 3) `nio4r` native extension fails during install

**Fix**:

```bash
xcode-select --install                 # macOS toolchain
bundle config set --local force_ruby_platform true
bundle update nio4r
bundle install --verbose               # inspect extconf/mkmf errors if needed
```

### 4) Bundler version mismatch

If `Gemfile.lock` has a **BUNDLED WITH** section, install that exact Bundler:

```bash
grep -A 1 "BUNDLED WITH" Gemfile.lock
gem install bundler -v <version>
```

---

## Scripts & Useful Commands

```bash
bin/rails db:migrate
bin/rails db:seed
bin/rails console
bin/rails routes
```

---

## Project Structure 

app/
  assets/
  channels/
  controllers/
  helpers/  
  javascript/
  jobs/
  mailers/
  models/
  views/
config/
  database.yml
  environments/
db/
  migrate/
Gemfile
Gemfile.lock


