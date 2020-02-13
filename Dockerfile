#Base image and alias stage
FROM node:alpine as builder
#specify working directory in container
WORKDIR '/app'
#copy package.json so npm install has dependencies
COPY package.json .
#grab all dependencies
RUN npm install 
#copy over files to build
COPY . .
#Build prod app
RUN npm run build

#Start Final prod container
FROM nginx
#Copy build folder into new image (nginx static folder)
COPY --from=builder /app/build /usr/share/nginx/html
