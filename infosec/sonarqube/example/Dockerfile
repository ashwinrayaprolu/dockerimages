FROM python:3.8.2

ENV FLASK_APP=flaskr
ENV FLASK_ENV=development

COPY . /app

WORKDIR /app

RUN pip install --editable .

RUN flask init-db

RUN pylint --exit-zero --reports=n --load-plugins pylint_flask flaskr

# Unit tests
# RUN pip install pytest && pytest

EXPOSE 5000

CMD [ "flask", "run", "--host=0.0.0.0" ]



