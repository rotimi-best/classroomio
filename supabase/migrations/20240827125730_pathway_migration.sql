create table "public"."pathway_newsfeed" (
    "id" bigint generated by default as identity not null,
    "created_at" timestamp with time zone not null default now(),
    "author_id" uuid,
    "content" text,
    "pathway_id" uuid,
    "reaction" jsonb,
    "is_pinned" boolean not null default false
);


create table "public"."pathway_newsfeed_comment" (
    "id" bigint generated by default as identity not null,
    "created_at" timestamp with time zone not null default now(),
    "author_id" uuid,
    "content" text,
    "pathway_newsfeed_id" bigint
);


alter table "public"."pathway" add column "certificate_theme" text;

alter table "public"."pathway" add column "is_certificate_downloadable" boolean default false;

alter table "public"."pathway" add column "lms_certificate" boolean;

alter table "public"."pathway_course" add column "is_unlocked" boolean not null default false;

CREATE UNIQUE INDEX pathway_newsfeed_comment_pkey ON public.pathway_newsfeed_comment USING btree (id);

CREATE UNIQUE INDEX pathway_newsfeed_pkey ON public.pathway_newsfeed USING btree (id);

alter table "public"."pathway_newsfeed" add constraint "pathway_newsfeed_pkey" PRIMARY KEY using index "pathway_newsfeed_pkey";

alter table "public"."pathway_newsfeed_comment" add constraint "pathway_newsfeed_comment_pkey" PRIMARY KEY using index "pathway_newsfeed_comment_pkey";

alter table "public"."pathway_newsfeed" add constraint "pathway_newsfeed_author_id_fkey" FOREIGN KEY (author_id) REFERENCES groupmember(id) not valid;

alter table "public"."pathway_newsfeed" validate constraint "pathway_newsfeed_author_id_fkey";

alter table "public"."pathway_newsfeed" add constraint "pathway_newsfeed_pathway_id_fkey" FOREIGN KEY (pathway_id) REFERENCES pathway(id) not valid;

alter table "public"."pathway_newsfeed" validate constraint "pathway_newsfeed_pathway_id_fkey";

alter table "public"."pathway_newsfeed_comment" add constraint "pathway_newsfeed_comment_author_id_fkey" FOREIGN KEY (author_id) REFERENCES groupmember(id) not valid;

alter table "public"."pathway_newsfeed_comment" validate constraint "pathway_newsfeed_comment_author_id_fkey";

alter table "public"."pathway_newsfeed_comment" add constraint "pathway_newsfeed_comment_pathway_newsfeed_id_fkey" FOREIGN KEY (pathway_newsfeed_id) REFERENCES pathway_newsfeed(id) not valid;

alter table "public"."pathway_newsfeed_comment" validate constraint "pathway_newsfeed_comment_pathway_newsfeed_id_fkey";

grant delete on table "public"."pathway_newsfeed" to "anon";

grant insert on table "public"."pathway_newsfeed" to "anon";

grant references on table "public"."pathway_newsfeed" to "anon";

grant select on table "public"."pathway_newsfeed" to "anon";

grant trigger on table "public"."pathway_newsfeed" to "anon";

grant truncate on table "public"."pathway_newsfeed" to "anon";

grant update on table "public"."pathway_newsfeed" to "anon";

grant delete on table "public"."pathway_newsfeed" to "authenticated";

grant insert on table "public"."pathway_newsfeed" to "authenticated";

grant references on table "public"."pathway_newsfeed" to "authenticated";

grant select on table "public"."pathway_newsfeed" to "authenticated";

grant trigger on table "public"."pathway_newsfeed" to "authenticated";

grant truncate on table "public"."pathway_newsfeed" to "authenticated";

grant update on table "public"."pathway_newsfeed" to "authenticated";

grant delete on table "public"."pathway_newsfeed" to "service_role";

grant insert on table "public"."pathway_newsfeed" to "service_role";

grant references on table "public"."pathway_newsfeed" to "service_role";

grant select on table "public"."pathway_newsfeed" to "service_role";

grant trigger on table "public"."pathway_newsfeed" to "service_role";

grant truncate on table "public"."pathway_newsfeed" to "service_role";

grant update on table "public"."pathway_newsfeed" to "service_role";

grant delete on table "public"."pathway_newsfeed_comment" to "anon";

grant insert on table "public"."pathway_newsfeed_comment" to "anon";

grant references on table "public"."pathway_newsfeed_comment" to "anon";

grant select on table "public"."pathway_newsfeed_comment" to "anon";

grant trigger on table "public"."pathway_newsfeed_comment" to "anon";

grant truncate on table "public"."pathway_newsfeed_comment" to "anon";

grant update on table "public"."pathway_newsfeed_comment" to "anon";

grant delete on table "public"."pathway_newsfeed_comment" to "authenticated";

grant insert on table "public"."pathway_newsfeed_comment" to "authenticated";

grant references on table "public"."pathway_newsfeed_comment" to "authenticated";

grant select on table "public"."pathway_newsfeed_comment" to "authenticated";

grant trigger on table "public"."pathway_newsfeed_comment" to "authenticated";

grant truncate on table "public"."pathway_newsfeed_comment" to "authenticated";

grant update on table "public"."pathway_newsfeed_comment" to "authenticated";

grant delete on table "public"."pathway_newsfeed_comment" to "service_role";

grant insert on table "public"."pathway_newsfeed_comment" to "service_role";

grant references on table "public"."pathway_newsfeed_comment" to "service_role";

grant select on table "public"."pathway_newsfeed_comment" to "service_role";

grant trigger on table "public"."pathway_newsfeed_comment" to "service_role";

grant truncate on table "public"."pathway_newsfeed_comment" to "service_role";

grant update on table "public"."pathway_newsfeed_comment" to "service_role";