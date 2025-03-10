# BlackyBounty System

A simple **Bounty Hunter** system for **QBcore** servers in **FiveM**. This system allows players to create and accept bounties on other players, with rewards for those who successfully complete them.

The system supports both **MySQL** and **File-based (JSON)** storage, allowing users with or without MySQL databases to use the script.

## Features
- Create bounties on other players.
- List all active bounties.
- Accept bounties to hunt down players.
- Support for both **MySQL** and **File-based storage**.

## Commands

Here is a list of commands you can use to interact with the **Bounty Hunter System** in your server:

1. **Creating a Bounty**
   - **Command**: `/createbounty [player_name] [reward]`
   - **Description**: This command allows you to create a bounty on another player.
   - **Example**: 
     ```
     /createbounty JohnDoe 5000
     ```
     This will create a bounty on the player **JohnDoe** with a reward of **5000**.

2. **Listing Active Bounties**
   - **Command**: `/listbounties`
   - **Description**: This command displays a list of all active bounties currently available in the system.
   - **Example**: 
     ```
     /listbounties
     ```

3. **Accepting a Bounty**
   - **Command**: `/acceptbounty [bounty_id]`
   - **Description**: Use this command to accept a bounty that is currently active. You will be tasked with hunting down the target player and completing the bounty.
   - **Example**: 
     ```
     /acceptbounty 1
     ```
     This will accept the bounty with **ID 1**.

4. **Completing a Bounty**
   - **Command**: `/completebounty [bounty_id]`
   - **Description**: Once you have completed the bounty by hunting down and defeating the target, use this command to mark the bounty as complete and claim your reward.
   - **Example**: 
     ```
     /completebounty 1
     ```
     This will mark the bounty with **ID 1** as completed and award you the reward.

5. **Viewing Your Active Bounties**
   - **Command**: `/mybounties`
   - **Description**: This command allows you to view a list of all bounties you have either created or accepted.
   - **Example**:
     ```
     /mybounties
     ```

6. **Cancelling a Bounty**
   - **Command**: `/cancelbounty [bounty_id]`
   - **Description**: If you created a bounty and want to cancel it before someone accepts, use this command.
   - **Example**:
     ```
     /cancelbounty 1
     ```

These commands will help you interact with the Bounty Hunter System, allowing players to create bounties, accept them, complete them, and track their progress easily.


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



3. **Create the MySQL Table**:
   To store the bounties in your MySQL database, you need to create the `bounties` table. You can do this by running the following SQL query in your MySQL client (e.g., MySQL Workbench or phpMyAdmin):
   ```sql
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

**If you are NOT using MySQL, the system will fall back to using a local JSON file (bounties.json) for storing bounties. You don’t need to worry about setting up MySQL in that case.**


## License

This project is licensed under the **MIT License** - see the [LICENSE](LICENSE) file for details.

