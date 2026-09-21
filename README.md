# Filo — Barbería

Landing page con sistema de reservas real, hecha como pieza de portafolio.

**Demo en vivo:** https://barberia-filo.netlify.app
**Panel admin (demo):** https://barberia-filo.netlify.app/filo-admin.html — clave `filo2026`

## Qué hace

Un cliente entra, elige servicio, día y hora, y confirma el turno sin llamar por teléfono. La reserva se guarda al instante en una base de datos real (Postgres, vía Supabase) y aparece en un panel de administración donde se puede confirmar o cancelar cada turno.

## Stack

- HTML, CSS y JavaScript vanilla (sin frameworks ni build step)
- [Supabase](https://supabase.com) (Postgres + API REST) como backend
- [Netlify](https://netlify.com) para el deploy

## Características técnicas

- **Reservas sin duplicados, con protección en dos capas**: se valida en el navegador que el horario esté libre antes de guardar, y además hay un índice único en la base de datos (`reservas_fecha_hora_activa_unique`, ver [supabase-unique-horario.sql](supabase-unique-horario.sql)) que rechaza cualquier choque de horario aunque dos personas reserven al mismo tiempo exacto.
- **Row Level Security** activado en Postgres: el rol público solo puede insertar y leer reservas, nunca borrarlas.
- Diseño responsive con menú mobile, animaciones de aparición al hacer scroll (`IntersectionObserver`) y estados de carga/error en el formulario.
- Panel admin con vista en vivo de las reservas, filtros por estado y acciones para confirmar/cancelar.

## Estructura

```
index.html            → landing pública con el formulario de reservas
filo-admin.html        → panel de administración (protegido con clave simple, solo para demo)
supabase-unique-horario.sql  → migración SQL con la restricción de horarios únicos
```

## Correrlo local

No necesita build ni dependencias — es HTML plano.

```bash
git clone https://github.com/Lissandra2009/Barberia.git
cd Barberia
# abrir index.html directo en el navegador, o servirlo con cualquier server estático:
npx serve .
```

## Base de datos

Tabla `reservas` en Supabase (Postgres):

| Columna      | Tipo      |
|--------------|-----------|
| id           | uuid      |
| created_at   | timestamp |
| nombre       | text      |
| telefono     | text      |
| servicio     | text      |
| fecha        | date      |
| hora         | text      |
| estado       | text (`pendiente` / `confirmado` / `cancelado`) |

## Nota

Este es un proyecto de portafolio — los datos del negocio (nombre, dirección, equipo, reseñas) son ficticios. Las credenciales de Supabase incluidas en el código son la clave pública (`anon key`), pensada para vivir en el frontend.
