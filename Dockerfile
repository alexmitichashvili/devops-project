FROM python:3.11-slim 

WORKDIR /app 

# Installing dependencies 
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt 

COPY app/ app/ 

# Listen on all interfaces so the app is reachale from the container
ENV HOST=0.0.0.0 
ENV PORT=8000
EXPOSE 8000

# Command executed when the container starts 
CMD ["python", "-m", "app.main"]