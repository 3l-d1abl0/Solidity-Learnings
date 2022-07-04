## Smart Contract for Fund Raising

The idea is to raise Funds for a recipient.

### Features :

- The admin can start a Campaign for funraising for a particular recipient with an amount at the target with a specific Deadline.

- Contibuters can fund the Campaign by sending ethers

- A Spending request can be created by the Admin once the Goal Amount is reached.

- The Contributers can withdraw their request their ether if the required Goal Amount was not achieved within the Deadline.

- The contributors vote for the Spending request

- If more than 50% of the voters vote for Spending Request then the admin has permisssion to use the Amount as per the Spending Request.



### Installation:

```
    npm install

    node compile.js (uses solc)
```

