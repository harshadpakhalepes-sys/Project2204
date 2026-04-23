# 🔗 LinkOrbit

**Your work links, beautifully organised.**

A centralized link management platform for employees to save, organise, and act on work-related links with deadlines, categories, tags, and smart search.

![Tech Stack](https://img.shields.io/badge/Next.js-14-black?logo=next.js) ![Supabase](https://img.shields.io/badge/Supabase-Database-green?logo=supabase) ![TypeScript](https://img.shields.io/badge/TypeScript-5-blue?logo=typescript) ![TailwindCSS](https://img.shields.io/badge/Tailwind-3-38bdf8?logo=tailwindcss) ![Vercel](https://img.shields.io/badge/Deploy-Vercel-black?logo=vercel)

---

## ✨ Features

- **🔗 Smart Link Saving** — Auto-fetches title, description & favicon from any URL
- **⏰ Deadline Tracking** — Colour-coded urgency: Overdue, Due Today, Due Tomorrow
- **📁 Categories & Tags** — Flexible organisation with colour-coded categories
- **📌 Pin & Prioritise** — Pin important links to always surface them first
- **✅ Mark Complete** — Track what you've acted on
- **🔍 Instant Search** — Search by title, URL, description, or tags
- **🎨 3D Landing Page** — Interactive Three.js neon tubes background
- **🔐 Secure Auth** — Email/password, Magic Link, Google & GitHub OAuth via Supabase
- **📱 Responsive** — Works great on desktop and mobile

---

## 🚀 Quick Start

### 1. Clone & Install

```bash
git clone https://github.com/yourname/linkorbit.git
cd linkorbit
npm install
```

### 2. Set Up Supabase

1. Create a project at [supabase.com](https://supabase.com)
2. In your Supabase dashboard, go to **SQL Editor**
3. Paste and run the contents of `supabase-migration.sql`
4. Enable **Email Auth** and optionally Google/GitHub OAuth under **Authentication → Providers**

### 3. Configure Environment

```bash
cp .env.example .env.local
```

Fill in your values:
```env
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
NEXT_PUBLIC_APP_URL=http://localhost:3000
```

> Find your keys in Supabase → **Project Settings → API**

### 4. Run Locally

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) 🎉

---

## ☁️ Deploy to Vercel

### Option A: One-click deploy

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/yourname/linkorbit)

### Option B: Vercel CLI

```bash
npm i -g vercel
vercel login
vercel --prod
```

When prompted, add your environment variables. Or set them in the Vercel dashboard under **Project → Settings → Environment Variables**:

| Variable | Value |
|----------|-------|
| `NEXT_PUBLIC_SUPABASE_URL` | Your Supabase project URL |
| `NEXT_PUBLIC_SUPABASE_ANON_KEY` | Your Supabase anon key |
| `SUPABASE_SERVICE_ROLE_KEY` | Your Supabase service role key |
| `NEXT_PUBLIC_APP_URL` | Your Vercel deployment URL |

### Option C: Push to GitHub → Auto-deploy

1. Push to GitHub
2. Import project at [vercel.com/new](https://vercel.com/new)
3. Add environment variables
4. Done — every push auto-deploys ✅

---

## 🗃️ Database Schema

```sql
profiles      → id, email, full_name, avatar_url
categories    → id, user_id, name, color, icon
links         → id, user_id, category_id, title, url, description,
                favicon_url, deadline, is_completed, is_pinned, tags,
                visit_count, last_visited
```

Full schema + RLS policies in `supabase-migration.sql`.

---

## 🏗️ Project Structure

```
linkorbit/
├── app/
│   ├── page.tsx              # Landing page (Three.js 3D background)
│   ├── auth/page.tsx         # Auth (sign in / sign up / magic link)
│   ├── dashboard/
│   │   ├── layout.tsx        # Auth guard
│   │   └── page.tsx          # Main dashboard
│   ├── api/
│   │   ├── links/route.ts    # GET, POST links
│   │   ├── links/[id]/route.ts # PATCH, DELETE
│   │   └── meta/route.ts     # URL metadata fetcher
│   └── globals.css
├── components/
│   ├── ThreeBackground.tsx   # Three.js interactive neon tubes
│   ├── LinkCard.tsx          # Link display card (grid + list)
│   ├── AddLinkModal.tsx      # Create / edit link modal
│   ├── Sidebar.tsx           # Navigation sidebar
│   ├── Navbar.tsx            # Top navbar with search
│   ├── DeadlineBadge.tsx     # Colour-coded deadline indicator
│   └── EmptyState.tsx        # Smart empty states
├── lib/
│   ├── supabase.ts           # Browser Supabase client
│   ├── supabaseServer.ts     # Server Supabase client
│   ├── database.types.ts     # TypeScript DB types
│   ├── store.ts              # Zustand state management
│   └── utils.ts              # Utilities + helpers
├── middleware.ts             # Supabase session refresh
├── supabase-migration.sql    # Full DB schema + RLS
└── vercel.json               # Vercel deployment config
```

---

## 🛠️ Tech Stack

| Layer | Technology | Why |
|-------|-----------|-----|
| Framework | Next.js 14 (App Router) | SSR, file-based routing, API routes |
| Language | TypeScript | Type safety across full stack |
| Styling | Tailwind CSS | Rapid utility-first styling |
| 3D | Three.js | GPU-accelerated WebGL canvas |
| Auth + DB | Supabase | Postgres + RLS + OAuth in one |
| State | Zustand | Lightweight, no boilerplate |
| Animation | Framer Motion | Production-grade animations |
| Toasts | react-hot-toast | Clean notifications |
| Hosting | Vercel | Zero-config Next.js deploys |

---

## 🔒 Security

- **Row-Level Security (RLS)** on all tables — users can only access their own data
- **Auth guard** middleware refreshes sessions on every request
- **Server-side user validation** on all API routes
- **Input validation** on all form fields

---

## 🗺️ Roadmap

- [ ] v1.0 — MVP (current)
- [ ] v1.1 — Category management UI, bulk actions
- [ ] v1.2 — Link previews with OG images
- [ ] v1.3 — Deadline email reminders
- [ ] v2.0 — Team workspaces & sharing
- [ ] v2.1 — AI assistant (summarise, prioritise)
- [ ] v2.2 — Browser extension

---

## 📄 License

MIT — free to use and modify.

---

Built with ❤️ using Next.js, Supabase, and Three.js.
