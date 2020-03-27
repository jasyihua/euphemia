ARG BUILD_ENV=development

FROM python:3.7-alpine as base
ARG PROJECT_NAME=euphemia
ENV PROJECT_NAME ${PROJECT_NAME}
# RUN apk update && apk add --no-cache bash
RUN apk update
RUN apk add --no-cache --virtual .build-deps gcc libc-dev libxslt-dev && \
    apk add --no-cache libxslt && \
    apk add --no-cache libmagic && \
    apk add --no-cache zsh && \
    apk add --no-cache curl && \
    apk add --no-cache git && \
    apk add --no-cache util-linux

# Install Oh My Zsh for Root and Node user
# RUN bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
RUN sh -c "$(wget https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh -O -)"

COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt
# RUN pip install pytest
RUN apk del .build-deps

FROM base as build_development
WORKDIR /opt/${PROJECT_NAME}

FROM base as build_production
# Create a group and user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup
RUN cp -R /root/.oh-my-zsh /home/appuser && \
    cp /root/.zsh* /home/appuser && \
    sed -i "s/\/root/\/home\/appuser/g" /home/appuser/.zshrc
COPY . /home/appuser/${PROJECT_NAME}/
WORKDIR /home/appuser/${PROJECT_NAME}
RUN chown -R appuser:appgroup /home/appuser
USER appuser

FROM build_${BUILD_ENV}
CMD ["zsh"]
