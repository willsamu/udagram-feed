# Use NodeJS base image
FROM node:13

# Arguments required on build time
ARG POSTGRES_USERNAME
ARG POSTGRES_PASSWORD
ARG POSTGRES_HOST
ARG POSTGRES_DB
ARG AWS_BUCKET
ARG AWS_REGION
ARG AWS_PROFILE
ARG JWT_SECRET
ARG URL
ARG PORT_UDAGRAM_FEED

# Forge input arguments into permanent env variables
ENV POSTGRES_USERNAME=${POSTGRES_USERNAME}
ENV POSTGRES_PASSWORD=${POSTGRES_PASSWORD}
ENV POSTGRES_HOST=${POSTGRES_HOST}
ENV POSTGRES_DB=${POSTGRES_DB}
ENV AWS_BUCKET=${AWS_BUCKET}
ENV AWS_REGION=${AWS_REGION}
ENV AWS_PROFILE=${AWS_PROFILE}
ENV JWT_SECRET=${JWT_SECRET}
ENV URL=${URL}
ENV PORT_UDAGRAM_FEED=${PORT_UDAGRAM_FEED}

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies by copying
# package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy app source
COPY . .

# Compile production version
RUN npm run prod

# Bind the port that the image will run on
EXPOSE 2311

# Define the Docker image's behavior at runtime
CMD ["node", "./www/server.js"]