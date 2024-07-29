FROM node:20.16.0-alpine3.20 AS builder

ARG VITE_DIRECTUS_URL=${VITE_DIRECTUS_URL}
ENV VITE_DIRECTUS_URL=${VITE_DIRECTUS_URL}
ARG DIRECTUS_STATIC_TOKEN=${DIRECTUS_STATIC_TOKEN}
ENV DIRECTUS_STATIC_TOKEN=${DIRECTUS_STATIC_TOKEN}
ARG PUBLIC_DIRECTUS_URL=${PUBLIC_DIRECTUS_URL}
ENV PUBLIC_DIRECTUS_URL=${PUBLIC_DIRECTUS_URL}

WORKDIR /app
COPY package*.json .
RUN npm ci
COPY . .
RUN npm run build
RUN npm prune --production

FROM node:20.16.0-alpine3.20
WORKDIR /app
COPY --from=builder /app/build build/
COPY --from=builder /app/node_modules node_modules/
COPY package.json .
EXPOSE 3000
ENV NODE_ENV=production
CMD [ "node", "build" ]