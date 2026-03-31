# Pizza Ordering Skill

## Your Assignment

Your job is to build a pizza ordering skill for an AI agent.

When it's working, you'll be able to type `/pizza-ordering` and the agent will become **"The Order Technician"** — a friendly bot that takes a pizza order, calculates discounts, and saves a receipt.

Right now the skill file is empty (just a header). You need to fill it in using the spec below.

## How to Work on This

Open two terminals side by side. Use one to test the skill by running `/pizza-ordering`, and the other to ask your agent to update the skill file. Your instructor will show you how to do this in class.

The skill file is at `.skillshare/skills/pizza-ordering/SKILL.md`.

---

## Skill Spec

This describes what the skill needs to do. Give this to your agent and ask it to write the skill.

---

### Menu

The agent should know the following menu items and prices.

**Pizzas** — available in Large, Medium, and Small:
- Pepperoni pizza: 12.95 / 10.00 / 7.00
- Cheese pizza: 10.95 / 9.25 / 6.50
- Eggplant pizza: 11.95 / 9.75 / 6.75

**Sides:**
- Fries: Regular 4.50, Small 3.50
- Greek salad: 7.25

**Toppings** (added to any pizza):
- Extra cheese 2.00, Mushrooms 1.50, Sausage 3.00, Canadian bacon 3.50, Peppers 1.00

**Drinks** — available in Large, Medium, and Small:
- Coke: 3.00 / 2.00 / 1.00
- Sprite: 3.00 / 2.00 / 1.00
- Bottled water: 5.00

---

### Discounts

There should be a tiered discount based on the order subtotal:

- Under $20 — no discount
- $20–$49.99 — 5% off
- $50–$99.99 — 10% off
- $100 or more — 15% off

There should also be an extra 5% discount for senior citizens, added on top of whatever tier applies. For example, if the order qualifies for 10% off and the customer is a senior citizen, they get 10% + 5% = 15% off — one simple discount applied to the total, not two separate discounts stacked on top of each other.

---

### What the Ordering Session Should Do

The agent should greet the customer as "The Order Technician" and take the order conversationally. There should be a way to see the running total as items are added.

The agent should ask for the customer's name and phone number, and whether they want delivery or pickup. For delivery, it should collect an address.

Before finalizing, the agent should ask whether the customer is a senior citizen, apply the right discount, and show the final total with the math clearly laid out.

There should be a way to see the complete final order — items, sizes, prices, discount applied, and total — before closing out.

---

### Saving the Order

After the session ends, the agent should save a record of the order to the `orders/` folder. The file should start with a summary of the order details at the top, followed by the full conversation transcript. It should also capture the model's thinking process if available.
