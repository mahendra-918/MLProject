FROM python:3.8-slim-bullseye

WORKDIR /app

COPY . /app

# 1. Install System Dependencies
# 'build-essential' gives you gcc/g++ compilers
# 'libgomp1' is required specifically for XGBoost/CatBoost to work
RUN apt-get update -y && \
    apt-get install -y awscli build-essential libgomp1 && \
    apt-get clean

# 2. Upgrade pip to ensure you get the latest compatible wheels
RUN pip install --upgrade pip

# 3. Clean requirements (Optional but Safe):
# This removes "-e ." from requirements.txt temporarily for the build
# to prevent setup.py errors.
RUN sed -i '/-e ./d' requirements.txt

# 4. Install requirements
RUN pip install -r requirements.txt

CMD [ "python3", "application.py" ]