CREATE OR REPLACE MACRO seconds_to_hhmmss(sec) AS (
      COALESCE(
        try_cast(
            lpad((((sec::int) // 3600)::int)::text, 2, '0') || ':' ||
            lpad((((((sec::int) % 3600) // 60)::int)::text), 2, '0') || ':' ||
            lpad(((sec::int)::INT % 60)::text, 2, '0') as VARCHAR
           ) ,
        sec::text
    )
);
