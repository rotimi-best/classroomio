create type "public"."LOCALE" as enum ('en', 'hi', 'fr', 'pt', 'de', 'vi', 'ru', 'es');

create table
  public.lesson_language (
    id bigint generated by default as identity,
    content text null,
    lesson_id uuid null default gen_random_uuid (),
    locale "LOCALE" default 'en'::"LOCALE",
    constraint lesson_language_pkey primary key (id),
    constraint public_lesson_language_lesson_id_fkey foreign key (lesson_id) references lesson (id)
  ) tablespace pg_default;

alter table "public"."profile" add column "locale" "LOCALE" default 'en'::"LOCALE";