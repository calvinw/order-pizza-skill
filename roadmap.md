Pizza Ordering Skill Roadmap

## Phase 1 — Static skill (current)
The menu is hardcoded in the skill file. Students run /pizza-ordering and
place an order immediately with no setup needed. Focus is on learning what
a skill is and how the ordering conversation works.

## Phase 2 — Fetch the menu from an MCP server
The menu moves into a database. The skill queries the MCP at the start of
each session to fetch the current menu as a list. Students see why a
database is useful — update the menu in one place and it shows up
everywhere automatically. The ordering flow stays the same, only the source
of the menu changes.

## Phase 3 — Students add their own menu items
Students write to the database to add new pizzas, toppings, or prices.
First time they interact with the data directly. Their item shows up in the
next ordering session, making it personal and concrete.

## Phase 4 — Store completed orders in the database
The skill writes finished orders back to the database when the session
closes. The full loop is now closed — data flows in both directions.
Students can query their order history, see totals, and explore the data
they created.
