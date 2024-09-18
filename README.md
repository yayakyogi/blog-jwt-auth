# CRUD API Blog With JWT Auth

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Set database configuration (using postgresql)
    ```
    username: "postgre_username",
    password: "postgre_password",
    hostname: "localhost",
    database: "database_name",
    ```
  * Run `mix ecto.migrate` to run migration database
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Public API Reference

#### Login

```http
  POST /login
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `username` | `string` | **Required** |
| `password` | `string` | **Required** |

##### Body Raw
```javascript
{
  "username": "your username",
  "password": "your password"
}
```

#### Register

```http
  POST /register
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `email`      | `string` | **Required** |
| `username`| `string` | **Required** |
| `password` | `string` | **Required** |

##### Body Raw
```javascript
{
  "email" : "your email",
  "username": "your username",
  "password": "your password"
}
```

#### Blog (List)

```http
  GET /blog
```

#### Blog (Detail)

```http
  GET /blog/1
```

## Auth API Reference

#### Headers
```javascript
{"Authorization" : "Bearer token"}
```

#### Blog (create)
```http
  POST /api/v1/blog
```
| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `title`   | `string` | **Required** |
| `body`    | `string` | **Required** |

##### Body Raw
```javascript
{
  "post": {
    "title": "your title here",
    "body": "your body here"
  }
}
```

#### Blog (update)
```http
  PUT /api/v1/blog/1
```
| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `title`   | `string` | **Required** |
| `body`    | `string` | **Required** |

##### Body Raw
```javascript
{
  "post": {
    "title": "your title here",
    "body": "your body here"
  }
}
```

#### Blog (Delete)

```http
  DELETE /api/v1/blog/1
```