# encoding: utf-8
require 'retriever/retriever.rb'
require File.dirname(__FILE__) + '/../../app/models/movie.rb'

ActiveRecord::Base.establish_connection(
  database: 'movies_server_development',
  host:     'localhost',
  adapter:  'postgresql',
  encoding: 'unicode',
  username: 'postgres',
  password: '4242424242',
  timeout:  5000,
  pool:     5
)

class BatchRetriever

  def initialize input_file='db/input/example.txt'
    puts "  ==> READING... #{input_file}"
    @movies = []

    file = File.new("#{input_file}", 'r')
    while line = file.gets
      @movies << line.split("\n").first
    end
    file.close
  end

  def work
    puts '  ==> WORKING...'
    @movies.each do |movie|
      movie_retriever = Retriever.new(movie)
      movie_alias     = movie_retriever.alias

      if in_database? movie_alias
        puts "       DATABASE == #{movie_retriever.name} (#{movie_retriever.alias})"
      else
        puts "       SEARCH == #{movie_retriever.name} (#{movie_retriever.name_formated})"
        movie_retriever.search
        database_insert movie_alias, movie_retriever.response if movie_retriever.completed?
      end
    end
    return
  end

private

  def in_database? name
    Movie.find_by_alias(name)
  end

  def database_insert name, data
    begin
      Movie.create!(data)
    rescue Exception
      puts " => ALREADY IN DATABASE"
    end
  end

end
