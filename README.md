# Pizza Ordering Skill

## Your Assignment

A pizza ordering skill is already built and ready to go. Your job is to try it out and then customize it.

## How to Work on This

1. **Try it out.** Say something like "let's order a pizza" to start a session. Place a test order and see how the agent behaves — what it asks, how it calculates discounts, and how the order total works out.

2. **Change the menu.** Pick at least one item and update its price, or add a brand new menu item. Tell the agent what you want to change and it will make the edit for you.

3. **Adjust the discounts.** Change one of the discount tiers — maybe lower the threshold or increase the percentage. See how it affects the final total when you place another order.

After any change, say "let's order a pizza" again to start a fresh session with your updated skill.

The skill is installed and ready to go.

---

## For Reference: Skill Spec

This describes what the skill does. You don't need to build it — it's already done — but this is useful if you want to understand how it works or make more significant changes.

---

### Menu

The agent should know the following menu items and prices.

**Pizzas**  -  available in Large, Medium, and Small:
- Pepperoni pizza: 12.95 / 10.00 / 7.00
- Cheese pizza: 10.75 / 9.25 / 6.50
- Eggplant pizza: 13.70 / 10.25 / 7.50

**Toppings** (added to any pizza):
- Extra cheese 2.00, Mushrooms 1.50, Sausage 3.00, Canadian bacon 3.50, Peppers 1.00

**Drinks**  -  available in Large, Medium, and Small:
- Coke: 3.50 / 2.50 / 1.50
- Sprite: 3.00 / 2.00 / 1.00
- Bottled water: 4.00

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

The agent should ask for the customer's name — that's all the contact info needed.

After taking the order, the agent should ask whether the customer is a senior citizen, apply the right discount, and show the final total with the math clearly laid out.

**Current order table:** Once the customer has added at least one item, every response from the agent should end with a markdown table showing the current order — item, quantity, size, price, and a running total row at the bottom. This table should update automatically as items are added.
