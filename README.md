# tanX - Commodity Rental Solution
## Problem Statement

A prototype of a **“Commodity Rental Solution”** needs to be developed. On this product, users can sign up as lenders or renters. A lender can list a commodity (e.g., a blazer, shoes, laptop) for rent and quote a minimum monthly charge for renting the commodity. A renter can put a bid for the available commodities on the product. A bid window is open for 3 hours since the time a lender lists a product. At the end of 3 hours, the system determines one of the bids to be the best bid among available ones and marks the commodity as listed for that bid (details below).

## Constraints

1. A lender can list multiple commodities available for rent.
2. From the time of listing the commodity, renters can place bids to rent out the commodity for the next 3 hours.
3. There are 2 strategies for deciding the best bid, one of which the lender must specify when listing the commodity for renting:
    1. **Strategy 1**: Highest per month price wins.
    2. **Strategy 2**: Highest overall price (per month price * lease period) wins.
4. At the end of the 3-hour window, the system will assign the best bid (according to the strategy chosen by the lender) out of the available ones to the commodity listing. If there are no bids, the listing will be cancelled. The lender can then re-list the commodity if they wish.
5. A renter cannot place a bid for an amount lesser than the minimum amount quoted by the lender.
6. A lender cannot place bids on commodities from other lenders.
7. A renter cannot list commodities for renting.
8. A renter cannot place a bid on a commodity that has already been rented out.
9. Available item categories (this can be extended if deemed meaningful):
    1. **Electronic Appliances**
    2. **Electronic Accessories**
    3. **Furniture**
    4. **Men’s wear**
    5. **Women’s wear**
    6. **Shoes**
10. Once the lease period for a rented-out commodity is over, the lender can choose to relist the commodity. Unless the lender manually re-lists the commodity, new bids cannot be made on the commodity. The lender can also choose to update the quote price of the commodity as per his or her liking.
11. A lender cannot try to re-list an item which is currently rented out. However, they can relist the item and change its quote price anytime they please if the item is not rented out.
12. A renter can update the bid for an item as long as the item is still available.

## Setup Instructions

### Prerequisites

- **Ruby**: 3.3.4
- **Rails**: 7.2.1
- **Database**: PostgreSQL
- **Redis**

### Installation Steps

1. Clone the repository:

    ```
    git clone https://github.com/Shivareddy-Aluri/commodity-rental.git
    cd commodity-rental
    ```

2. Install the required gems:

    ```
    bundle install
    ```

3. Set up the database:

    ```
    rails db:create
    rails db:migrate
    ```

4. Start the Rails server:

    ```
    rails s
    ```
5. Start Redis:

    ```
   brew services start redis
    ```

6. Start Sidekiq Server

    ```
    bundle exec sidekiq
    ```

7. Visit `http://localhost:3000` to view the application.

8. Visit `http://localhost:3000/sidekiq` to view Sidekiq UI

## Setup with Docker

1. Clone the Repository

```
git clone https://github.com/your-username/commodity-rental.git
cd commodity-rental
```

2. Build and Start the Application Containers

```
docker-compose up --build
```

3. View containers

```
docker ps
```

4. Running Database Migrations

```
docker exec -it <app-container-name> bash
bin/rails db:migrate
```

5. Accessing the Application

```
http://localhost:3000
```

6. Viewing Application Logs

```
docker logs -f <container-name>

```

7. Kill the application

```
docker-compose down
```

## Postman collection
   
[<img src="https://run.pstmn.io/button.svg" alt="Run In Postman" style="width: 128px; height: 32px;">](https://app.getpostman.com/run-collection/15937086-b69e78d4-16a3-44a6-a653-2479f53f61c1?action=collection%2Ffork&source=rip_markdown&collection-url=entityId%3D15937086-b69e78d4-16a3-44a6-a653-2479f53f61c1%26entityType%3Dcollection%26workspaceId%3Dc729701f-dd3d-4478-92dd-7c9c87dc3316)

1. steps get the secret

    ```
    rails c
    Rails.application.credentials.secret_key_base
    ```

2. payload to build JWT token

    ```
    {
        "user_id": 2
    }
    ```

### Database Schema Design

<img width="1196" alt="Screenshot 2024-09-22 at 7 22 44 PM" src="https://github.com/user-attachments/assets/0bf4b6b6-c294-4b19-8ee9-c4e6f41a51ff">



## Note [Not so perfect still WIP, This an API only app. dockerization i tested with podman(as there are restrictions on my mac😅) should work with docker desktop as well]
