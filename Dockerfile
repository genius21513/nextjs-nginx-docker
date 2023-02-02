# Base on offical Node.js Alpine image
FROM node:16-alpine

# Must install git(or libc6-compat)
RUN apk add --no-cache git

# Set working directory
WORKDIR /usr/app

# Install PM2 globally
# RUN npm install --global pm2
RUN yarn global add pm2

# Copy package.json and package-lock.json before other files
# Utilise Docker cache to save re-installing dependencies if unchanged
# COPY ./package*.json ./
COPY ./package.json yarn.lock ./

# Install dependencies
# RUN npm install --production --omit=dev
# RUN yarn install --production --frozen-lockfile
RUN yarn install

# Copy all files
COPY ./ ./

# Build app
# RUN npm run build
RUN yarn build

# Expose the listening port
EXPOSE 3000

# Run container as non-root (unprivileged) user
# The node user is provided in the Node.js Alpine base image
# USER node

# Run npm start script with PM2 when container starts
# CMD [ "pm2-runtime", "npm", "--", "start" ]
CMD [ "pm2-runtime", "start", "yarn start" ]