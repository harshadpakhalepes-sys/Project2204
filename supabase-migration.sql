-- ═══════════════════════════════════════════════════════════
--  LinkOrbit — Supabase Database Migration
--  Run this in your Supabase SQL editor
-- ═══════════════════════════════════════════════════════════

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- ─── Profiles ─────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS profiles (
  id          UUID PRIMARY KEY REFERENCES auth.users ON DELETE CASCADE,
  email       TEXT NOT NULL UNIQUE,
  full_name   TEXT,
  avatar_url  TEXT,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── Categories ───────────────────────────────────────────
CREATE TABLE IF NOT EXISTS categories (
  id          UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id     UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  name        TEXT NOT NULL,
  color       TEXT NOT NULL DEFAULT '#6366f1',
  icon        TEXT,
  created_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE(user_id, name)
);

-- ─── Links ────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS links (
  id            UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  user_id       UUID NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,
  category_id   UUID REFERENCES categories(id) ON DELETE SET NULL,
  title         TEXT NOT NULL,
  url           TEXT NOT NULL,
  description   TEXT,
  favicon_url   TEXT,
  og_image_url  TEXT,
  deadline      DATE,
  is_completed  BOOLEAN NOT NULL DEFAULT FALSE,
  is_pinned     BOOLEAN NOT NULL DEFAULT FALSE,
  tags          TEXT[] NOT NULL DEFAULT '{}',
  visit_count   INTEGER NOT NULL DEFAULT 0,
  last_visited  TIMESTAMPTZ,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─── Indexes ──────────────────────────────────────────────
CREATE INDEX IF NOT EXISTS idx_links_user_id       ON links(user_id);
CREATE INDEX IF NOT EXISTS idx_links_category_id   ON links(category_id);
CREATE INDEX IF NOT EXISTS idx_links_deadline      ON links(deadline) WHERE deadline IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_links_is_pinned     ON links(is_pinned) WHERE is_pinned = TRUE;
CREATE INDEX IF NOT EXISTS idx_links_tags          ON links USING GIN(tags);
CREATE INDEX IF NOT EXISTS idx_categories_user_id  ON categories(user_id);

-- ─── Row-Level Security ───────────────────────────────────
ALTER TABLE profiles   ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE links      ENABLE ROW LEVEL SECURITY;

-- Profiles policies
CREATE POLICY "Users can view own profile"
  ON profiles FOR SELECT USING (auth.uid() = id);
CREATE POLICY "Users can update own profile"
  ON profiles FOR UPDATE USING (auth.uid() = id);

-- Categories policies
CREATE POLICY "Users can CRUD own categories"
  ON categories FOR ALL USING (auth.uid() = user_id);

-- Links policies
CREATE POLICY "Users can CRUD own links"
  ON links FOR ALL USING (auth.uid() = user_id);

-- ─── Auto-create profile on signup ────────────────────────
CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id, email, full_name, avatar_url)
  VALUES (
    NEW.id,
    NEW.email,
    NEW.raw_user_meta_data->>'full_name',
    NEW.raw_user_meta_data->>'avatar_url'
  );
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

DROP TRIGGER IF EXISTS on_auth_user_created ON auth.users;
CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE handle_new_user();

-- ─── Auto-update updated_at ───────────────────────────────
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER links_updated_at
  BEFORE UPDATE ON links
  FOR EACH ROW EXECUTE PROCEDURE update_updated_at();

CREATE TRIGGER profiles_updated_at
  BEFORE UPDATE ON profiles
  FOR EACH ROW EXECUTE PROCEDURE update_updated_at();
