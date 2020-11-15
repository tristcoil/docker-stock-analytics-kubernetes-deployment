FROM python:3.7.3-stretch

## Step 1:
# Create a working directory
WORKDIR /app


## Step 2:
# Copy source code to working directory
COPY . app.py /app/


## Step 3:
# Install packages from requirements.txt
# it sees requirements.txt file in build dir
# no need to copy to docker image
# ignore line has to be exactly above line causing issues

# hadolint ignore=DL3013
RUN pip install --upgrade pip &&\
    pip install -r requirements.txt


## Step 4:
# Expose port 80, 8000
EXPOSE 80
EXPOSE 8000


## Step 5:
# Run app.py at container launch
CMD ["python", "app.py"]


