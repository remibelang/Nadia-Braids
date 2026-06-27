# Professional Hair Braiding Website

A complete, professional hair braiding website with admin panel, built with HTML/CSS/JavaScript and Supabase backend.

## 🚀 Quick Start

### 1. Supabase Setup

1. Go to [supabase.com](https://supabase.com) and create a free account
2. Create a new project
3. Go to Project Settings → API → Copy `URL` and `anon public` key
4. Paste them into `js/supabase-config.js`

### 2. Database Tables

Go to SQL Editor → New Query and run:

```sql
-- Settings table
CREATE TABLE settings (
    id SERIAL PRIMARY KEY,
    business_name TEXT,
    address TEXT,
    phone TEXT,
    email TEXT,
    about_text TEXT,
    hero_image TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Services table
CREATE TABLE services (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name TEXT NOT NULL,
    category TEXT,
    price DECIMAL(10,2) NOT NULL,
    duration TEXT,
    description TEXT,
    image_url TEXT,
    active BOOLEAN DEFAULT true,
    display_order INTEGER DEFAULT 0,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Gallery table
CREATE TABLE gallery (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    title TEXT,
    category TEXT,
    image_url TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

-- Bookings table
CREATE TABLE bookings (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    phone TEXT NOT NULL,
    service_id UUID REFERENCES services(id),
    date DATE NOT NULL,
    time TEXT NOT NULL,
    notes TEXT,
    status TEXT DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT NOW()
);