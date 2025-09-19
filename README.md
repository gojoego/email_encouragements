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

1. **Choose/Install the Ruby version**

   ```bash
   # Use the version in .ruby-version (create/update it if needed)
   cat .ruby-version || echo "<your-ruby-version>"

   # Install and activate
   rbenv install $(cat .ruby-version) # if not already installed
   rbenv local $(cat .ruby-version)
   ruby -v
   ```

2. **Install Bundler** (match the lockfile if present)

   ```bash
   # See the Bundler version the repo was locked with (if any)
   grep -A 1 "BUNDLED WITH" Gemfile.lock || true
   # If a version shows (e.g., 2.4.22), install that exact version:
   gem install bundler -v <version>
   # Otherwise, install latest bundler
   gem install bundler
   bundler -v
   ```

3. **Install gems**

   ```bash
   # If the lockfile was generated on Linux or another OS, add your platform(s)
   bundle lock --add-platform ruby
   # Apple Silicon (Sonoma+). For Intel Macs, use x86_64-darwin-23
   bundle lock --add-platform arm64-darwin-23 || true

   # Prefer building native gems from source on macOS
   bundle config set --local force_ruby_platform true

   bundle install
   ```

4. **Database setup (SQLite)**

   ```bash
   bin/rails db:prepare   # creates & migrates
   ```

5. **Run the app**

   ```bash
   bin/rails s
   # Visit http://localhost:3000
   ```

---

## Environment Variables

List any required env vars here. Example:

```bash
# .env (if using dotenv-rails)
SMTP_USERNAME=
SMTP_PASSWORD=
```

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
rubocop -A            # if rubocop is configured
```

---

## Project Structure (excerpt)

```
app/
  controllers/
  models/
  views/
config/
  database.yml
  environments/
db/
  migrate/
Gemfile
Gemfile.lock
```

Add or update this tree to match the repository.

---

## Contributing

* Create a feature branch
* Open a PR with a clear description and screenshots if UI changes
* Ensure tests pass and lints are clean

---

## License

Add your license (MIT, Apache-2.0, etc.) here.
