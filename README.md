# BlackyBounty System

A simple **Bounty Hunter** system for **QBcore** servers in **FiveM**. This system allows players to create and accept bounties on other players, with rewards for those who successfully complete them.

The system supports both **MySQL** and **File-based (JSON)** storage, allowing users with or without MySQL databases to use the script.

## Features
- Create bounties on other players.
- List all active bounties.
- Accept bounties to hunt down players.
- Support for both **MySQL** and **File-based storage**.

## Installation

1. **Clone or Download the Repository**:
   - Clone the repository into your `resources` folder or download the ZIP and extract it.

2. **Add the Resource to `server.cfg`**:
   Add the following line to your `server.cfg` to start the resource:
   ```txt
   start blackybountysystem


## MySQL Setup (For MySQL Users)

If you're using MySQL for storage, follow these steps to set it up:

1. **Install `mysql-async`**:
   - Download and install the `mysql-async` resource from [this GitHub page](https://github.com/brouznouf/fivem-mysql-async).
   - Ensure that you have a MySQL database set up for your server. If you don't have MySQL installed, you can download it from [here](https://dev.mysql.com/downloads/installer/).

2. **Configure MySQL Connection in `server.cfg`**:
   Open your `server.cfg` file and add the following line to configure the connection to your MySQL database:
   ```txt
   set mysql_connection_string "mysql://username:password@localhost/database_name"

Replace username with your MySQL username.
Replace password with your MySQL password.
Replace localhost with the host of your MySQL database (use localhost if it’s on the same server).
Replace database_name with the name of your database where you want to store the bounties.



Create the MySQL Table: To store the bounties in your MySQL database, you need to create the bounties table. You can do this by running the following SQL query in your MySQL client (e.g., MySQL Workbench or phpMyAdmin):

CREATE TABLE IF NOT EXISTS bounties (
    id INT AUTO_INCREMENT PRIMARY KEY,
    target_name VARCHAR(255) NOT NULL,
    target_id INT NOT NULL,
    reward INT NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at DATETIME NOT NULL,
    hunter_id INT DEFAULT NULL,
    hunter_name VARCHAR(255) DEFAULT NULL
);

id: A unique ID for each bounty.
target_name: The name of the target player.
target_id: The ID of the target player.
reward: The reward offered for completing the bounty.
status: The status of the bounty (e.g., "Active", "Completed").
created_at: The timestamp when the bounty was created.
hunter_id: The ID of the player who accepts the bounty (if applicable).
hunter_name: The name of the player who accepts the bounty (if applicable).



**If you are NOT using MySQL, the system will fall back to using a local JSON file (bounties.json) for storing bounties. You don’t need to worry about setting up MySQL in that case.**
