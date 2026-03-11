FROM node:18-slim
RUN apt-get update && apt-get install -y nginx && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /run/nginx

WORKDIR /app/vod
COPY vod/package*.json ./
RUN npm install
COPY vod/ .

# Nginx 把 7860 转发到原项目的端口（可能是 3000 或其他）
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 7860
CMD sh -c "node index.js & nginx -g 'daemon off;'"
