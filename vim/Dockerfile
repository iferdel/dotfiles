FROM ubuntu:24.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    vim \
    && rm -rf /var/lib/apt/lists/*

COPY .vimrc /root/.vimrc

WORKDIR /root
CMD ["bash"]
