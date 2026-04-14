# Supabase Schema

Loyiha Supabase backend ishlatadi. Quyidagi jadvallar kerak.

## `transactions`

```sql
create table transactions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  title text not null,
  amount numeric(14,2) not null,
  currency text not null default 'UZS',
  kind text not null check (kind in ('income', 'expense')),
  date timestamptz not null default now(),
  category text,
  note text,
  created_at timestamptz not null default now()
);

create index transactions_user_date_idx on transactions (user_id, date desc);

alter table transactions enable row level security;

create policy "users read own transactions" on transactions
  for select using (auth.uid() = user_id);

create policy "users insert own transactions" on transactions
  for insert with check (auth.uid() = user_id);

create policy "users update own transactions" on transactions
  for update using (auth.uid() = user_id);

create policy "users delete own transactions" on transactions
  for delete using (auth.uid() = user_id);
```

## Env o'zgaruvchilari

Loyihani ishga tushirishdan oldin:

```bash
export SUPABASE_URL="https://YOUR_PROJECT.supabase.co"
export SUPABASE_ANON_KEY="YOUR_ANON_KEY"
```

Yoki Xcode scheme → Run → Arguments → Environment Variables'ga qo'shing.
