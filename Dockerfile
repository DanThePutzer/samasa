FROM python:3.7.3-stretch

# Creating working directory
WORKDIR /application

# Copying application files to working directory
COPY . app.py /application/

# Installing python dependencies
# hadolint ignore=DL3013
RUN pip install -U pip &&\
    pip install -r requirements.txt

# Exposing port 80 for outside access
EXPOSE 80

# Running application at container launch
CMD ["python", "app.py"]