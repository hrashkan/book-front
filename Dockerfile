# build
FROM node:20.10.0-alpine3.19 AS builder

WORKDIR /app

COPY package*.json ./

ENV PORT=80

RUN npm ci

COPY . .

RUN npm run build:prod

# runner
FROM node:20.10.0-alpine3.19 AS runner

ENV PORT=80

WORKDIR /app

COPY --from=builder /app/package*.json ./
COPY --from=builder /app/.next/standalone .next/standalone/

EXPOSE 80
