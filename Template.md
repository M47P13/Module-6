# Stock Trading Simulator Program Overview

The Stock Trading Simulator is a console-based application built in C# that allows users to simulate buying and selling stocks, viewing their balance, checking stock balances, and simulating price fluctuations. The program is designed to mimic a simplified stock trading environment.

## Classes:

### Stock
- Represents a stock with properties such as Symbol, CompanyName, Price, and Quantity.
- Allows updating stock price, buying, selling, and simulating price fluctuations.
- Methods:
    - `GetPrice()`: Retrieves the current price of the stock.
    - `UpdatePrice()`: Updates the price of the stock.
    - `Buy()`: Allows purchasing stocks if the user has enough balance.
    - `Sell()`: Enables selling stocks from the user's portfolio.
    - `SimulatePriceFluctuation()`: Simulates random fluctuations in the stock price.

### User
- Represents a user with a balance and a portfolio of stocks they own.
- Allows buying and selling stocks based on the user's balance.
- Methods:
    - `BuyStock()`: Handles the purchase of stocks and updates the user's balance and portfolio.
    - `SellStock()`: Manages the sale of stocks, updating the user's balance and portfolio accordingly.
    - `ViewStockBalance()`: Displays the user's current stock portfolio and their quantities.
    - `ViewBalance()`: Displays the user's current balance.

### Program
- Contains the main method to run the stock trading simulation.
- Provides a console-based interface for users to interact with the program.
- Allows users to perform actions like buying, selling, viewing balance, viewing stock balances, and simulating price changes for a stock.

## Program Execution Flow:

1. **Initialization:** The program initializes a User instance with a starting balance and a Stock instance representing a specific stock.
2. **Console Interface:** The program prompts the user for actions via the console, such as buying, selling, viewing balance, viewing stock balances, or simulating price changes.
3. **Action Execution:**
    - **Buy/Sell:** When the user chooses to buy or sell stocks, the program interacts with the User class to execute these actions based on the user's input.
    - **View Balance/Stock Balances:** The program displays the user's balance or their current stock portfolio by interacting with the User class.
    - **Simulate Price:** Simulates price fluctuations of a specific stock by interacting with the Stock class.

4. **Exit Condition:** The program continues to prompt for actions until the user inputs 'exit'.

The Stock Trading Simulator provides users with a basic platform to practice simulated stock trading, enabling them to buy, sell, and track stocks within their portfolio while considering their available balance.

# Overview

The Stock Trading Simulator is a project aimed at creating a simulated environment for users to engage in stock trading activities. It serves as a learning tool for both beginners and enthusiasts interested in understanding stock market dynamics and trading strategies without risking real money.

The software allows users to interact via a console-based interface, offering actions such as buying and selling stocks, viewing their balance, checking their stock portfolio, and simulating price fluctuations to experience various market scenarios.

## Software Demo Video
[Software Demo Video](http://youtube.link.goes.here) - A one-minute walkthrough demonstrating the software's functionalities and a code review.

# Development Environment

The software was developed using:
- **Tools**: Visual Studio IDE
- **Programming Language**: C#

# Useful Websites

Websites that were helpful during the development:
Certainly! Here are some useful resources for learning C#:

**Microsoft Documentation for C#:**
   - [Microsoft C# Guide](https://docs.microsoft.com/en-us/dotnet/csharp/)
   - [Microsoft Learn - C#](https://learn.microsoft.com/en-us/dotnet/csharp/)

**Interactive Exercises:**
   - [Exercism - C# Track](https://exercism.io/tracks/csharp)
   - [LeetCode - C# Problems](https://leetcode.com/problemset/all/?search=c%23)
