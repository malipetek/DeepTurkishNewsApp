

FROM node:20.16.0-alpine3.20 AS builder

ARG VITE_DIRECTUS_URL=${VITE_DIRECTUS_URL}
ENV VITE_DIRECTUS_URL=${VITE_DIRECTUS_URL}
ARG DIRECTUS_STATIC_TOKEN=${DIRECTUS_STATIC_TOKEN}
ENV DIRECTUS_STATIC_TOKEN=${DIRECTUS_STATIC_TOKEN}
ARG PUBLIC_DIRECTUS_URL=${PUBLIC_DIRECTUS_URL}
ENV PUBLIC_DIRECTUS_URL=${PUBLIC_DIRECTUS_URL}
# Use an Alpine image with Node.js installed for building the SvelteKit app
WORKDIR /app
# Copy only package files to leverage Docker cache
COPY package.json yarn.lock ./
# Install dependencies using Yarn
RUN yarn install --frozen-lockfile
# Copy the rest of the application code
COPY . .
# Build the application
RUN yarn build
# Remove development dependencies to keep the image size down
RUN yarn autoclean --force --only="production"

# Start a new stage for the production environment
FROM node:20.16.0-alpine3.20
WORKDIR /app
# Copy built assets and necessary modules from the builder stage
COPY --from=builder /app/.svelte-kit build/
COPY --from=builder /app/node_modules node_modules/
# Expose port 3000 for the web server
EXPOSE 3000
# Set the environment variable to indicate production mode
ENV NODE_ENV=production
# Command to start the application
CMD ["node", "build"]
