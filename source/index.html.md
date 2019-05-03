---
title: API Reference

language_tabs: # must be one of https://git.io/vQNgJ
  # - shell
  # - ruby
  # - python
  # - javascript

toc_footers:
  - <a href='https://www.instabuy.com.br'>Build with Love by Instabuy</a>

includes:
  # - kittens
  # - errors

search: true
---

# Introduction

Welcome to Instabuy's **REST** Client API. This API allows you to provide functions and data to yout e-commerce website/app, like products, categories, carts, buys, etc.

<aside class="warning">This documentation is in construction. If you find any error or have doubts, please mail me at cayke@instabuy.com.br</aside>

## URLs

For development purpose you should use [http://dev.api.instabuy.com.br/apiv3](http://dev.api.instabuy.com.br/apiv3).

For production purpose you should use [https://api.instabuy.com.br/apiv3](https://api.instabuy.com.br/apiv3).

## Request/Response Format

The default response format is **JSON**. Requests with a message-body use plain JSON to set or update resource attributes. Successful requests will return a `200 OK` HTTP status.

Some general information about responses:

- Dates are returned in ISO8601 format: `YYYY-MM-DDTHH:MM:SS`
- Any decimal monetary amount, such as prices or totals, will be returned as numbers with two decimal places.
- Other amounts, such as item counts, are returned as integers.
- Blank/Null fields are generally omitted.

### Response Format

All server's response have 4 fields in it: `status`, `data`, `count`, `http_status`.

#### Status

The status fields returns either `"sucess"` or `"error"`. Success is send when the operation made by the request went well all the way. Error is passed when the expected result was not reached during the process.

#### Data

The info itself. Here it could be an error message, if status is error, or list, object, string, etc if status is success.

#### Count

The number of objects the query should return if no pagination/filter were applied.

#### HTTP Status

The response's HTTP Status.

## Errors
Occasionally you might encounter errors when accessing the REST API. Below are the possible types:

Error Code | Error Type
-------------- | --------------
`211 Unauthorized` | You are trying to access a protected endpoint but dont have permission / aren't logged.
`212 User Blocked` | You were blocked from the system.
`213 Not Found` | Query didn't return results.
`214 Expected Error` | Expected Error, e.g.: system could not save item because slug is not unique.
`218 Reload Cart` | One or more items on the user's cart had stock or price changed, please get cart again.
`400 Bad Request` | Invalid request, e.g. using an unsupported HTTP method
`404 Not Found` | Requests to resources that don't exist or are missing
`405 Method Not Allowed` | You tried to access a endpoint with an invalid method.
`500 Internal Server Error` | Server error


## Pagination
Requests that return multiple items will be paginated to 12/25 items by default. This default can be changed specifing the `?N` parameter:

`GET /buys?N=15`

You can specify further pages with the `?page` parameter:

`GET /buys?page=2`

You can use both parameters as well:

`GET /buys?page=5&N=15`

Page number is `1-based` and omitting the `?page` parameter will return the first page.

The total number of resources are included in the response `count` field.

## Store Identification
To identify your store and get your infos correctly you should pass a store identifier on each request. You must pass one of the following fields: `store_id`, `subdomain` or `custom_domain`. Theses values cant be passed either via url argument or in request body.

E.g: To get the categories menu of a store you should implement one of the tree examples above:

`GET /menu?store_id=5a4d173b94e42937b3a6563a`

`GET /menu?subdomain=bigboxdelivery`

`GET /menu?custom_domain=bigboxdelivery.com.br`

## Images
All fields that represent images have only the image Identifier and not the image URL.
<!-- todo -->

# Authentication

The Authentication in Instabuy's API is made using **COOKIES**. Therefore, to log in and access protected endpoints you must have cookies enabled on your browser/app.

# Cart
The cart API allow you to add and retrieve products from the cart attached to the actual user identified by Cookies..

## Cart properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`products` | array |	Products data. See [Product properties](/#items-properties).
`kits` | array | Products Kit data. See [Products Kit properties](/#items-properties).

### Cart - ProductsKitBundle properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`bundle_id` | string |	ProductsKitBundle Id.
`products` | array | ProductsKitBundleProduct data. See [ProductsKitBundleProduct properties](/#cart-productskitbundleproduct-properties).

### Cart - ProductsKitBundleProduct properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`product_id` | string |	ProductsKitBundleProduct Id.
`qtd` | integer | Product quantity.

## Retrieve a cart
This API returns the cart.

### HTTP Request
`GET /cart`

## Add product to cart
This API adds a product to cart.

### HTTP Request
`POST /cart`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`product_id` | string | required | Product Id.
`model_id` | string | required | Product's price Id.
`qtd` | float | required| Quantity to be added to cart.
`attachment` | string | optional | Attach a 'comment' to the product.

## Add products kit to cart
This API adds a products kit to cart.

### HTTP Request
`POST /cart`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`kit_id` | string | required | Products Kit Id.
`kit_cart_id`| string | optional | Products Kit Cart Id.
`qtd` | float | required| Quantity to be added to cart.
`attachment` | string | optional | Attach a 'comment' to the product.
`bundles` | array | required | CartProductsKitBundle data. See [CartProductsKitBundle properties](/#cart-productskitbundle-properties).

## Add items from buy to cart
This API adds all items from a previously made buy to cart.

### HTTP Request
`POST /cart`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`buy_id` | string | required | Buy Id.


## Clean a cart
This API removes all items from cart.

### HTTP Request
`DELETE /cart`

# Freight
The freight API allow you to get possible freight values for zipcode.

## Freight properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`delivery` | object |	Products data. See [Delivery properties](/#freight-delivery-properties).
`correios` | object | Products Kit data. See [Correios properties](/#freight-correios-properties).

### Freight - Delivery properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`freight` | float |	Freight value.
`free_above` | float | If buy value is higher than `free_above`, freight become free for the client.

### Freight - Correios properties
Attribute | Type | Description
-------------- | -------------- | -------------- 
`pac_price` | float |	Freight value using PAC.
`pac_max_deadline` | integer | PAC Delivery time (in days).
`sedex_price` | float |	Freight value using SEDEX.
`sedex_max_deadline` | integer | SEDEX Delivery time (in days).

<aside class="notice">
If the store doesn't delivers to the zipcode passed, the request field <code>data</code> will be equal <code>false</code>.
</aside>

## Retrieve freight
This API returns the freight value for zipcode.

### HTTP Request
`GET /hasdelivery`

#### Available parameters
Parameter | Type | Constraint | Description
-------------- | --------------  | -------------- | -------------- 
`code` | string | required | Delivery address zipcode


# Items
The items API allows you to list items(products and products kits) from a store.

## Items properties

Attribute | Type | Description
-------------- | -------------- | -------------- 
`id` | string |	Unique identifier for the resource.
`creator` | string | Who or what created the resource.
`created_at` | datetime | The date the resource was created, as GMT.
`last_modified` | datetime | The date the resource was last modified, as GMT.
<!-- todo -->

## List items
This API helps you to view all the items.

### HTTP Request
`GET /item`

#### Available parameters
Parameter | Type | Description
-------------- | -------------- | -------------- 
`product_id` | string | Get Product with Id
`kit_id` | string | Get Products Kit with Id
`slug` | string | Get Item with slug
`subcategory_id` | string | Get Items from Subcategory
`category_id` | string | Get Items from Category
`category_slug` | string | Get Items from Category
`min_price` | float | Get Items with min price higher than `min_price`.
`max_price` | float | Get Items with min price lower than `max_price`.
`custom_info_{custom_info_id}` | string | The possible values for this should use `!$` separator. E.g.: `custom_info_5b929009017ce27d51863b52=1,5%20l!$750%20ml`
`sort` | string |	Sort collection by object attribute. Options: `nameaz`, `nameza`, `pricemin`, `pricemax`, `top_sellers` and `recents`. Default is `recents`.
<!-- todo item_code -->

# Search
The items API allows you to list items(products and products kits) based on a search text that will consider items name and description or a search by barcode.

### HTTP Request
`GET /search`

#### Available parameters
Parameter | Type | Description
-------------- | -------------- | -------------- 
`search` | string | Search for items with name or description containing `search` text.
`search_code` | string | Search for item that contains barcode or PLU equal `search_code`.
