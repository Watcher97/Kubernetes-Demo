#set the base image to create the image for react app
FROM node:20-alpine As base


#set the working directory to /app
WORKDIR /app

#copy package.json and package-lock.json to the working directory
#This is done before copying the rest of the files to take advantage of docker layer caching
#If the package.json and package-lock.json files have not changed, docker will use the cached layer for npm install

COPY package*.json ./

#install the dependencies
RUN npm ci --omit=dev

#copy the rest of the files to the worlking directory
COPY . .

#expose port 3000 to tell docker that the container listens on this port at runtime
EXPOSE 3000

#environment variable to set the node environment to production
ENV NODE_ENV=production

#command to run the app
CMD [ "npm", "run", "dev", "--", "--host", "0.0.0.0" ]