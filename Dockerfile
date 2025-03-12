# Use a base image with Java pre-installed
FROM openjdk:11-jdk-slim

# Set a working directory
WORKDIR /app

# Install Python and system dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    procps\
    && apt-get clean

# Install Python libraries for PySpark and Jupyter
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

# Expose port for Jupyter Notebook
EXPOSE 8888

# Expose port for Spark UI
EXPOSE 4041

# Set JAVA Environment for partitioning
ENV SPARK_JAVA_OPTS="-Xms4g -Xmx8g"

# Default command to run Jupyter Notebook
CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

# docker build -t home-sales .

# docker run -p 8888:8888 -p 4041:4041 home-sales

# Setup memory usage limits
# docker run --memory="8g" --memory-swap="8g" your_image_name

