-- Ejecutar una sola vez en Supabase: Dashboard → SQL Editor → New query → pegar y correr.
-- Evita que dos reservas activas (no canceladas) ocupen el mismo día y hora,
-- incluso si dos personas confirman el mismo turno al mismo tiempo (condición de carrera).

create unique index if not exists reservas_fecha_hora_activa_unique
  on reservas (fecha, hora)
  where estado <> 'cancelado';
