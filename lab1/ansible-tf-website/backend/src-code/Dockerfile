FROM python:3.13

# Set working directory
WORKDIR /app

# Copy the application code
COPY app.py /app/

# Install dependencies
RUN pip install flask opentelemetry-exporter-prometheus

# Expose Flask and Prometheus ports
EXPOSE 8080 9464

# Run the application
CMD ["python", "app.py"]
