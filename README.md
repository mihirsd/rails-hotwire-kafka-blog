# Rails Hotwire Kafka Blog

A Rails 8 blog application with Hotwire and Kafka integration.

## Development with Docker

```bash
# Start services
docker-compose up

# Stop services
docker-compose down

# Rails console
docker-compose exec web bin/rails console

# View logs
docker-compose logs -f web
```

## Local Development

```bash
bin/setup
bin/dev
```

App runs on `http://localhost:3000`
