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

## API Reference

#### Login

```http
  POST /login
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `username` | `string` | **Required** |
| `password` | `string` | **Required** |

#### Register

```http
  POST /register
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `email`      | `string` | **Required** |
| `username`| `string` | **Required** |
| `password` | `string` | **Required** |

#### Blog (List)

```http
  GET /api/v1/blog
```

#### Blog (Detail)

```http
  GET /api/v1/blog/1
```

#### Blog (create)
```http
  POST /api/v1/blog
```
| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `title`   | `string` | **Required** |
| `body`    | `string` | **Required** |

##### Body Example
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
  PATCH /api/v1/blog/1
```
| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `title`   | `string` | **Optional** |
| `body`    | `string` | **Optional** |

##### Body Example
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