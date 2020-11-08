# EXERCISE LOLA MARKET

## Considerations

* I made the decision to create a table that relates the orders with the products associated with each product in order to have of a structure that allows no dependencies in this relationship.


* One of the requested points in the exercise is to create a method that must return the orders associated with the shopper and the supermarket. I made the decision to create a relationship between a shopper and the shop, and this implies that in the method I implemented to obtain this data it is not needed to provide the supermarket identifier, only a shopper identifier is needed to obtain the desired results. This decission was taken because the exposed model is jus an exemple model, obviously in a real environment this consideration would not be valid.


## Run the example

### How to run the project

* You will need to have `docker-compose` installed on your system. 

* Get to the project path and execute:

```bash
docker-compose up
```

### How to create an order

* Use the Postman collection located in `/resources` folder.

* You have to make a POST request 

  'http://localhost:8001/order/create'

  with a payload structure like this:

```json
  {
    "purchase_date": "2020-11-25 10:01:43",
    "delivery_date": "2020-11-26 11:15:25",
    "interval_delivery": "10:00-13:00",
    "address": "Test street",
    "amount": 0,
    "completed": false,
    "client_id_id": 3,
    "address": "Test address",
    "products": {
      "product1": {
        "shop_id": 299,
        "name": "Product 000",
        "description": "description 000",
        "units": 5,
        "price": 23.45
      },
      "product2": {
        "shop_id": 2,
        "name": "Product QWERTY",
        "description": "description QWERTY",
        "units": 1,
        "price": 3.45
      },
      "product3": {
        "shop_id": 299,
        "name": "Product 77",
        "description": "description 77",
        "units": 1,
        "price": 1.23
      },
      "product4": {
        "shop_id": 1,
        "name": "Product 876",
        "description": "description 876",
        "units": 9,
        "price": 7.87
      },
      "product5": {
        "shop_id": 1,
        "name": "Product 231",
        "description": "description 231",
        "units": 1,
        "price": 0.45
      }
    }
  }
```


### Order dispatching

* Use the Postman collection located in `/resources` folder.

* You have to make a POST request 

  'http://localhost:8001/shopper/orders'

  with a payload structure like this:

```json
{
  "shopper_id": 2
}
```

## Database

### Connect to MySQL container

```bash
mysql -h127.0.0.1 -uroot_bsc -proot_bsc -Dexercise_lm -P3311
```


### Model

An index is created for each relationship field between tables

1. Client 
    1. Primary (id)
2. Order 
    1. Primary (id)
    2. IDX_F5299398DC2902E0 (client_id_id)
3. Order_detail 
    1. Primary (id)
    2. IDX_ED896F464584665A (product_id) (Product table)
    3. IDX_ED896F461252C1E9 (parent_order_id) (Order tableº)
4. Product
    1. Primary (id)
    2. IDX_D34A04AD4D16C4DD (shop_id) (Shop table)
5. Shop
    1. Primary (id)
6. Shopper
    1. Primary (id)
    2. FK_26663F5D4D16C4DD (shop_id) (Shop table)


### Database diagram

![Database diagram model](https://github.com/josedelrio85/exercise_lm/blob/master/resources/exercise_lm_diagram.png?raw=true)


