# Nginx image as the base
FROM nginx:alpine

# Copy your Tic Tac Toe game files to the Nginx web server directory
COPY . /usr/share/nginx/html

# Expose port 80 to real world
EXPOSE 80
