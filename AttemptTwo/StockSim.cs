using System;
using System.Collections.Generic;

public class Stock
{
    public string Symbol { get; }
    public string CompanyName { get; }
    public decimal Price { get; private set; }
    public int Quantity { get; private set; }

    public Stock(string symbol, string companyName, decimal price, int quantity)
    {
        Symbol = symbol;
        CompanyName = companyName;
        Price = price;
        Quantity = quantity;
    }

    public decimal GetPrice()
    {
        return Price;
    }

    public void UpdatePrice(decimal newPrice)
    {
        Price = newPrice;
    }

    public bool Buy(int quantityToBuy, decimal userBalance)
    {
        if (quantityToBuy <= 0)
        {
            Console.WriteLine("Quantity to buy should be greater than zero.");
            return false;
        }

        decimal totalPrice = Price * quantityToBuy;
        if (totalPrice > userBalance)
        {
            Console.WriteLine("Insufficient balance to buy.");
            return false;
        }

        userBalance -= totalPrice;
        Quantity += quantityToBuy;
        Console.WriteLine($"{quantityToBuy} stocks of {CompanyName} bought successfully.");
        Console.WriteLine($"Remaining balance: {userBalance}");
        return true;
    }

    public bool Sell(int quantityToSell)
    {
        if (quantityToSell <= 0)
        {
            Console.WriteLine("Quantity to sell should be greater than zero.");
            return false;
        }

        if (Quantity < quantityToSell)
        {
            Console.WriteLine("Insufficient stocks to sell.");
            return false;
        }

        Quantity -= quantityToSell;
        Console.WriteLine($"{quantityToSell} stocks of {CompanyName} sold successfully.");
        return true;
    }

    public void SimulatePriceFluctuation()
    {
        Random random = new Random();
        int randomNumber = random.Next(0, 2); // 0 or 1 for price fluctuation (up or down)
        decimal changePercentage = (decimal)(random.Next(1, 10) * 0.01); // Random percentage between 1% to 10%

        if (randomNumber == 0) // Decrease price
        {
            decimal newPrice = Price * (1 - changePercentage);
            UpdatePrice(newPrice);
            Console.WriteLine($"The price of {CompanyName} ({Symbol}) decreased by {changePercentage * 100}% to {newPrice}");
        }
        else // Increase price
        {
            decimal newPrice = Price * (1 + changePercentage);
            UpdatePrice(newPrice);
            Console.WriteLine($"The price of {CompanyName} ({Symbol}) increased by {changePercentage * 100}% to {newPrice}");
        }
    }
}

public class User
{
    public decimal Balance { get; set; }
    private Dictionary<Stock, int> stockBalance;

    public User(decimal balance)
    {
        Balance = balance;
        stockBalance = new Dictionary<Stock, int>();
    }

    public void BuyStock(Stock stock, int quantity)
    {
        decimal totalPrice = stock.Price * quantity;
        if (totalPrice > Balance)
        {
            Console.WriteLine("Insufficient balance to buy.");
            return;
        }

        if (stockBalance.ContainsKey(stock))
        {
            stockBalance[stock] += quantity;
        }
        else
        {
            stockBalance.Add(stock, quantity);
        }

        Balance -= totalPrice;
        Console.WriteLine($"{quantity} stocks of {stock.CompanyName} bought successfully.");
        Console.WriteLine($"Remaining balance: {Balance}");
    }

    public void SellStock(Stock stock, int quantity)
    {
        if (stockBalance.ContainsKey(stock))
        {
            if (stockBalance[stock] >= quantity)
            {
                stockBalance[stock] -= quantity;
                Balance += stock.Price * quantity;
                Console.WriteLine($"{quantity} stocks of {stock.CompanyName} sold successfully.");
                Console.WriteLine($"Remaining balance: {Balance}");
            }
            else
            {
                Console.WriteLine("Insufficient stocks to sell.");
            }
        }
        else
        {
            Console.WriteLine("You do not own this stock in your portfolio.");
        }
    }

    public void ViewStockBalance()
    {
        Console.WriteLine("Stock Balance:");
        foreach (var kvp in stockBalance)
        {
            Console.WriteLine($"{kvp.Key.CompanyName} ({kvp.Key.Symbol}): Quantity - {kvp.Value}, Current Price - {kvp.Key.GetPrice()}");
        }
    }

    public void ViewBalance()
    {
        Console.WriteLine($"Current balance: {Balance}");
    }
}

class Program
{
    static void Main(string[] args)
    {
        User user = new User(10000); // Starting balance 10000 for example

        Stock appleStock = new Stock("AAPL", "Apple Inc.", 150.50m, 10);

        Console.WriteLine("Welcome to Stock Trading Simulator!");
        Console.WriteLine("Available Actions: buy, sell, view_balance, view_stock_balance, simulate_price");
        Console.WriteLine("Type 'exit' to quit.");

        while (true)
        {
            Console.Write("Enter action: ");
            string input = Console.ReadLine()?.Trim().ToLower();

            if (input == "exit")
            {
                break;
            }
            else if (input == "buy")
            {
                Console.Write("Enter stock symbol: ");
                string symbol = Console.ReadLine()?.Trim().ToUpper();

                Console.Write("Enter quantity to buy: ");
                int quantity;
                while (!int.TryParse(Console.ReadLine(), out quantity))
                {
                    Console.WriteLine("Please enter a valid quantity.");
                }

                user.BuyStock(appleStock, quantity);
            }
            else if (input == "sell")
            {
                Console.Write("Enter stock symbol: ");
                string symbol = Console.ReadLine()?.Trim().ToUpper();

                Console.Write("Enter quantity to sell: ");
                int quantity;
                while (!int.TryParse(Console.ReadLine(), out quantity))
                {
                    Console.WriteLine("Please enter a valid quantity.");
                }

                user.SellStock(appleStock, quantity);
            }
            else if (input == "view_balance")
            {
                user.ViewBalance();
            }
            else if (input == "view_stock_balance")
            {
                user.ViewStockBalance();
            }
            else if (input == "simulate_price")
            {
                appleStock.SimulatePriceFluctuation();
            }
            else
            {
                Console.WriteLine("Invalid action. Please try again.");
            }
        }
    }
}
