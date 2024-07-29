FROM node:lts-slim AS deps
WORKDIR /app
RUN npm install -g pnpm
COPY package*.json pnpm-lock.yaml yarn.lock ./
RUN pnpm i --frozen-lockfile

FROM node:lts-slim AS builder
WORKDIR /app
RUN npm install -g pnpm
COPY . .
COPY --from=deps /app/node_modules ./node_modules
RUN pnpm run build
RUN pnpm prune --production

FROM node:lts-slim AS runner
RUN npm install -g pnpm
WORKDIR /app
ENV NODE_ENV production
ENV MODELS_HOST=localhost
COPY --from=builder --chown=node:node /app/build build/
COPY --from=builder --chown=node:node /app/node_modules node_modules/

USER node:node
EXPOSE 3000 4173

CMD ["pnpm", "run", "preview"]