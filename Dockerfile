FROM node:22-alpine AS frontend-build
WORKDIR /app/frontend
COPY frontend/package*.json ./
RUN npm ci
COPY frontend/ ./
RUN npm run build

FROM python:3.13-slim
WORKDIR /app

COPY requirements-app.txt ./
RUN pip install --no-cache-dir -r requirements-app.txt

COPY backend/ ./backend/
COPY Financial_Dataset/ ./Financial_Dataset/
COPY --from=frontend-build /app/backend/static/react/ ./backend/static/react/

EXPOSE 8000
CMD ["uvicorn", "backend.main:app", "--host", "0.0.0.0", "--port", "8000"]
