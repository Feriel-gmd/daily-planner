# Daily Planner: setup guide

You need two free accounts: **Supabase** (database and login) and **Vercel** (puts the app online). It takes about 20 minutes.

## 1. Create the database (Supabase)

1. Go to supabase.com, sign up, and click **New project**. Pick any name, set a database password dailyplanner2026, choose the region closest to you.
2. Wof `sait about 2 minutes until the project is ready.
3. Open **SQL Editor > New query**, paste the whole content chema.sql`, and click **Run**. It should say "Success". This creates the table and the privacy rules, so every user only sees their own data.
4. Open **Project settings > API**. Copy the **Project URL** and the **anon public** key.
5. Open `config.js` in this folder and paste both values between the quotes. Save the file.

## 2. Choose the login rules (Supabase)

Open **Authentication > Providers > Email** (it is on by default).

- For a personal app, you can turn **Confirm email** off, so sign-up logs you in immediately.
- If you keep it on, you get a confirmation email after sign-up, and you must open its link before logging in.
- After step 3 below, come back to **Authentication > URL Configuration** and set **Site URL** to your Vercel address. This makes confirmation and password-reset links open your app.

## 3. Put the app online (Vercel)

Easiest way, with GitHub:
1. Create a GitHub account and a new empty repository.
2. Upload all the files of this folder (click **Add file > Upload files**) and commit.
3. Go to vercel.com, sign up with GitHub, click **Add New > Project**, and import the repository.
4. Leave every setting as it is (no framework, no build command) and click **Deploy**.

Without GitHub: on vercel.com you can also drag this folder onto the dashboard of the "deploy" page (or use the Vercel CLI).

You get an address like `your-app.vercel.app`. Open it, create your account, and you are in.

## 4. Install it on your phone and laptop

- **Android (Chrome):** open your address, tap the menu, then **Add to Home screen** or **Install app**.
- **Laptop (Chrome or Edge):** click the install icon at the right end of the address bar.

Log in with the same email and password on both devices. Your data syncs between them.

## What is in this folder

| File | Purpose |
|---|---|
| `index.html` | The whole app |
| `config.js` | Your Supabase URL and key (the only file you edit) |
| `schema.sql` | Database table and privacy rules (run once in Supabase) |
| `supabase.js` | The Supabase client library (version 2.45.4) |
| `manifest.webmanifest`, `sw.js`, `icon-*.png` | Make it installable and let it open offline |

## How saving works

- Every change is saved on your device first, then sent to Supabase. If you are offline, the change waits on the device and is sent automatically when the connection returns.
- If you edit the same item on two devices while offline, the last one to sync wins.
- Your data is protected by row-level security: even though the anon key is in `config.js`, nobody can read another user's rows.

## Troubleshooting

- **"Add your Supabase URL and key in config.js"**: the two values in `config.js` are still the placeholders.
- **"Email or password is incorrect"**: check for typos, or use **Forgot password?**.
- **No confirmation email**: check spam, or turn **Confirm email** off (step 2).
- **Supabase free projects pause after a week with no activity.** Open the Supabase dashboard and click **Restore** if the app stops saving after a long break.
- **Changes on one device do not appear on the other**: check that step 1.3 ran without errors (the last line of `schema.sql` turns on live updates). The app also re-syncs every minute and when you reopen it.

## Not included yet

Push notifications (reminders when the app is closed) and a "delete my account" button.
