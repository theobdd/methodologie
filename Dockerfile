
FROM php:alpine AS base
WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt



FROM base AS dev
CMD ["mkdocs", "serve", "-a", "0.0.0.0:8000"]

FROM base AS build
COPY . .
RUN mkdocs build

FROM nginx:alpine
COPY --from=app-zip-creator /app.zip /usr/share/nginx/html/assets/app.zip
COPY --from=build /app/site /usr/share/nginx/html
