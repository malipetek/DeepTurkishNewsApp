FROM node:20.16.0-alpine3.20

ARG VITE_DIRECTUS_URL=${VITE_DIRECTUS_URL}
ENV VITE_DIRECTUS_URL=${VITE_DIRECTUS_URL}
ARG DIRECTUS_STATIC_TOKEN=${DIRECTUS_STATIC_TOKEN}
ENV DIRECTUS_STATIC_TOKEN=${DIRECTUS_STATIC_TOKEN}
ARG PUBLIC_DIRECTUS_URL=${PUBLIC_DIRECTUS_URL}
ENV PUBLIC_DIRECTUS_URL=${PUBLIC_DIRECTUS_URL}

WORKDIR /app

COPY package.json yarn.lock ./

# Install dependencies using Yarn
RUN yarn install --frozen-lockfile

COPY . .

# Build the project and remove unnecessary dependencies
RUN yarn build && yarn install --production

ENV PORT 80
EXPOSE 80

CMD ["ls", "-la", "&&", "node", "build/index.js"]