# Используем базовый образ с Ruby 3.1.4
FROM ruby:3.1.4

# Устанавливаем необходимые системные зависимости
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn

# Устанавливаем рабочую директорию в контейнере
WORKDIR /app

# Копируем Gemfile и Gemfile.lock в контейнер
COPY Gemfile Gemfile.lock ./

# Устанавливаем гемы
RUN bundle install

# Копируем весь проект в контейнер
COPY . .

# Удаляем PID-файл, если он остался
RUN rm -f tmp/pids/server.pid

# Открываем порт 3000 для доступа
EXPOSE 3000

# Запуск Rails-сервера
CMD ["bin/rails", "server", "-b", "0.0.0.0"]
