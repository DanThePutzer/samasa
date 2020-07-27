FROM python:3.7.3-stretch

# Creating working directory
WORKDIR /app

# Copying application files to working directory
COPY . app.py /app/

# Installing python dependencies
RUN pip install --upgrage pip && \
    pip install -r requirements.txt

# Exposing port 80 for outside access
EXPOSE 80

# Running application at container launch
CMD ["python", "app.py"]