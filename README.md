# Pizza Ordering Skill

## Your Assignment

Your job is to build a pizza ordering skill for an AI agent.

When it's working, you'll be able to say something like "let's order a pizza" and the agent will become **"The Order Technician"** - a friendly bot that takes a pizza order, calculates discounts, and saves a receipt.

## How to Work on This

You'll build and test the skill together with the agent in the same conversation.

1. **Ask the agent to write the skill.** Share the spec below and ask the agent to fill in the skill file. It will explain what it's doing as it goes.
2. **Test it.** Say something like "let's order a pizza" to start an ordering session and see how it behaves.
3. **Want to change something?** Just tell the agent what you'd like to adjust. It will pause the session, make the change, and reload the skill automatically.
4. **Start fresh.** After any change, say "let's order a pizza" again to start a new session with the updated skill.

The skill file is at `.skillshare/skills/order-pizza/SKILL.md`.

---

## Skill Spec

This describes what the skill needs to do. Give this to your agent and ask it to write the skill.

---

### Menu

The agent should know the following menu items and prices.

**Pizzas**  -  available in Large, Medium, and Small:
- Pepperoni pizza: 12.95 / 10.00 / 7.00
- Cheese pizza: 10.95 / 9.25 / 6.50
- Eggplant pizza: 11.95 / 9.75 / 6.75

**Sides:**
- Fries: Regular 4.50, Small 3.50
- Greek salad: 7.25

**Toppings** (added to any pizza):
- Extra cheese 2.00, Mushrooms 1.50, Sausage 3.00, Canadian bacon 3.50, Peppers 1.00

**Drinks**  -  available in Large, Medium, and Small:
- Coke: 3.00 / 2.00 / 1.00
- Sprite: 3.00 / 2.00 / 1.00
- Bottled water: 5.00

---

### Discounts

There should be a tiered discount based on the order subtotal:

- Under 20  -  no discount
- 20-49.99  -  5% off
- 50-99.99  -  10% off
- 100 or more  -  15% off

There should also be an extra 5% discount for senior citizens, added on top of whatever tier applies. For example, if the order qualifies for 10% off and the customer is a senior citizen, they get 10% + 5% = 15% off  -  one simple discount applied to the total, not two separate discounts stacked on top of each other.

---

### What the Ordering Session Should Do

The agent should greet the customer as "The Order Technician" and take the order conversationally.

The agent should ask for the customer's name and phone number, and whether they want delivery or pickup. For delivery, it should collect an address.

Before finalizing, the agent should ask whether the customer is a senior citizen, apply the right discount, and show the final total with the math clearly laid out.

**Current order table:** Once the customer has added at least one item, every response from the agent should end with a markdown table showing the current order - item, size, price, and a running total row at the bottom. This table should update automatically as items are added.

---

### Saving the Order

After the session ends, the agent should save a record of the order to the `orders/` folder. The file should start with a summary of the order details at the top, followed by the full conversation transcript. It should also capture the model's thinking process if available.
