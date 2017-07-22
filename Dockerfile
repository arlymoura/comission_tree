FROM ruby:2.3.3
RUN mkdir -p /ardom_manager
WORKDIR /ardom_manager
RUN apt-get update && apt-get install -y nodejs --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y postgresql postgresql-client postgresql-contrib --no-install-recommends && rm -rf /var/lib/apt/lists/*
RUN apt-get update && apt-get install -y graphviz --no-install-recommends && rm -rf /var/lib/apt/lists/*
COPY Gemfile /ardom_manager
RUN bundle install
COPY . /ardom_manager
EXPOSE 3000
CMD puma -C config/puma.rb
